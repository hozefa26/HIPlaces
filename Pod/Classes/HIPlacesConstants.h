//
//  HIPlacesConstants.h
//  HIPlaces
//
//  Created by Hozefa Indorewala on 22/01/15.
//  Copyright (c) 2015 Hozefa Indorewala. All rights reserved.
//

#import <Foundation/Foundation.h>

///--------------------------------------
/// @name Exceptions
///--------------------------------------

extern NSString * const HIInvalidKeyException;
extern NSString * const HIInvalidInputException;
extern NSString * const HIInvalidLocationException;
extern NSString * const HIInvalidPlaceTypeException;

///--------------------------------------
/// @name Errors
///--------------------------------------

extern NSString * const HIPlacesErrorDomain;

extern NSUInteger const HIPlacesErrorZeroResults;
extern NSUInteger const HIPlacesErrorOverQueryLimit;
extern NSUInteger const HIPlacesErrorRequestDenied;
extern NSUInteger const HIPlacesErrorInvalidRequest;
extern NSUInteger const HIPlacesErrorNotFound;
extern NSUInteger const HIPlacesErrorUnkownError;
extern NSUInteger const HIPlacesErrorInvalidJSON;
extern NSUInteger const HIPlacesErrorConnectionFailed;


///--------------------------------------
/// @name Enumerations
///--------------------------------------

typedef NS_ENUM(NSUInteger, HIGoogleStatusCode){
    HIGoogleStatusCodeOK,
    HIGoogleStatusCodeUnknownError,
    HIGoogleStatusCodeZeroResults,
    HIGoogleStatusCodeOverQueryLimit,
    HIGoogleStatusCodeRequestDenied,
    HIGoogleStatusCodeInvalidRequest,
    HIGoogleStatusCodeNotFound
};

