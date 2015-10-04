//
//  UIViewController+AlertView.h
//  HIPlaces
//
//  Created by Hozefa Indorewala on 04/10/15.
//  Copyright © 2015 Hozefa Indorewala. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <HIPlaces/HIPlaces.h>

@interface UIViewController (AlertView)

- (void)displayAlertViewForError:(HIPlacesError)error;

@end
