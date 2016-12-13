# encoding: utf-8
#
# Copyright (c) 2016 Yegor Bugayenko
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the 'Software'), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

require 'timeout'
require_relative 'git_repo'
require_relative 'github_tickets'
require_relative 'puzzles'
require_relative 'safe_storage'
require_relative 's3'

#
# One job.
#
class Job
  def initialize(repo, storage, tickets)
    @repo = repo
    @storage = storage
    @tickets = tickets
  end

  def proceed
    if ENV['RACK_ENV'] == 'test'
      exclusive
    else
      Process.detach(fork { exclusive })
    end
  end

  private

  def exclusive
    f = File.open(@repo.lock, File::RDWR | File::CREAT, 0o644)
    Timeout.timeout(10) do
      f.flock(File::LOCK_EX)
      sleep(5) unless ENV['RACK_ENV'] == 'test'
      run
      f.close
    end
  end

  def run
    @repo.push
    Puzzles.new(
      @repo,
      SafeStorage.new(
        @storage
      )
    ).deploy(@tickets)
  end
end