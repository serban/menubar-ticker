# Development Cheatsheet

## Generate a new CFBundleVersion

```fish
date -u '+%Y%m%d%H%M%S'
```

## Tag a release

```fish
git tag --annotate --message='' vX.Y.Z
```

## Make a build in Xcode

1. Product > Archive
1. Select the new archive in the Organizer. Click "Distribute App".
1. Select "Copy App".
1. Click "Export".

## Package the app bundle

```fish
tar cvjf menubar-ticker-vX.Y.Z.tar.bz2 'Menu Bar Ticker.app'
```

## Reset access approvals for Music and Spotify

```fish
tccutil reset All org.serban.MenuBarTicker
```
