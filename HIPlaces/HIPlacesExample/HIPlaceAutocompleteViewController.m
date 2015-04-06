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
{
    NSArray *_placeAutocompleteResults;
    
    HIPlacesManager *_placesManager;
}

@property (weak, nonatomic) IBOutlet UISearchBar *placeSearchBar;
@property (weak, nonatomic) IBOutlet UITableView *placeAutocompleteResultsTableView;

@end

@implementation HIPlaceAutocompleteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"Place Autocomplete";
    
    _placesManager = [[HIPlacesManager alloc] init];
    _placesManager.delegate = self;
    
    _placeSearchBar.delegate = self;
    
    _placeAutocompleteResultsTableView.dataSource = self;
    _placeAutocompleteResultsTableView.delegate = self;
    [_placeAutocompleteResultsTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"PlaceAutocompleteResultCell"];
    
    _placeAutocompleteResults = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_placeAutocompleteResults count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PlaceAutocompleteResultCell" forIndexPath:indexPath];
    
    HIPlaceAutocompleteResult *placeAutocompleteResult = [_placeAutocompleteResults objectAtIndex:indexPath.row];
    
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
    [_placesManager searchForPlaceAutocompleteResultsWithRequest:placeAutocompleteRequest];
}

#pragma mark - HIPlacesManagerDelegate protocol methods

- (void)placesManager:(HIPlacesManager *)placesManager didSearchForPlaceAutocompleteResults:(NSArray *)placeAutocompleteResults
{
    _placeAutocompleteResults = placeAutocompleteResults;
    [_placeAutocompleteResultsTableView reloadData];
}

- (void)placesManager:(HIPlacesManager *)placesManager searchForPlaceAutocompleteResultsDidFailWithError:(NSError *)error
{
    NSString *alertViewTitle;
    switch (error.code) {
        case HIPlacesErrorZeroResults:
            alertViewTitle = @"No results found!";
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
    HIPlaceAutocompleteResult *placeAutocompleteResult = [_placeAutocompleteResults objectAtIndex:indexPath.row];
    
    HIPlaceDetailsTableViewController *pdtvc = [[HIPlaceDetailsTableViewController alloc] initWithPlaceId:placeAutocompleteResult.placeId];
    
    [self.navigationController pushViewController:pdtvc animated:YES];
}

@end
