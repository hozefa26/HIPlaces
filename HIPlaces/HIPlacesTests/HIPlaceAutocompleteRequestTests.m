//
//  HIPlaceAutocompleteRequestTests.m
//  HIPlaces
//
//  Created by Hozefa Indorewala on 23/01/15.
//  Copyright (c) 2015 Hozefa Indorewala. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import <CoreLocation/CoreLocation.h>

#import "HIPlaceAutocompleteRequest.h"
#import "HIPlacesConstants.h"

@interface HIPlaceAutocompleteRequestTests : XCTestCase
{
    HIPlaceAutocompleteRequest *_placeAutocompleteRequest;
}
@end

@implementation HIPlaceAutocompleteRequestTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    _placeAutocompleteRequest = [[HIPlaceAutocompleteRequest alloc] init];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    _placeAutocompleteRequest = nil;
    [super tearDown];
}

- (void)testThatPlaceAutocompleteRequestExists
{
    XCTAssertNotNil(_placeAutocompleteRequest, @"Should be able to create HIPlaceAutocompleteRequest instance");
}

- (void)testThatPlaceAutocompleteRequestHasInput
{
    _placeAutocompleteRequest.input = @"FakeInput";
    XCTAssertEqual(_placeAutocompleteRequest.input, @"FakeInput", @"PlaceAutocompleteRequest should have input");
}

- (void)testThatPlaceAutocompleteRequestHasKey
{
    _placeAutocompleteRequest.key = @"FakeKey";
    XCTAssertEqual(_placeAutocompleteRequest.key, @"FakeKey", @"PlaceAutocompleteRequest should have key");
}

- (void)testThatPlaceAutocompleteRequestHasOffset
{
    _placeAutocompleteRequest.offset = 123;
    XCTAssertEqual(_placeAutocompleteRequest.offset, 123, @"PlaceAutocompleteRequest should have offset");
}

- (void)testThatOffsetIsSetToNSNotFoundAsDefault
{
    XCTAssertEqual(_placeAutocompleteRequest.offset, NSNotFound, @"Offset should be set to NSNotFound as default");
}

- (void)testThatPlaceAutocompleteRequestHasLocation
{
    _placeAutocompleteRequest.location = CLLocationCoordinate2DMake(90.0, 90.0);
    XCTAssertEqual(_placeAutocompleteRequest.location.longitude, 90.0, @"PlaceAutocompleteRequest should have location");
    XCTAssertEqual(_placeAutocompleteRequest.location.latitude, 90.0, @"PlaceAutocompleteRequest should have location");
}

- (void)testThatLocationIsSetToNSNotFoundAsDefault
{
    XCTAssertEqual(_placeAutocompleteRequest.location.latitude, NSNotFound, @"Location should be set to NSNotFound as default");
    XCTAssertEqual(_placeAutocompleteRequest.location.longitude, NSNotFound, @"Location should be set to NSNotFound as default");
}

- (void)testThatPlaceAutocompleteRequestHasRadius
{
    _placeAutocompleteRequest.radius = 123;
    XCTAssertEqual(_placeAutocompleteRequest.radius, 123, @"PlaceAutocompleteRequest should have radius");
}

- (void)testThatRadiusIsSetToNSNotFoundAsDefault
{
    XCTAssertEqual(_placeAutocompleteRequest.radius, NSNotFound, @"Radius should be set to NSNotFound as default");
}

- (void)testThatPlaceAutocompleteRequestHasPlaceType
{
    _placeAutocompleteRequest.placeType = HIPlaceTypeGeocode;
    XCTAssertEqual(_placeAutocompleteRequest.placeType, HIPlaceTypeGeocode, @"PlaceAutocompleteRequest should have place type");
}

- (void)testThatPlaceTypeIsSetToHIPlaceTypeNoneAsDefault
{
    XCTAssertEqual(_placeAutocompleteRequest.placeType, HIPlaceTypeNone, @"Place type should be set to HIPlaceTypeNone as default");

}

@end
