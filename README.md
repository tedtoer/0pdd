<img src="https://avatars2.githubusercontent.com/u/24456188" width="64px" height="64px"/>

[![Managed by Zerocracy](http://www.0crat.com/badge/C3T46CUJJ.svg)](http://www.0crat.com/p/C3T46CUJJ)
[![DevOps By Rultor.com](http://www.rultor.com/b/yegor256/0pdd)](http://www.rultor.com/p/yegor256/0pdd)
[![We recommend RubyMine](http://img.teamed.io/rubymine-recommend.svg)](https://www.jetbrains.com/ruby/)

[![Availability at SixNines](http://www.sixnines.io/b/574a)](http://www.sixnines.io/h/574a)
[![Webhook via ReHTTP](http://www.rehttp.net/b?u=http%3A%2F%2Fwww.0pdd.com%2Fhook%2Fgithub)](http://www.rehttp.net/i?u=http%3A%2F%2Fwww.0pdd.com%2Fhook%2Fgithub)

[![Build Status](https://travis-ci.org/yegor256/0pdd.svg)](https://travis-ci.org/yegor256/0pdd)
[![PDD status](http://www.0pdd.com/svg?name=yegor256/0pdd)](http://www.0pdd.com/p?name=yegor256/0pdd)
[![Dependency Status](https://gemnasium.com/yegor256/0pdd.svg)](https://gemnasium.com/yegor256/0pdd)
[![Code Climate](http://img.shields.io/codeclimate/github/yegor256/0pdd.svg)](https://codeclimate.com/github/yegor256/0pdd)
[![Test Coverage](https://img.shields.io/codecov/c/github/yegor256/0pdd.svg)](https://codecov.io/github/yegor256/0pdd?branch=master)

## What does it do?

Read this blog post first: [PDD in Action](http://www.yegor256.com/2017/04/05/pdd-in-action.html)

[0pdd.com](http://www.0pdd.com) is a hosted service that
finds new "puzzles" in your repository and posts them as GitHub
issues. To start using it just create a
[Webhook](https://developer.github.com/webhooks/creating/) in your repository
just for `push` events  with `http://www.0pdd.com/hook/github` payload URL and
`application/json` content type.

Then, add [@0pdd](https://github.com/0pdd) GitHub user as a
[collaborator](https://help.github.com/articles/inviting-collaborators-to-a-personal-repository/)
with read-only access to your repository.

Then, add a `@todo` [puzzle](http://www.yegor256.com/2009/03/04/pdd.html)
to the source code (format it [right](https://github.com/teamed/pdd)).

Then, `git push` something and see what happens. You should see a new
issue created in your repository by [@0pdd](https://github.com/0pdd).

Don't forget to add that cute little badge to your `README.md`, just
like we did here in this repo (see above). The Markdown you need
will look like this (replace `yegor256/0pdd` with GitHub coordinates
of your own repository):

```markdown
[![PDD status](http://www.0pdd.com/svg?name=yegor256/0pdd)](http://www.0pdd.com/p?name=yegor256/0pdd)
```

## How to configure?

The only way to configure 0pdd is to add `.0pdd.yml` file to the
root directory of your `master` branch (see [this one](https://github.com/yegor256/0pdd/blob/master/.0pdd.yml) as a live example).
It has to be a [YAML](https://en.wikipedia.org/wiki/YAML) file with the following
optional parameters inside:

```yaml
errors:
  - yegor256@gmail.com
alerts:
  github:
    - yegor256
```

Section `errors` allows you to specify a list of email addresses which will
receive notifications when PDD processing fails for your repo. It's
a very useful feature, since very often programmers make
mistakes in PDD puzzle formatting. We would recommend you use this feature.

Section `alerts` allows you to specify users that will be notified when
new PDD puzzles show us. By default we will just submit GitHub tickets
and that's it. If you add `github` subsection there, you can list GitHub
users who will be notified.

[pdd](https://github.com/yegor256/pdd) is the tool that parses your source
code files. You can configure its behavior by adding `.pdd` file to the
root directory of the repository. Take
[this one](https://github.com/yegor256/0pdd/blob/master/.pdd), as an example.

## How to contribute?

Just submit a pull request. Make sure `rake` passes.

## How to install in Heroku

Don't forget this:

```
heroku buildpacks:add --index 1 https://github.com/heroku/heroku-buildpack-apt
```

## License

(The MIT License)

Copyright (c) 2016-2017 Yegor Bugayenko

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the 'Software'), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
