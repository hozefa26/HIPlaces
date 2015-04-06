#
# Be sure to run `pod lib lint HIPlaces.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "HIPlaces"
  s.version          = "0.1.0"
  s.summary          = "An Objective - C wrapper for the Google Places API."
  s.description      = <<-DESC
                        An Objective - C wrapper for the Google Places API. The library currently includes

                        1. Place Autocomplete
                        2. Place Details
                       DESC
  s.homepage         = "https://github.com/hozefa26/HIPlaces"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "Hozefa Indorewala" => "me@hozefaindorewala.com" }
  s.source           = { :git => "https://github.com/hozefa26/HIPlaces.git", :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/h_indorewala'

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  s.resource_bundles = {
    'HIPlaces' => ['Pod/Assets/*.png']
  }

  s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  s.dependency 'AFNetworking', '~> 2.0'
end
