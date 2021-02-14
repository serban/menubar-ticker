# menubar-ticker - Show the current song

Menu Bar Ticker is a simple macOS menu bar item that displays the current artist
and song playing in Music (aka
[iTunes](https://support.apple.com/en-us/HT210200)) or Spotify.

There are no other fancy features.

### Idle
![Light - Idle](/screenshots/light-idle.png?raw=true)
![Dark - Idle](/screenshots/dark-idle.png?raw=true)

### Active
![Light - Active](/screenshots/light-active.png?raw=true)
![Dark - Active](/screenshots/dark-active.png?raw=true)


## Installation

Download the
[latest release](https://github.com/serban/menubar-ticker/releases/latest) and
extract `Menu Bar Ticker.app` from the `menubar-ticker-vX.Y.Z.tar.bz2` archive.
Move it into the `Applications` folder. Follow Apple's instructions to
[start the app automatically](https://support.apple.com/kb/ph25590)
when you log in.

Since the app is
[not](https://support.apple.com/en-us/HT202491)
[signed](https://support.apple.com/guide/mac-help/open-a-mac-app-from-an-unidentified-developer-mh40616/mac),
you will need to
[right-click](https://support.apple.com/guide/mac-help/right-click-mh35853/mac)
and select "Open" the first time you launch the app. A dialog will appear:

> "Menu Bar Ticker.app" can't be opened because Apple cannot check it for
> malicious software.

Click "Open". If the app does not appear in the menu bar, right-click on the app
again and select "Open".

The first time you run Music or Spotify together with Menu Bar Ticker, a dialog
will appear for each app:

> "Menu Bar Ticker.app" wants access to control "Music.app". Allowing control
> will provide access to documents and data in "Music.app", and to perform
> actions within that app.
>
> Menu Bar Ticker needs permission to read the current song.

Click "OK".

## Changelog

This project lives at [GitHub](https://github.com/serban/menubar-ticker).
Version numbers follow the [Semantic Versioning](https://semver.org)
specification.

### v2.0.0

* Add support for Apple Silicon
* Drop support for pre-Catalina macOS (use v1 if you're running an older macOS)
* Drop support for pre-Catalina iTunes.app
* Drop support for Rdio (RIP)

Verified to work with the following on February 14, 2021:

* macOS Catalina (10.15.7)
* macOS Big Sur (11.2.1)
* Music 1.0.6.10
* Music 1.1.3.3
* Spotify 1.1.52.687.gf5565fe5

### v1.1.0

* Add support for Music.app in macOS Catalina

Verified to work with the following on January 28, 2020:

* macOS High Sierra (10.13.6)
* macOS Catalina (10.15.2)
* iTunes 12.8.2.3
* Music 1.0.2.37
* Spotify 1.1.24.91.g4ca6d5eb

### v1.0.0

* First release with support for iTunes, Rdio, and Spotify

Verified to work with the following on July 19, 2019:

* macOS High Sierra (10.13.6)
* macOS Mojave (10.14.5)
* iTunes 12.8.2.3
* iTunes 12.9.5.5
* Spotify 1.1.10.540.gfcf0430f


## Contributors

* [Jonathan Anderson](https://github.com/trombonehero)
* [Robin Macharg](https://github.com/robinmacharg)
