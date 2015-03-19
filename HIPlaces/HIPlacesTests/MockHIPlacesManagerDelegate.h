//
//  MockHIPlacesManagerDelegate.h
//  HIPlaces
//
//  Created by Hozefa Indorewala on 23/01/15.
//  Copyright (c) 2015 Hozefa Indorewala. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "HIPlacesManagerDelegate.h"

@interface MockHIPlacesManagerDelegate : NSObject <HIPlacesManagerDelegate>

- (NSError *)fetchDelegatorError;

@end
