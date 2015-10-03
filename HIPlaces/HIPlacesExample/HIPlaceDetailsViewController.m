//
//  HIPlaceDetailsViewController.m
//  HIPlaces
//
//  Created by Hozefa Indorewala on 19/03/15.
//  Copyright (c) 2015 Hozefa Indorewala. All rights reserved.
//

#import "HIPlaceDetailsViewController.h"

#import <HIPlaces/HIPlaces.h>

@interface HIPlaceDetailsViewController ()<HIPlacesManagerDelegate>

@property (nonatomic, strong) HIPlacesManager *placesManager;
@property (nonatomic, strong) HIPlaceDetailsResult *placeDetailsResult;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *formattedAddressLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UILabel *placeTypesLabel;
@end

@implementation HIPlaceDetailsViewController

#pragma mark - Accessor methods

- (HIPlacesManager *)placesManager {
    if (!_placesManager) {
        _placesManager = [[HIPlacesManager alloc] init];
        _placesManager.delegate = self;
    }
    
    return _placesManager;
}

#pragma mark - View methods

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"";
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"HIPlaceDetailCell"];
    
    HIPlaceDetailsRequest *placeDetailsRequest = [[HIPlaceDetailsRequest alloc] init];
    placeDetailsRequest.key = @"AIzaSyCSQqrrxT2egpMIObgwsise4bkLEkl_7NQ";
    placeDetailsRequest.placeId = self.placeID;
    
    [self.placesManager searchForPlaceDetailsResultWithRequest:placeDetailsRequest];
}
/*

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HIPlaceDetailCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    switch (indexPath.row) {
        case 0:
        {
            cell.textLabel.text = self.placeDetailsResult.name;
        }
            break;
            
        case 1:
        {
            cell.textLabel.text = self.placeDetailsResult.formattedAddress;
        }
            break;
            
        case 2:
        {
            cell.textLabel.text = [NSString stringWithFormat:@"%f, %f", self.placeDetailsResult.location.latitude, self.placeDetailsResult.location.longitude];
        }
            break;
            
        case 3:
        {
            NSMutableString *placeTypesString = [[NSMutableString alloc] initWithString:@""];
            for (int i = 0; i < self.placeDetailsResult.placeTypes.count; i++) {
                HIPlaceType placeType = [[self.placeDetailsResult.placeTypes objectAtIndex:i] unsignedIntegerValue];
                [placeTypesString appendString:[HIPlaceTypes placeTypeStringForPlaceType:placeType]];
                [placeTypesString appendString:@" "];
            }
            cell.textLabel.text = placeTypesString;
        }
            break;
            
        default:
            break;
    }
    
    return cell;
}
 */

#pragma mark - HIPlacesManagerDelegate protocol methods

- (void)placesManager:(HIPlacesManager *)placesManager didSearchForPlaceDetailsResult:(HIPlaceDetailsResult *)placeDetailsResult
{
    // self.placeDetailsResult = placeDetailsResult;
    // [self.tableView reloadData];
    
    self.nameLabel.text = placeDetailsResult.name;
    self.formattedAddressLabel.text = placeDetailsResult.formattedAddress;
    self.locationLabel.text = [NSString stringWithFormat:@"%f, %f", placeDetailsResult.location.latitude, placeDetailsResult.location.longitude];
    
    NSMutableString *placeTypesString = [[NSMutableString alloc] initWithString:@""];
    for (int i = 0; i < placeDetailsResult.placeTypes.count; i++) {
        HIPlaceType placeType = [[placeDetailsResult.placeTypes objectAtIndex:i] unsignedIntegerValue];
        [placeTypesString appendString:[HIPlaceTypes placeTypeStringForPlaceType:placeType]];
        [placeTypesString appendString:@" "];
    }
    self.placeTypesLabel.text = placeTypesString;
}

- (void)placesManager:(HIPlacesManager *)placesManager searchForPlaceDetailsResultDidFailWithError:(NSError *)error
{
    NSString *alertViewTitle;
    switch (error.code) {
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

#pragma mark - Others

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
