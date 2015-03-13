//
//  HIPlaceAutocompleteResultTests.m
//  HIPlaces
//
//  Created by Hozefa Indorewala on 22/01/15.
//  Copyright (c) 2015 Hozefa Indorewala. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

#import "HIPlaceAutocompleteResult.h"
#import "HIPlacesConstants.h"
#import "HIPlaceTypes.h"

@interface HIPlaceAutocompleteResultTests : XCTestCase
{
    HIPlaceAutocompleteResult *_placeAutocompleteResult;
}
@end

@implementation HIPlaceAutocompleteResultTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    NSDictionary *placeAutocompleteAttributes = @{@"place_id": @"FakePlaceId",
                                                  @"description": @"FakePlaceDescription",
                                                  @"types": @[@"geocode", @"establishment"]
                                                  };
    _placeAutocompleteResult = [[HIPlaceAutocompleteResult alloc] initWithPlaceAutocompleteAttributes:placeAutocompleteAttributes];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    _placeAutocompleteResult = nil;
    [super tearDown];
}

- (void)testThatPlaceAutcompleteResultExists
{
    XCTAssertNotNil(_placeAutocompleteResult, @"Should be able to create HIPlaceAutocompleteResult instance");
}

- (void)testThatPlaceAutocompleteResultHasPlaceDescription
{
    XCTAssertEqual(_placeAutocompleteResult.placeDescription, @"FakePlaceDescription", @"HIPlaceAutocompleteResult should have place description");
}

- (void)testThatPlaceAutocompleteResultHasPlaceId
{
    XCTAssertEqual(_placeAutocompleteResult.placeId, @"FakePlaceId", @"HIPlaceAutocompleteResult should have place description");
}

- (void)testThatPlaceAutocompleteResultHasPlaceTypes
{
    NSArray *expectedPlaceTypes = @[[NSNumber numberWithUnsignedInteger:HIPlaceTypeGeocode], [NSNumber numberWithUnsignedInteger:HIPlaceTypeEstablishment]];
    XCTAssertEqualObjects(_placeAutocompleteResult.placeTypes, expectedPlaceTypes, @"HIPlaceAutocompleteResult should have place types");
}

- (void)testThatPlaceIdMustExistDuringInit
{
    NSDictionary *placeAutocompleteAttributes = @{@"description": @"FakePlaceDescription",
                                                  @"types": @[@"geocode", @"establishment"]
                                                  };
    XCTAssertThrows([[HIPlaceAutocompleteResult alloc] initWithPlaceAutocompleteAttributes:placeAutocompleteAttributes], @"PlaceId must be present in attributes");
}

@end
