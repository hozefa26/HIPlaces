//
//  MockHIPlacesManagerDelegate.m
//  HIPlaces
//
//  Created by Hozefa Indorewala on 23/01/15.
//  Copyright (c) 2015 Hozefa Indorewala. All rights reserved.
//

#import "MockHIPlacesManagerDelegate.h"

@interface MockHIPlacesManagerDelegate ()
{
    NSError *_delegatorError;
}
@end

@implementation MockHIPlacesManagerDelegate

- (NSError *)fetchDelegatorError
{
    return _delegatorError;
}

- (void)placesManager:(HIPlacesManager *)placesManager searchForPlaceAutocompleteResultsDidFailWithError:(NSError *)error
{
    _delegatorError = error;
}

@end
