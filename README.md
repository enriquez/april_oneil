# April O'Neil

April O'Neil is a reporter for [Facebook's xctool](http://github.com/facebook/xctool).

## Requirements

* Ruby 2.0 (pre-installed on Mavericks)
* xctool 1.1

## Installation

```bash
gem install april_oneil
```

## Usage

Pass the location of the formatter's executable to xctool's `-reporter` argument.

```bash
xctool -workspace YourProject.xcworkspace \
       -scheme YourProject \
       -sdk iphonesimulator \
       -reporter "$(which ao-kiwi-progress)" \
       test
```

## Formatters

### Kiwi Progress `ao-kiwi-progress`

Used for tests written with [Kiwi](http://github.com/allending/kiwi). Inspired by [RSpec's](http://rspec.info) progress formatter.

Example output:

![Kiwi Progress Passing](https://github.com/enriquez/april_oneil/wiki/readme-assets/ao-kiwi-progress-passing.png)
![Kiwi Progress Pending](https://github.com/enriquez/april_oneil/wiki/readme-assets/ao-kiwi-progress-pending.png)
![Kiwi Progress Compile Error](https://github.com/enriquez/april_oneil/wiki/readme-assets/ao-kiwi-progress-compile-error.png)
![Kiwi Progress Failures](https://github.com/enriquez/april_oneil/wiki/readme-assets/ao-kiwi-progress-failing.png)




## MIT License

Copyright (c) 2013 Michael Enriquez (http://enriquez.me)

MIT License

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
