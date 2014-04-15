# GAEChannel-iOS

GAEChannel-iOS is a iOS client library for Google Channel API ([Python](https://developers.google.com/appengine/docs/python/channel/), [Java](https://developers.google.com/appengine/docs/java/channel/)). Tested with **XCode 5**, **iOS 7.0**, **7.1 SDK**

## Key Idea

Javascript client library of Google Channel API is based on XHR (XMLHttpRequest) in modern browser. In iOS Safari and Webview (UIWebView), the library works properly. So, GAEChannel-iOS creates a hidden webview programmatically and loads Javascript client library for Google Channel API.

## How to Use

1. Download framework file (GAEChannel.framework) and bundle file (GAEChannel.bundle) and Add it to your XCode project. (or clone this repository and build project, then you can get framework and bundle file.)
2. Create class with GAEChannelDelegate protocol.
3. Create GAEChannel object with your GAE application address and the delegate object.

More detail description will be soon.

## License

The MIT License

Copyright (c) 2014 Chiwan Park

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
