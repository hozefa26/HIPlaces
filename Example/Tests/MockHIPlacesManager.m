//
//  MockHIPlacesManager.m
//  HIPlaces
//
//  Created by Hozefa Indorewala on 23/01/15.
//  Copyright (c) 2015 Hozefa Indorewala. All rights reserved.
//

#import "MockHIPlacesManager.h"

@interface MockHIPlacesManager ()
{
    BOOL _wasAskedToSearchForPlaceAutocompleteResults;
    BOOL _wasAskedToSearchForPlaceDetailsResult;
}
@end

@implementation MockHIPlacesManager

- (void)searchForPlaceAutocompleteResultsWithRequest:(HIPlaceAutocompleteRequest *)request
{
    [super searchForPlaceAutocompleteResultsWithRequest:request];
    
    _wasAskedToSearchForPlaceAutocompleteResults = YES;
}

- (void)searchForPlaceDetailsResultWithRequest:(HIPlaceDetailsRequest *)request
{
    [super searchForPlaceDetailsResultWithRequest:request];
    
    _wasAskedToSearchForPlaceDetailsResult = YES;
}

- (BOOL)wasAskedToSearchForPlaceAutocompleteResults
{
    return _wasAskedToSearchForPlaceAutocompleteResults;
}

- (BOOL)wasAskedToSearchForPlaceDetailsResult
{
    return _wasAskedToSearchForPlaceDetailsResult;
}

@end
