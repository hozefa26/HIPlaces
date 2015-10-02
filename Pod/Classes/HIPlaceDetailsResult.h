//
//  HIPlaceDetailsResult.h
//  HIPlaces
//
//  Created by Hozefa Indorewala on 02/02/15.
//  Copyright (c) 2015 Hozefa Indorewala. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface HIPlaceDetailsResult : NSObject

@property (nonatomic, readonly) NSString *placeId;
@property (nonatomic, readonly) NSString *formattedAddress;
@property (nonatomic, readonly) NSString *name;
@property (nonatomic, readonly) CLLocationCoordinate2D location;
@property (nonatomic, readonly) NSArray *placeTypes;

- (id)initWithPlaceDetailsAttributes:(NSDictionary *)placeDetailsAttributes;

@end
