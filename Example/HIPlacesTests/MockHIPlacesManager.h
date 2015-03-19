//
//  MockHIPlacesManager.h
//  HIPlaces
//
//  Created by Hozefa Indorewala on 23/01/15.
//  Copyright (c) 2015 Hozefa Indorewala. All rights reserved.
//

#import "HIPlacesManager.h"

@interface MockHIPlacesManager : HIPlacesManager

- (BOOL)wasAskedToSearchForPlaceAutocompleteResults;
- (BOOL)wasAskedToSearchForPlaceDetailsResult;

@end
