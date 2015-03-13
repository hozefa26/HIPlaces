//
//  HIPlaceDetailsRequestTests.m
//  HIPlaces
//
//  Created by Hozefa Indorewala on 02/02/15.
//  Copyright (c) 2015 Hozefa Indorewala. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

#import "HIPlaceDetailsRequest.h"

@interface HIPlaceDetailsRequestTests : XCTestCase
{
    HIPlaceDetailsRequest *_placeDetailsRequest;
}
@end

@implementation HIPlaceDetailsRequestTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    _placeDetailsRequest = [[HIPlaceDetailsRequest alloc] init];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    _placeDetailsRequest = nil;
    [super tearDown];
}

- (void)testThatPlaceDetailsRequestExists
{
    XCTAssertNotNil(_placeDetailsRequest, @"Should be able to create HIPlaceDetailsRequest instance");
}

- (void)testThatPlaceDetailsRequestHasKey
{
    _placeDetailsRequest.key = @"FakeKey";
    XCTAssertEqual(_placeDetailsRequest.key, @"FakeKey", @"PlaceDetailsRequest must have a key");
}

- (void)testThatPlaceDetailsRequestHasPlaceId
{
    _placeDetailsRequest.placeId = @"FakePlaceId";
    XCTAssertEqual(_placeDetailsRequest.placeId, @"FakePlaceId", @"PlaceDetailsRequest must have a placeId");
}

@end
