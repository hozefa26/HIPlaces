//
//  UIViewController+AlertView.m
//  HIPlaces
//
//  Created by Hozefa Indorewala on 04/10/15.
//  Copyright © 2015 Hozefa Indorewala. All rights reserved.
//

#import "UIViewController+AlertView.h"

@implementation UIViewController (AlertView)

- (void)displayAlertViewForError:(HIPlacesError)error {
    NSString *alertViewTitle;
    switch (error) {
        case HIPlacesErrorZeroResults:
            alertViewTitle = @"No results found!";
            break;
            
        case HIPlacesErrorOverQueryLimit:
            alertViewTitle = @"Over query limit!";
            break;
            
        case HIPlacesErrorRequestDenied:
            alertViewTitle = @"Request denied!";
            break;
            
        case HIPlacesErrorInvalidRequest:
            alertViewTitle = @"Invalid request!";
            break;
            
        case HIPlacesErrorNotFound:
            alertViewTitle = @"Not found!";
            break;
            
        case HIPlacesErrorUnkownError:
            alertViewTitle = @"Unknown error!";
            break;
            
        case HIPlacesErrorInvalidJSON:
            alertViewTitle = @"Invalid JSON!";
            break;
            
        case HIPlacesErrorConnectionFailed:
            alertViewTitle = @"Connection failed!";
            break;
            
        default:
            break;
    }
    
    UIAlertView *alertView = [[UIAlertView alloc]
                              initWithTitle:alertViewTitle
                              message:nil
                              delegate:nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
    [alertView show];
}

@end
