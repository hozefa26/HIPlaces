# HIPlaces

[![CI Status](http://img.shields.io/travis/Hozefa Indorewala/HIPlaces.svg?style=flat)](https://travis-ci.org/Hozefa Indorewala/HIPlaces)
[![Version](https://img.shields.io/cocoapods/v/HIPlaces.svg?style=flat)](http://cocoadocs.org/docsets/HIPlaces)
[![License](https://img.shields.io/cocoapods/l/HIPlaces.svg?style=flat)](http://cocoadocs.org/docsets/HIPlaces)
[![Platform](https://img.shields.io/cocoapods/p/HIPlaces.svg?style=flat)](http://cocoadocs.org/docsets/HIPlaces)

An Objective - C wrapper for the [Google Places API][1]. The library currently includes

1. [Place Autocomplete][2]
2. [Place Details][3]

## Usage

### Example
To run the HIPlacesExample project, clone the repo, and run `pod install` from the HIPlaces directory first. Don't forget to replace the "YOUR_KEY_HERE" string in HIPlaceAutocompleteViewController.m & HIPlaceDetailsTableViewController.m with your Google API key. If you don't have one then obtain one from the [Google Developers Console][4].

### API

## Requirements

You need a valid Google API key which you can obtain from the [Google Developers Console][4]. Once you have a key, replace the "YOUR_KEY_HERE" string in HIPlaceAutocompleteViewController.m & HIPlaceDetailsTableViewController.m with your Google API key.

## Installation

HIPlaces is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

    pod "HIPlaces"

## Author

Hozefa Indorewala, me@hozefaindorewala.com

## License

HIPlaces is available under the MIT license. See the LICENSE file for more info.


[1]: https://developers.google.com/places/documentation/
[2]: https://developers.google.com/places/documentation/autocomplete
[3]: https://developers.google.com/places/documentation/details
[4]: https://console.developers.google.com
