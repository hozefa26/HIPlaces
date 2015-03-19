//
//  HIPlacesManagerTests.m
//  HIPlaces
//
//  Created by Hozefa Indorewala on 23/01/15.
//  Copyright (c) 2015 Hozefa Indorewala. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

#import "MockHIPlacesManager.h"
#import "MockHIPlacesManagerDelegate.h"
#import "HIPlaceAutocompleteRequest.h"
#import "HIPlacesConstants.h"
#import "HIPlaceAutocompleteResult.h"
#import "HIPlaceTypes.h"
#import "HIPlaceDetailsRequest.h"
#import "HIPlaceDetailsResult.h"

@interface HIPlacesManager (Test)

- (NSString *)placeAutocompleteRequestURLStringFromRequest:(HIPlaceAutocompleteRequest *)request;
- (NSArray *)placeAutocompleteResultsForResponse:(NSDictionary *)responseDictionary;
- (NSString *)placeDetailsRequestURLStringFromRequest:(HIPlaceDetailsRequest *)request;
- (HIPlaceDetailsResult *)placeDetailsResultForResponse:(NSDictionary *)responseDictionary;
- (HIGoogleStatusCode)statusCodeForResponse:(NSDictionary *)responseDictionary;
- (NSUInteger)placesErrorForGoogleStatusCode:(HIGoogleStatusCode)googleStatusCode;

@end

@interface HIPlacesManagerTests : XCTestCase
{
    MockHIPlacesManager *_placesManager;
    HIPlaceAutocompleteRequest *_fakePlaceAutocompleteRequest;
    HIPlaceDetailsRequest *_fakePlaceDetailsRequest;
    MockHIPlacesManagerDelegate *_placesManagerDelegate;
    
    NSDictionary *_placeAutocompleteResponseDictionary;
    NSDictionary *_placeDetailsResponseDictionary;
}
@end

@implementation HIPlacesManagerTests


- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    _placesManager = [[MockHIPlacesManager alloc] init];
    
    _fakePlaceAutocompleteRequest = [[HIPlaceAutocompleteRequest alloc] init];
    _fakePlaceAutocompleteRequest.key = @"FakeKey";
    _fakePlaceAutocompleteRequest.input = @"FakeInput";
    
    _fakePlaceDetailsRequest = [[HIPlaceDetailsRequest alloc] init];
    _fakePlaceDetailsRequest.key = @"FakeKey";
    _fakePlaceDetailsRequest.placeId = @"FakePlaceId";
    
    _placesManagerDelegate = [[MockHIPlacesManagerDelegate alloc] init];
    _placesManager.delegate = _placesManagerDelegate;
    
    _placeAutocompleteResponseDictionary = @{@"status": @"OK",
                                             @"predictions": @[
                                                     @{@"description": @"Paris, France",
                                                       @"id": @"691b237b0322f28988f3ce03e321ff72a12167fd",
                                                       @"matched_substrings": @[
                                                               @{@"length": @5,
                                                                 @"offset": @0
                                                                 }
                                                               ],
                                                       @"place_id": @"ChIJD7fiBh9u5kcRYJSMaMOCCwQ",
                                                       @"reference": @"CjQlAAAA_KB6EEceSTfkteSSF6U0pvumHCoLUboRcDlAH05N1pZJLmOQbYmboEi0SwXBSoI2EhAhj249tFDCVh4R-PXZkPK8GhTBmp_6_lWljaf1joVs1SH2ttB_tw",
                                                       @"terms": @[
                                                               @{@"offset": @0,
                                                                 @"value": @"Paris"},
                                                               @{@"offset": @7,
                                                                 @"value": @"France"}
                                                               ],
                                                       @"types": @[@"locality", @"political", @"geocode"]
                                                           },
                                                     @{@"description": @"Paris Avenue, Earlwood, New South Wales, Australia",
                                                       @"id": @"359a75f8beff14b1c94f3d42c2aabfac2afbabad",
                                                       @"matched_substrings": @[
                                                               @{@"length": @5,
                                                                 @"offset": @0
                                                                 }
                                                               ],
                                                       @"place_id": @"ChIJrU3KAHG6EmsR5Uwfrk7azrI",
                                                       @"reference": @"CkQ2AAAARbzLE-tsSQPgwv8JKBaVtbjY48kInQo9tny0k07FOYb3Z_z_yDTFhQB_Ehpu-IKhvj8Msdb1rJlX7xMr9kfOVRIQVuL4tOtx9L7U8pC0Zx5bLBoUTFbw9R2lTn_EuBayhDvugt8T0Oo",
                                                       @"terms": @[
                                                               @{@"offset": @0,
                                                                 @"value": @"Paris Avenue"},
                                                               @{@"offset": @14,
                                                                 @"value": @"Earlwood"},
                                                               @{@"offset": @24,
                                                                 @"value": @"New South Wales"},
                                                               @{@"offset": @41,
                                                                 @"value": @"Australia"}
                                                               ],
                                                       @"types": @[@"route", @"geocode"]
                                                       }
                                                     ]
                                             };
    _placeDetailsResponseDictionary = @{@"html_attributions": @[],
                                        @"result": @{@"formatted_address": @"48 Pirrama Road, Pyrmont NSW, Australia",
                                                     @"geometry": @{@"location": @{ @"lat": @-33.8669710,
                                                                                    @"lng": @151.1958750
                                                                            }
                                                                        },
                                                     @"name": @"Google Sydney",
                                                     @"place_id": @"ChIJN1t_tDeuEmsRUsoyG83frY4",
                                                     @"types": @[@"establishment"]
                                                     },
                                        @"status": @"OK"
                                        };
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    _placesManager = nil;
    _fakePlaceAutocompleteRequest = nil;
    _placesManagerDelegate = nil;
    [super tearDown];
}

- (void)testThatPlacesManagerExists
{
    XCTAssertNotNil(_placesManager, @"Should be able to create HIPlacesManager instance");
}

- (void)testThatNonConformingObjectCannotBeDelegate
{
    XCTAssertThrows(_placesManager.delegate = (id<HIPlacesManagerDelegate>)[NSNull null], @"NSNull cannot be a delegate");
}

- (void)testThatConformingObjectCanBeDelegate
{
    MockHIPlacesManagerDelegate *delegate = [[MockHIPlacesManagerDelegate alloc] init];
    XCTAssertNoThrow(_placesManager.delegate = delegate, @"Conforming object should be allowed as delegate");
}

- (void)testThatNilCanBeDelegate
{
    XCTAssertNoThrow(_placesManager.delegate = nil, @"nil should be allowed as delegate");
}

#pragma mark - searchForPlaceAutocompleteResultsWithRequest test methods

- (void)testThatSearchForPlaceAutocompleteResultsWithRequestExists
{
    [_placesManager searchForPlaceAutocompleteResultsWithRequest:_fakePlaceAutocompleteRequest];
    XCTAssertTrue([_placesManager wasAskedToSearchForPlaceAutocompleteResults], @"Should be able to search for PlaceAutocompleteResults");
}

- (void)testThatPlaceAutocompleteRequestCannotBeNil
{
    XCTAssertThrows([_placesManager searchForPlaceAutocompleteResultsWithRequest:nil], @"PlaceAutocompleteRequest cannot be nil");
}

- (void)testKeyCannotBeNilInthePlaceAutocompleteRequest
{
    _fakePlaceAutocompleteRequest.key = nil;
    XCTAssertThrows([_placesManager searchForPlaceAutocompleteResultsWithRequest:_fakePlaceAutocompleteRequest], @"key cannot be nil");
}

- (void)testKeyCannotBeEmptyInThePlaceAutocompleteRequest
{
    _fakePlaceAutocompleteRequest.key = @"";
    XCTAssertThrows([_placesManager searchForPlaceAutocompleteResultsWithRequest:_fakePlaceAutocompleteRequest], @"key cannot be empty");
}

- (void)testThatInputCannotBeNilInThePlaceAutocompleteRequest
{
    _fakePlaceAutocompleteRequest.input = nil;
    XCTAssertThrows([_placesManager searchForPlaceAutocompleteResultsWithRequest:_fakePlaceAutocompleteRequest], @"input cannot be nil");
}

- (void)testThatInputCannotBeEmptyInThePlaceAutocompleteRequest
{
    _fakePlaceAutocompleteRequest.input = @"";
    XCTAssertThrows([_placesManager searchForPlaceAutocompleteResultsWithRequest:_fakePlaceAutocompleteRequest], @"input cannot be empty");
}

#pragma mark - placeAutocompleteRequestURLStringFromRequest test methods

- (void)testThatKeyAndInputAreIncludedInTheRequestURLString
{
    NSString *expectedURLString = @"https://maps.googleapis.com/maps/api/place/autocomplete/json?key=FakeKey&input=FakeInput";
    
    XCTAssertTrue([[_placesManager placeAutocompleteRequestURLStringFromRequest:_fakePlaceAutocompleteRequest] isEqualToString:expectedURLString], @"URL should include input & key");
}

- (void)testThatSpaceInInputIsReplacedWithPercent
{
    _fakePlaceAutocompleteRequest.input = @"Fake Input";
    NSString *expectedURLString = @"https://maps.googleapis.com/maps/api/place/autocomplete/json?key=FakeKey&input=Fake%20Input";
    XCTAssertTrue([[_placesManager placeAutocompleteRequestURLStringFromRequest:_fakePlaceAutocompleteRequest] isEqualToString:expectedURLString], @"Space should be replaced with percent");
}

- (void)testThatOffsetIsIncludedInTheRequestURLString
{
    _fakePlaceAutocompleteRequest.offset = 123;
    NSString *expectedURLString = @"https://maps.googleapis.com/maps/api/place/autocomplete/json?key=FakeKey&input=FakeInput&offset=123";
    XCTAssertTrue([[_placesManager placeAutocompleteRequestURLStringFromRequest:_fakePlaceAutocompleteRequest] isEqualToString:expectedURLString], @"URL should include offset");
}

- (void)testThatLocationIsIncludedInTheRequestURLString
{
    _fakePlaceAutocompleteRequest.location = CLLocationCoordinate2DMake(10.0, 10.0);
    NSString *expectedURLString = @"https://maps.googleapis.com/maps/api/place/autocomplete/json?key=FakeKey&input=FakeInput&location=10.000000,10.000000";
    XCTAssertTrue([[_placesManager placeAutocompleteRequestURLStringFromRequest:_fakePlaceAutocompleteRequest] isEqualToString:expectedURLString], @"URL should include location");
}

- (void)testThatLocationIsWithinBounds
{
    _fakePlaceAutocompleteRequest.location = CLLocationCoordinate2DMake(900.0, -900.0);
    XCTAssertThrows([_placesManager placeAutocompleteRequestURLStringFromRequest:_fakePlaceAutocompleteRequest], @"Location should be within bounds");
}

- (void)testThatRadiusIsIncludedInTheRequestURLString
{
    _fakePlaceAutocompleteRequest.radius = 123;
    NSString *expectedURLString = @"https://maps.googleapis.com/maps/api/place/autocomplete/json?key=FakeKey&input=FakeInput&radius=123";
    XCTAssertTrue([[_placesManager placeAutocompleteRequestURLStringFromRequest:_fakePlaceAutocompleteRequest] isEqualToString:expectedURLString], @"URL should include radius");
}

- (void)testThatHIPlaceTypeGeocodeIsIncludedInTheRequestURLString
{
    _fakePlaceAutocompleteRequest.placeType = HIPlaceTypeGeocode;
    NSString *expectedURLString = @"https://maps.googleapis.com/maps/api/place/autocomplete/json?key=FakeKey&input=FakeInput&types=geocode";
    XCTAssertTrue([[_placesManager placeAutocompleteRequestURLStringFromRequest:_fakePlaceAutocompleteRequest] isEqualToString:expectedURLString], @"URL should include HIPlaceTypeGeocode");
}

- (void)testThatHIPlaceTypeAddressIsIncludedInTheRequestURLString
{
    _fakePlaceAutocompleteRequest.placeType = HIPlaceTypeAddress;
    NSString *expectedURLString = @"https://maps.googleapis.com/maps/api/place/autocomplete/json?key=FakeKey&input=FakeInput&types=address";
    XCTAssertTrue([[_placesManager placeAutocompleteRequestURLStringFromRequest:_fakePlaceAutocompleteRequest] isEqualToString:expectedURLString], @"URL should include HIPlaceTypeAddress");
}

- (void)testThatHIPlaceTypeEstablishmentIsIncludedInTheRequestURLString
{
    _fakePlaceAutocompleteRequest.placeType = HIPlaceTypeEstablishment;
    NSString *expectedURLString = @"https://maps.googleapis.com/maps/api/place/autocomplete/json?key=FakeKey&input=FakeInput&types=establishment";
    XCTAssertTrue([[_placesManager placeAutocompleteRequestURLStringFromRequest:_fakePlaceAutocompleteRequest] isEqualToString:expectedURLString], @"URL should include HIPlaceTypeEstablishment");
}

- (void)testThatHIPlaceTypeRegionsCollectionIsIncludedInTheRequestURLString
{
    _fakePlaceAutocompleteRequest.placeType = HIPlaceTypeRegionsCollection;
    NSString *expectedURLString = @"https://maps.googleapis.com/maps/api/place/autocomplete/json?key=FakeKey&input=FakeInput&types=(regions)";
    XCTAssertTrue([[_placesManager placeAutocompleteRequestURLStringFromRequest:_fakePlaceAutocompleteRequest] isEqualToString:expectedURLString], @"URL should include HIPlaceTypeRegionsCollection");
}

- (void)testThatHIPlaceTypeCitiesCollectionIsIncludedInTheRequestURLString
{
    _fakePlaceAutocompleteRequest.placeType = HIPlaceTypeCitiesCollection;
    NSString *expectedURLString = @"https://maps.googleapis.com/maps/api/place/autocomplete/json?key=FakeKey&input=FakeInput&types=(cities)";
    XCTAssertTrue([[_placesManager placeAutocompleteRequestURLStringFromRequest:_fakePlaceAutocompleteRequest] isEqualToString:expectedURLString], @"URL should include HIPlaceTypeCitiesCollection");
}

- (void)testThatExceptionRaisedIfInvalidPlaceType
{
    _fakePlaceAutocompleteRequest.placeType = 1232334;
    XCTAssertThrows([_placesManager placeAutocompleteRequestURLStringFromRequest:_fakePlaceAutocompleteRequest], @"Invalid PlaceType");
}

#pragma mark - statusCodeForResponse test methods

- (void)testThatHIGoogleStatusOKIsReturnedForStatusOK
{
    NSDictionary *responseDictionary = @{@"status": @"OK"};
    XCTAssertEqual([_placesManager statusCodeForResponse:responseDictionary], HIGoogleStatusCodeOK, @"Should return HIGoogleStatusCodeOK");
}

- (void)testThatHIGoogleStatusUnknownErrorIsReturnedForStatusUNKNOWN_ERROR
{
    NSDictionary *responseDictionary = @{@"status": @"UNKNOWN_ERROR"};
    XCTAssertEqual([_placesManager statusCodeForResponse:responseDictionary], HIGoogleStatusCodeUnknownError, @"Should return HIGoogleStatusCodeUnknownError");
}

- (void)testThatHIGoogleStatusZeroResultsIsReturnedForStatusZERO_RESULTS
{
    NSDictionary *responseDictionary = @{@"status": @"ZERO_RESULTS"};
    XCTAssertEqual([_placesManager statusCodeForResponse:responseDictionary], HIGoogleStatusCodeZeroResults, @"Should return HIGoogleStatusCodeZeroResults");
}

- (void)testThatHIGoogleStatusOverQueryLimitIsReturnedForStatusOVER_QUERY_LIMIT
{
    NSDictionary *responseDictionary = @{@"status": @"OVER_QUERY_LIMIT"};
    XCTAssertEqual([_placesManager statusCodeForResponse:responseDictionary], HIGoogleStatusCodeOverQueryLimit, @"Should return HIGoogleStatusCodeOverQueryLimit");
}

- (void)testThatHIGoogleStatusRequestDeniedIsReturnedForStatusREQUEST_DENIED
{
    NSDictionary *responseDictionary = @{@"status": @"REQUEST_DENIED"};
    XCTAssertEqual([_placesManager statusCodeForResponse:responseDictionary], HIGoogleStatusCodeRequestDenied, @"Should return HIGoogleStatusCodeRequestDenied");
}

- (void)testThatHIGoogleStatusRequestInvalidRequestIsReturnedForStatusINVALID_REQUEST
{
    NSDictionary *responseDictionary = @{@"status": @"INVALID_REQUEST"};
    XCTAssertEqual([_placesManager statusCodeForResponse:responseDictionary], HIGoogleStatusCodeInvalidRequest, @"Should return HIGoogleStatusCodeInvalidRequest");
}

- (void)testThatHIGoogleStatusNotFoundIsReturnedForStatusNOT_FOUND
{
    NSDictionary *responseDictionary = @{@"status": @"NOT_FOUND"};
    XCTAssertEqual([_placesManager statusCodeForResponse:responseDictionary], HIGoogleStatusCodeNotFound, @"Should return HIGoogleStatusCodeNotFound");
}

#pragma mark - placesErrorForGoogleStatusCode methods

- (void)testThatHIPlacesErrorZeroResultsIsReturnedForHIGoogleStatusCodeZeroResults
{
    XCTAssertEqual([_placesManager placesErrorForGoogleStatusCode:HIGoogleStatusCodeZeroResults], HIPlacesErrorZeroResults);
}

- (void)testThatHIPlacesErrorOverQueryLimitIsReturnedForHIGoogleStatusCodeOverQueryLimit
{
    XCTAssertEqual([_placesManager placesErrorForGoogleStatusCode:HIGoogleStatusCodeOverQueryLimit], HIPlacesErrorOverQueryLimit);
}

- (void)testThatHIPlacesErrorRequestDeniedIsReturnedForHIGoogleStatusCodeRequestDenied
{
    XCTAssertEqual([_placesManager placesErrorForGoogleStatusCode:HIGoogleStatusCodeRequestDenied], HIPlacesErrorRequestDenied);
}

- (void)testThatHIPlacesErrorInvalidRequestIsReturnedForHIGoogleStatusCodeInvalidRequest
{
    XCTAssertEqual([_placesManager placesErrorForGoogleStatusCode:HIGoogleStatusCodeInvalidRequest], HIPlacesErrorInvalidRequest);
}

- (void)testThatHIPlacesErrorNotFoundIsReturnedForHIGoogleStatusCodeNotFound
{
    XCTAssertEqual([_placesManager placesErrorForGoogleStatusCode:HIGoogleStatusCodeNotFound], HIPlacesErrorNotFound);
}

#pragma mark - placeAutocompleteResultsForResponse test methods

- (void)testThatPlaceAutocompleteResultsForResponseReturnsAnArray
{
    XCTAssertTrue([[_placesManager placeAutocompleteResultsForResponse:nil] isKindOfClass:[NSArray class]]);
}

- (void)testThatReturnedHIPlaceAutocompleteResultArrayContainsPlaceDescription
{
    NSArray *placeAutocompleteResults = [_placesManager placeAutocompleteResultsForResponse:_placeAutocompleteResponseDictionary];
    HIPlaceAutocompleteResult *result1 = [placeAutocompleteResults objectAtIndex:0];
    HIPlaceAutocompleteResult *result2 = [placeAutocompleteResults objectAtIndex:1];

    XCTAssertEqual(result1.placeDescription, @"Paris, France");
    XCTAssertEqual(result2.placeDescription, @"Paris Avenue, Earlwood, New South Wales, Australia");
}

- (void)testThatReturnedHIPlaceAutocompleteResultArrayContainsPlaceId
{
    NSArray *placeAutocompleteResults = [_placesManager placeAutocompleteResultsForResponse:_placeAutocompleteResponseDictionary];
    HIPlaceAutocompleteResult *result1 = [placeAutocompleteResults objectAtIndex:0];
    HIPlaceAutocompleteResult *result2 = [placeAutocompleteResults objectAtIndex:1];
    
    XCTAssertEqual(result1.placeId, @"ChIJD7fiBh9u5kcRYJSMaMOCCwQ");
    XCTAssertEqual(result2.placeId, @"ChIJrU3KAHG6EmsR5Uwfrk7azrI");
}

- (void)testThatReturnedHIPlaceAutocompleteResultArrayContainsPlaceTypes
{
    NSArray *placeAutocompleteResults = [_placesManager placeAutocompleteResultsForResponse:_placeAutocompleteResponseDictionary];
    HIPlaceAutocompleteResult *result1 = [placeAutocompleteResults objectAtIndex:0];
    HIPlaceAutocompleteResult *result2 = [placeAutocompleteResults objectAtIndex:1];
    
    NSArray *result1ExpectedPlaceTypes = [NSArray arrayWithObjects:[NSNumber numberWithUnsignedInteger:HIPlaceTypeLocality], [NSNumber numberWithUnsignedInteger:HIPlaceTypePolitical], [NSNumber numberWithUnsignedInteger:HIPlaceTypeGeocode], nil];
    NSArray *result2ExpectedPlaceTypes = [NSArray arrayWithObjects:[NSNumber numberWithUnsignedInteger:HIPlaceTypeRoute], [NSNumber numberWithUnsignedInteger:HIPlaceTypeGeocode], nil];
    
    XCTAssertEqualObjects(result1.placeTypes, result1ExpectedPlaceTypes);
    XCTAssertEqualObjects(result2.placeTypes, result2ExpectedPlaceTypes);
}

#pragma mark - searchForPlaceDetailsResultWithRequest test methods

- (void)testThatSearchForPlaceDetailsResultWithRequestExists
{
    [_placesManager searchForPlaceDetailsResultWithRequest:_fakePlaceDetailsRequest];
    XCTAssertTrue([_placesManager wasAskedToSearchForPlaceDetailsResult], @"Should be able to search for PlaceDetails");
}

- (void)testThatPlaceDetailsRequestCannotBeNil
{
    XCTAssertThrows([_placesManager searchForPlaceDetailsResultWithRequest:nil], @"PlaceDetailsRequest cannot be nil");
}

- (void)testThatKeyCannotBeNilInPlaceDetailsRequest
{
    _fakePlaceDetailsRequest.key = nil;
    XCTAssertThrows([_placesManager searchForPlaceDetailsResultWithRequest:_fakePlaceDetailsRequest], @"key cannot be nil");
}

- (void)testThatKeyCannotBeEmptyInPlaceDetailsRequest
{
    _fakePlaceDetailsRequest.key = @"";
    XCTAssertThrows([_placesManager searchForPlaceDetailsResultWithRequest:_fakePlaceDetailsRequest], @"key cannot be an empty string");
}

- (void)testThatPlaceIdCannotBeNilInPlaceDetailsRequest
{
    _fakePlaceDetailsRequest.placeId = nil;
    XCTAssertThrows([_placesManager searchForPlaceDetailsResultWithRequest:_fakePlaceDetailsRequest], @"placeId cannot be nil");
}

- (void)testThatPlaceIdCannotBeEmptyInPlaceDetailsRequest
{
    _fakePlaceDetailsRequest.placeId = @"";
    XCTAssertThrows([_placesManager searchForPlaceDetailsResultWithRequest:_fakePlaceDetailsRequest], @"placeId cannot be an empty string");
}

#pragma mark - placeDetailsRequestURLStringFromRequest test methods

- (void)testThatKeyAndPlaceIdAreIncludedInTheRequestURLString
{
    NSString *expectedRequestURLString = @"https://maps.googleapis.com/maps/api/place/details/json?key=FakeKey&placeid=FakePlaceId";
    NSString *requestURLString = [_placesManager placeDetailsRequestURLStringFromRequest:_fakePlaceDetailsRequest];
    
    XCTAssertTrue([requestURLString isEqualToString:expectedRequestURLString], @"key and placeId must be included in the request URL string");
}

#pragma mark - placeDetailsResultForResponse test methods

- (void)testThatPlaceDetailsResultForResponseReturnsAnInstanceOfHIPlaceDetails
{
    XCTAssertTrue([[_placesManager placeDetailsResultForResponse:_placeDetailsResponseDictionary] isKindOfClass:[HIPlaceDetailsResult class]], @"An instance of HIPlaceDetailsResult must be returned");
}

- (void)testThatPlaceDetailsResultContainsPlaceId
{
    HIPlaceDetailsResult *placeDetailsResult = [_placesManager placeDetailsResultForResponse:_placeDetailsResponseDictionary];
    XCTAssertEqual(placeDetailsResult.placeId, @"ChIJN1t_tDeuEmsRUsoyG83frY4", @"PlaceId must be present");
}

- (void)testThatPlaceDetailsResultContainsFormattedAddress
{
    HIPlaceDetailsResult *placeDetailsResult = [_placesManager placeDetailsResultForResponse:_placeDetailsResponseDictionary];
    XCTAssertEqual(placeDetailsResult.formattedAddress, @"48 Pirrama Road, Pyrmont NSW, Australia", @"Formatted address must be present");
}

- (void)testThatPlaceDetailsResultContainsName
{
    HIPlaceDetailsResult *placeDetailsResult = [_placesManager placeDetailsResultForResponse:_placeDetailsResponseDictionary];
    XCTAssertEqual(placeDetailsResult.name, @"Google Sydney", @"Name must be present");
}

- (void)testThatPlaceDetailsResultContainsLocation
{
    HIPlaceDetailsResult *placeDetailsResult = [_placesManager placeDetailsResultForResponse:_placeDetailsResponseDictionary];
    XCTAssertEqualObjects([NSNumber numberWithDouble:placeDetailsResult.location.latitude], @-33.8669710, @"Location with latitude must be present");
    XCTAssertEqualObjects([NSNumber numberWithDouble:placeDetailsResult.location.longitude], @151.1958750, @"Location with longitude must be present");
}

- (void)testThatPlaceDetailsResultContainsPlaceTypes
{
    HIPlaceDetailsResult *placeDetailsResult = [_placesManager placeDetailsResultForResponse:_placeDetailsResponseDictionary];

    NSArray *expectedPlaceTypes = @[[NSNumber numberWithUnsignedInteger:HIPlaceTypeEstablishment]];
    XCTAssertEqualObjects(placeDetailsResult.placeTypes, expectedPlaceTypes, @"PlaceTypes must be present");
}
@end
