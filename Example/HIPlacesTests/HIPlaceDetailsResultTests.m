//
//  HIPlaceDetailsResultTests.m
//  HIPlaces
//
//  Created by Hozefa Indorewala on 02/02/15.
//  Copyright (c) 2015 Hozefa Indorewala. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import <CoreLocation/CoreLocation.h>

#import "HIPlaceDetailsResult.h"
#import "HIPlaceTypes.h"

@interface HIPlaceDetailsResultTests : XCTestCase
{
    HIPlaceDetailsResult *_placeDetailsResult;
}
@end

@implementation HIPlaceDetailsResultTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    NSDictionary *placeDetailsAttributes = @{
                                             @"place_id": @"FakePlaceId",
                                             @"formatted_address": @"FakeFormattedAddress",
                                             @"name": @"FakeName",
                                             @"geometry": @{@"location": @{
                                                                     @"lat":@-123.123,
                                                                     @"lng":@-321.321}},
                                             @"types": @[@"establishment", @"geocode"]};
    _placeDetailsResult = [[HIPlaceDetailsResult alloc] initWithPlaceDetailsAttributes:placeDetailsAttributes];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    _placeDetailsResult = nil;
    [super tearDown];
}

- (void)testThatPlaceDetailsResultExists
{
    XCTAssertNotNil(_placeDetailsResult, @"Should be able to create HIPlaceDetailsResult instance");
}

- (void)testThatPlaceDetailsHasPlaceId
{
    XCTAssertEqual(_placeDetailsResult.placeId, @"FakePlaceId", @"PlaceDetails must have placeId");
}

- (void)testThatPlaceDetailsHasFormattedAddress
{
    XCTAssertEqual(_placeDetailsResult.formattedAddress, @"FakeFormattedAddress", @"PlaceDetails must have formatted address");
}

- (void)testThatPlaceDetailsHasName
{
    XCTAssertEqual(_placeDetailsResult.name, @"FakeName", @"PlaceDetails must have name");
}

- (void)testThatPlaceDetailsHasLocation
{
    CLLocationCoordinate2D expectedLocation = CLLocationCoordinate2DMake(-123.123, -321.321);
    XCTAssertEqual(_placeDetailsResult.location.latitude, expectedLocation.latitude, @"PlaceDetails must have location with latitude");
    XCTAssertEqual(_placeDetailsResult.location.longitude, expectedLocation.longitude, @"PlaceDetails must have location with longitude");
}

- (void)testThatPlaceDetailsHasPlaceTypes
{
    NSArray *expectedPlaceTypes = @[[NSNumber numberWithUnsignedInteger:HIPlaceTypeEstablishment], [NSNumber numberWithUnsignedInteger:HIPlaceTypeGeocode]
    ];
    XCTAssertEqualObjects(_placeDetailsResult.placeTypes, expectedPlaceTypes, @"PlaceDetails must have PlaceTypes");
}

- (void)testThatPlaceIdMustExistDuringInit
{
    NSDictionary *placeDetailsAttributes = @{
                                             @"formatted_address": @"FakeFormattedAddress",
                                             @"name": @"FakeName",
                                             @"geometry": @{@"location": @{
                                                                    @"lat":@-123.123,
                                                                    @"lng":@-321.321}},
                                             @"types": @[@"establishment", @"geocode"]};
    XCTAssertThrows([[HIPlaceDetailsResult alloc] initWithPlaceDetailsAttributes:placeDetailsAttributes], @"PlaceId must be present in attributes");
}
@end
