//
//  HIPlaceAutocompleteViewController.m
//  HIPlaces
//
//  Created by Hozefa Indorewala on 16/03/15.
//  Copyright (c) 2015 Hozefa Indorewala. All rights reserved.
//

#import "HIPlaceAutocompleteViewController.h"
#import <HIPlaces/HIPlaces.h>
#import "HIPlaceDetailsTableViewController.h"

@interface HIPlaceAutocompleteViewController ()<UISearchBarDelegate, HIPlacesManagerDelegate, UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) HIPlacesManager *placesManager;
@property (strong, nonatomic) NSArray *placeAutocompleteResults;
@property (weak, nonatomic) IBOutlet UISearchBar *placeSearchBar;

@end

@implementation HIPlaceAutocompleteViewController

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
    // Do any additional setup after loading the view.
}

#pragma mark - UITableViewDataSource methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.placeAutocompleteResults count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HIPlaceAutocompleteResultCell" forIndexPath:indexPath];
    
    HIPlaceAutocompleteResult *placeAutocompleteResult = [self.placeAutocompleteResults objectAtIndex:indexPath.row];
    
    cell.textLabel.text = placeAutocompleteResult.placeDescription;
    
    return cell;
}

#pragma mark - UISearchBarDelegate methods

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if ([searchText isEqualToString:@""]) {
        return;
    }
    
    HIPlaceAutocompleteRequest *placeAutocompleteRequest = [[HIPlaceAutocompleteRequest alloc] init];
    placeAutocompleteRequest.key = @"YOUR_KEY_HERE";
    placeAutocompleteRequest.input = searchText;
    [self.placesManager searchForPlaceAutocompleteResultsWithRequest:placeAutocompleteRequest];
}

#pragma mark - HIPlacesManagerDelegate protocol methods

- (void)placesManager:(HIPlacesManager *)placesManager didSearchForPlaceAutocompleteResults:(NSArray *)placeAutocompleteResults
{
    self.placeAutocompleteResults = placeAutocompleteResults;
    [self.tableView reloadData];
}

- (void)placesManager:(HIPlacesManager *)placesManager searchForPlaceAutocompleteResultsDidFailWithError:(NSError *)error
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

#pragma mark - UITableViewDelegate protocol methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    HIPlaceAutocompleteResult *placeAutocompleteResult = [self.placeAutocompleteResults objectAtIndex:indexPath.row];
    
    HIPlaceDetailsTableViewController *pdtvc = [[HIPlaceDetailsTableViewController alloc] initWithPlaceId:placeAutocompleteResult.placeId];
    
    [self.navigationController pushViewController:pdtvc animated:YES];
}

#pragma mark - Others

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
