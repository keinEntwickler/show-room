# show-room

## The architecture of this repository

The repository consists of 3 major elements, the `app`, `fragments` and `features`.
The first two are `Xcode projects` and the last one is a `swift package`. They are all bundled up in a 
`Xcode workspace`. 

The `App` is the product which should be distributed over `TestFlight` and later published in the `AppStore`.
Currently there are two configurations `release` and `debug`. This could change in the future.

The `Fragments` are isolated parts of the `App`. They are used for development and testing new features and user flows with different
configurations/environments. For example with a preset of gps coordinates instead of using `CoreLocation` or an amount of `HTTP responses`
to simulate different cases (happy and errors).

The heart of the repository is the `swift package` called `Features`. For simplicity it is only one Package with many `targets`.
It contains not only features but also independent and encapsulated units which are used by other targets.

## Swift Package Plugins

For now we have to do it by our own - especially for [swiftlint](https://github.com/realm/SwiftLint).
