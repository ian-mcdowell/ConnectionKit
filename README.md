# ConnectionKit

<p align="center">
  <a href="https://github.com/IMcD23/Git">Git</a> &bull;
  <b>ConnectionKit</b>
</p>

--------

A standardized interface for communicating with file servers over various protocols.

[![Build Status](http://img.shields.io/travis/IMcD23/ConnectionKit.svg)](https://travis-ci.org/IMcD23/ConnectionKit)
[![Version](https://img.shields.io/github/release/IMcD23/ConnectionKit.svg)](https://github.com/IMcD23/ConnectionKit/releases/latest)
![Package Managers](https://img.shields.io/badge/supports-Carthage-orange.svg)
[![Contact](https://img.shields.io/badge/contact-%40ian__mcdowell-3a8fc1.svg)](https://twitter.com/ian_mcdowell)



# Requirements

* Xcode 9 or later
* iOS 10.0 or later

# Usage

This framework acts as a bridge between an app and various connection protocols. It defines an interface for communicating with them, as well as a way of discovering available protocols at runtime.

Each protocol should be its own framework, bundled inside of the running app's main bundle. Each framework should:
* Be bundled in the `Frameworks/Connections` folder.
* Have an NSPrincipalClass set to an object conforming to the `ServerConnection` protocol.



# Author
Created by [Ian McDowell](https://ianmcdowell.net)

# License
All code in this project is available under the license specified in the LICENSE file.
