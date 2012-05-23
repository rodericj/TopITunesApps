//
//  RJSearchAppsViewController.m
//  TopITunesApps
//
//  Created by roderic campbell on 5/18/12.
//  Copyright (c) 2012 Roderic. All rights reserved.
//

#import "RJSearchAppsViewController.h"

@interface RJSearchAppsViewController ()
@property (nonatomic, retain) UISearchBar *search;
@end

@implementation RJSearchAppsViewController
@synthesize search;

#pragma mark - UISearchBarDelegate `

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    NSLog(@"search changed %@", searchText);
    if (searchText) {
        [self beginNetworkRequest];
    }
    
    NSString *query = searchText;
    if (query && query.length) {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"title contains[cd] %@", query];
        [self.fetchController.fetchRequest setPredicate:predicate];
        [self.fetchController.fetchRequest setFetchLimit:25];
    }
    NSError *error = nil;
    if (![[self fetchController] performFetch:&error]) {
        // Handle error
        exit(-1);
    }
    [self.tableView reloadData];
    
}

#pragma mark 

- (NSString *)appstoreUrl {
    return [NSString stringWithFormat:@"http://itunes.apple.com/search?term=%@&media=software", search.text];
}

-(NSPredicate *)predicate {
    return nil;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.search resignFirstResponder];
}
#pragma mark lifecycle methods

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.

    self.search = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    self.search.delegate = self;
    self.tableView.tableHeaderView = self.search;
    [self.search release];
}

- (void)viewDidUnload
{
    self.search = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
