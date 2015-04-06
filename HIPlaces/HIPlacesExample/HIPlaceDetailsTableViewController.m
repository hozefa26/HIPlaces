//
//  HIPlaceDetailsTableViewController.m
//  HIPlaces
//
//  Created by Hozefa Indorewala on 19/03/15.
//  Copyright (c) 2015 Hozefa Indorewala. All rights reserved.
//

#import "HIPlaceDetailsTableViewController.h"

#import <HIPlaces/HIPlaces.h>

@interface HIPlaceDetailsTableViewController ()<HIPlacesManagerDelegate>
{
    NSString *_placeID;
    
    HIPlacesManager *_placesManager;
    
    HIPlaceDetailsResult *_placeDetailsResult;
}
@end

@implementation HIPlaceDetailsTableViewController

- (id)initWithPlaceId:(NSString *)placeId
{
    self = [super init];
    if (self) {
        _placeID = placeId;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"Place Details";
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"HIPlaceDetailCell"];
    
    _placesManager = [[HIPlacesManager alloc] init];
    _placesManager.delegate = self;
    
    HIPlaceDetailsRequest *placeDetailsRequest = [[HIPlaceDetailsRequest alloc] init];
    placeDetailsRequest.key = @"YOUR_KEY_HERE";
    placeDetailsRequest.placeId = _placeID;
    
    [_placesManager searchForPlaceDetailsResultWithRequest:placeDetailsRequest];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

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
            cell.textLabel.text = _placeDetailsResult.name;
        }
            break;
            
        case 1:
        {
            cell.textLabel.text = _placeDetailsResult.formattedAddress;
        }
            break;
            
        case 2:
        {
            cell.textLabel.text = [NSString stringWithFormat:@"%f, %f", _placeDetailsResult.location.latitude, _placeDetailsResult.location.longitude];
        }
            break;
            
        case 3:
        {
            NSMutableString *placeTypesString = [[NSMutableString alloc] initWithString:@""];
            for (int i = 0; i < _placeDetailsResult.placeTypes.count; i++) {
                HIPlaceType placeType = [[_placeDetailsResult.placeTypes objectAtIndex:i] unsignedIntegerValue];
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

#pragma mark - HIPlacesManagerDelegate protocol methods

- (void)placesManager:(HIPlacesManager *)placesManager didSearchForPlaceDetailsResult:(HIPlaceDetailsResult *)placeDetailsResult
{
    _placeDetailsResult = placeDetailsResult;
    [self.tableView reloadData];
}

- (void)placesManager:(HIPlacesManager *)placesManager searchForPlaceDetailsResultDidFailWithError:(NSError *)error
{
    NSString *errorCode = [NSString stringWithFormat:@"Error Code: %ld", (long)error.code];
    UIAlertView *alertView = [[UIAlertView alloc]
                              initWithTitle:errorCode
                              message:nil
                              delegate:nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
    [alertView show];
}

@end
