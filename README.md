# React Native WebView - a Modern, Cross-Platform WebView for React Native

[![star this repo](http://githubbadges.com/star.svg?user=react-native-community&repo=react-native-webview&style=flat)](https://github.com/react-native-community/react-native-webview) 
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg?style=flat-square)](http://makeapullrequest.com) 
[![All Contributors](https://img.shields.io/badge/all_contributors-16-orange.svg?style=flat-square)](#contributors) 
[![Known Vulnerabilities](https://snyk.io/test/github/react-native-community/react-native-webview/badge.svg?style=flat-square)](https://snyk.io/test/github/react-native-community/react-native-webview)
<a href="https://www.npmjs.com/package/react-native-webview"><img src="https://img.shields.io/npm/v/react-native-webview.svg"></a>

**React Native WebView** is a modern, well-supported, and cross-platform WebView for React Native. It is intended to be a replacement for the built-in WebView (which will be [removed from core](https://github.com/react-native-community/discussions-and-proposals/pull/3)).

This fork of the React Native WebView provides support for authentication challenges by introducing a username/password panel that can be populated and submitted to complete the authentication request.

## Core Maintainers - Sponsoring companies

_This project is maintained by:

- [Colin Smith]
- [Adrian Bocker](https://github.com/Gitamonster)

## Platforms Supported

- [x] iOS (both UIWebView and WKWebView)
- [x] Android

_Note: Expo support for React Native WebView started with [Expo SDK v33.0.0](https://blog.expo.io/expo-sdk-v33-0-0-is-now-available-52d1c99dfe4c)._

## Getting Started

Read our [Getting Started Guide](docs/Getting-Started.md). If any step seems unclear, please create a detailed issue.

## Versioning

This project follows [semantic versioning](https://semver.org/). We do not hesitate to release breaking changes but they will be in a major version.

**Breaking History:**

Current Version: ![version](https://img.shields.io/npm/v/react-native-webview.svg)

yarn add react-native-webview@androidx
- [6.0.**2**](https://github.com/react-native-community/react-native-webview/releases/tag/v6.0.2) - Update to AndroidX. Make sure to enable it in your project's `android/gradle.properties`. See [Getting Started Guide](docs/Getting-Started.md).

yarn add react-native-webview
- [5.0.**1**](https://github.com/react-native-community/react-native-webview/releases/tag/v5.0.0) - Refactored the old postMessage implementation for communication from webview to native.
- [4.0.0](https://github.com/react-native-community/react-native-webview/releases/tag/v4.0.0) - Added cache (enabled by default).
- [3.0.0](https://github.com/react-native-community/react-native-webview/releases/tag/v3.0.0) - WKWebview: Add shared process pool so cookies and localStorage are shared across webviews in iOS (enabled by default).
- [2.0.0](https://github.com/react-native-community/react-native-webview/releases/tag/v2.0.0) - First release this is a replica of the core webview component

**Upcoming:**

- UIWebView removal
- this.webView.postMessage() removal (never documented and less flexible than injectJavascript)
- Kotlin rewrite
- Maybe Swift rewrite

## Usage

Import the `WebView` component from `react-native-webview` and use it like so:

```jsx
import React, { Component } from 'react';
import { StyleSheet, Text, View } from 'react-native';
import { WebView } from 'react-native-webview';

// ...
class MyWebComponent extends Component {
  render() {
    return (
      <WebView source={{ uri: 'https://facebook.github.io/react-native/' }} />
    );
  }
}
```

For more, read the [API Reference](./docs/Reference.md) and [Guide](./docs/Guide.md). If you're interested in contributing, check out the [Contributing Guide](./docs/Contributing.md).

## Common issues

- If you're getting `Invariant Violation: Native component for "RNCWKWebView does not exist"` it likely means you forgot to run `react-native link` or there was some error with the linking process

## Contributing

See [Contributing.md](https://github.com/react-native-community/react-native-webview/blob/master/docs/Contributing.md)

## Contributors

Thanks goes to these wonderful people ([emoji key](https://github.com/all-contributors/all-contributors#emoji-key-)):

<!-- ALL-CONTRIBUTORS-LIST:START - Do not remove or modify this section -->
<!-- prettier-ignore -->
<table><tr><td align="center"><a href="https://twitter.com/titozzz"><img src="https://avatars1.githubusercontent.com/u/6181446?v=4" width="100px;" alt="Thibault Malbranche"/><br /><sub><b>Thibault Malbranche</b></sub></a><br /><a href="https://github.com/react-native-community/react-native-webview/commits?author=titozzz" title="Code">💻</a> <a href="#ideas-titozzz" title="Ideas, Planning, & Feedback">🤔</a> <a href="#review-titozzz" title="Reviewed Pull Requests">👀</a> <a href="https://github.com/react-native-community/react-native-webview/commits?author=titozzz" title="Documentation">📖</a> <a href="#maintenance-titozzz" title="Maintenance">🚧</a> <a href="https://github.com/react-native-community/react-native-webview/commits?author=titozzz" title="Tests">⚠️</a> <a href="#infra-titozzz" title="Infrastructure (Hosting, Build-Tools, etc)">🚇</a> <a href="#question-titozzz" title="Answering Questions">💬</a></td><td align="center"><a href="https://jamonholmgren.com"><img src="https://avatars3.githubusercontent.com/u/1479215?v=4" width="100px;" alt="Jamon Holmgren"/><br /><sub><b>Jamon Holmgren</b></sub></a><br /><a href="https://github.com/react-native-community/react-native-webview/commits?author=jamonholmgren" title="Code">💻</a> <a href="#ideas-jamonholmgren" title="Ideas, Planning, & Feedback">🤔</a> <a href="#review-jamonholmgren" title="Reviewed Pull Requests">👀</a> <a href="https://github.com/react-native-community/react-native-webview/commits?author=jamonholmgren" title="Documentation">📖</a> <a href="#maintenance-jamonholmgren" title="Maintenance">🚧</a> <a href="https://github.com/react-native-community/react-native-webview/commits?author=jamonholmgren" title="Tests">⚠️</a> <a href="#example-jamonholmgren" title="Examples">💡</a> <a href="#question-jamonholmgren" title="Answering Questions">💬</a></td><td align="center"><a href="https://github.com/andreipfeiffer"><img src="https://avatars1.githubusercontent.com/u/2570562?v=4" width="100px;" alt="Andrei Pfeiffer"/><br /><sub><b>Andrei Pfeiffer</b></sub></a><br /><a href="https://github.com/react-native-community/react-native-webview/commits?author=andreipfeiffer" title="Code">💻</a> <a href="#review-andreipfeiffer" title="Reviewed Pull Requests">👀</a> <a href="#ideas-andreipfeiffer" title="Ideas, Planning, & Feedback">🤔</a></td><td align="center"><a href="https://twitter.com/mikediarmid"><img src="https://avatars0.githubusercontent.com/u/5347038?v=4" width="100px;" alt="Michael Diarmid"/><br /><sub><b>Michael Diarmid</b></sub></a><br /><a href="https://github.com/react-native-community/react-native-webview/commits?author=Salakar" title="Code">💻</a> <a href="#review-Salakar" title="Reviewed Pull Requests">👀</a> <a href="#ideas-Salakar" title="Ideas, Planning, & Feedback">🤔</a> <a href="#tool-Salakar" title="Tools">🔧</a></td><td align="center"><a href="http://smathson.github.io"><img src="https://avatars3.githubusercontent.com/u/932981?v=4" width="100px;" alt="Scott Mathson"/><br /><sub><b>Scott Mathson</b></sub></a><br /><a href="https://github.com/react-native-community/react-native-webview/commits?author=smathson" title="Code">💻</a> <a href="https://github.com/react-native-community/react-native-webview/commits?author=smathson" title="Documentation">📖</a></td><td align="center"><a href="https://github.com/YangXiaomei"><img src="https://avatars0.githubusercontent.com/u/8221990?v=4" width="100px;" alt="Margaret"/><br /><sub><b>Margaret</b></sub></a><br /><a href="https://github.com/react-native-community/react-native-webview/commits?author=YangXiaomei" title="Code">💻</a> <a href="https://github.com/react-native-community/react-native-webview/commits?author=YangXiaomei" title="Documentation">📖</a></td><td align="center"><a href="https://stylisted.com"><img src="https://avatars2.githubusercontent.com/u/1173161?v=4" width="100px;" alt="Jordan Sexton"/><br /><sub><b>Jordan Sexton</b></sub></a><br /><a href="https://github.com/react-native-community/react-native-webview/commits?author=jordansexton" title="Code">💻</a> <a href="https://github.com/react-native-community/react-native-webview/commits?author=jordansexton" title="Documentation">📖</a></td></tr><tr><td align="center"><a href="https://github.com/MalcolmScruggs"><img src="https://avatars1.githubusercontent.com/u/22333355?v=4" width="100px;" alt="Malcolm Scruggs"/><br /><sub><b>Malcolm Scruggs</b></sub></a><br /><a href="https://github.com/react-native-community/react-native-webview/commits?author=MalcolmScruggs" title="Code">💻</a> <a href="#tool-MalcolmScruggs" title="Tools">🔧</a> <a href="https://github.com/react-native-community/react-native-webview/commits?author=MalcolmScruggs" title="Tests">⚠️</a></td><td align="center"><a href="https://github.com/Momazo7u7"><img src="https://avatars0.githubusercontent.com/u/42069617?v=4" width="100px;" alt="Momazo7u7"/><br /><sub><b>Momazo7u7</b></sub></a><br /><a href="https://github.com/react-native-community/react-native-webview/commits?author=Momazo7u7" title="Documentation">📖</a></td><td align="center"><a href="https://marco-nett.de"><img src="https://avatars1.githubusercontent.com/u/3315507?v=4" width="100px;" alt="Marco"/><br /><sub><b>Marco</b></sub></a><br /><a href="https://github.com/react-native-community/react-native-webview/commits?author=marconett" title="Documentation">📖</a></td><td align="center"><a href="https://github.com/jeluard"><img src="https://avatars1.githubusercontent.com/u/359723?v=4" width="100px;" alt="Julien Eluard"/><br /><sub><b>Julien Eluard</b></sub></a><br /><a href="https://github.com/react-native-community/react-native-webview/commits?author=jeluard" title="Documentation">📖</a></td><td align="center"><a href="https://github.com/CubeSugar"><img src="https://avatars3.githubusercontent.com/u/3667305?v=4" width="100px;" alt="Jian Wei"/><br /><sub><b>Jian Wei</b></sub></a><br /><a href="https://github.com/react-native-community/react-native-webview/commits?author=CubeSugar" title="Code">💻</a> <a href="https://github.com/react-native-community/react-native-webview/commits?author=CubeSugar" title="Documentation">📖</a></td><td align="center"><a href="https://www.linkedin.com/in/svbutko/"><img src="https://avatars2.githubusercontent.com/u/14828004?v=4" width="100px;" alt="Sergei Butko"/><br /><sub><b>Sergei Butko</b></sub></a><br /><a href="https://github.com/react-native-community/react-native-webview/commits?author=svbutko" title="Documentation">📖</a></td><td align="center"><a href="https://github.com/TMomemt"><img src="https://avatars3.githubusercontent.com/u/42024947?v=4" width="100px;" alt="TMomemt"/><br /><sub><b>TMomemt</b></sub></a><br /><a href="https://github.com/react-native-community/react-native-webview/commits?author=TMomemt" title="Code">💻</a></td></tr><tr><td align="center"><a href="http://www.try.com"><img src="https://avatars0.githubusercontent.com/u/674503?v=4" width="100px;" alt="Eric Lewis"/><br /><sub><b>Eric Lewis</b></sub></a><br /><a href="https://github.com/react-native-community/react-native-webview/commits?author=ericlewis" title="Code">💻</a> <a href="https://github.com/react-native-community/react-native-webview/commits?author=ericlewis" title="Documentation">📖</a></td><td align="center"><a href="https://bzfx.net"><img src="https://avatars2.githubusercontent.com/u/1542454?v=4" width="100px;" alt="Daniel Vicory"/><br /><sub><b>Daniel Vicory</b></sub></a><br /><a href="https://github.com/react-native-community/react-native-webview/commits?author=dvicory" title="Code">💻</a> <a href="https://github.com/react-native-community/react-native-webview/commits?author=dvicory" title="Documentation">📖</a></td></tr></table>

<!-- ALL-CONTRIBUTORS-LIST:END -->

This project follows the [all-contributors](https://github.com/all-contributors/all-contributors) specification. Contributions of any kind welcome!

## License

MIT
