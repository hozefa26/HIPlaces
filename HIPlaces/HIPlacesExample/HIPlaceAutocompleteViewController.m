//
//  HIPlaceAutocompleteViewController.m
//  HIPlaces
//
//  Created by Hozefa Indorewala on 16/03/15.
//  Copyright (c) 2015 Hozefa Indorewala. All rights reserved.
//

#import "HIPlaceAutocompleteViewController.h"
#import <HIPlaces/HIPlaces.h>
#import "HIPlaceDetailsViewController.h"
#import "UIViewController+AlertView.h"

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
    [self displayAlertViewForError:error.code];
}

#pragma mark - Segue methods

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"ToHIPlaceDetailsViewControllerPush"]) {
        // Get the indexPath of the row that was selected
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        // Get the corresponding HIPlaceAutocompleteResult
        if (indexPath) {
            HIPlaceAutocompleteResult *placeAutocompleteResult = [self.placeAutocompleteResults objectAtIndex:indexPath.row];
            HIPlaceDetailsViewController *pdvc = segue.destinationViewController;
            pdvc.placeID = placeAutocompleteResult.placeId;
        }
    }
}

#pragma mark - Others

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
