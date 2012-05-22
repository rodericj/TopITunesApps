//
//  RJSearchAppsViewController.m
//  TopITunesApps
//
//  Created by roderic campbell on 5/18/12.
//  Copyright (c) 2012 Roderic. All rights reserved.
//

#import "RJSearchAppsViewController.h"

@interface RJSearchAppsViewController ()

@end

@implementation RJSearchAppsViewController


#pragma mark - UISearchBarDelegate 
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
//    return 44.0f;
//}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    NSLog(@"search changed %@", searchText);
}

#pragma mark 

- (NSString *)appstoreUrl {
    return @"http://itunes.apple.com/us/rss/topfreeapplications/limit=25/json";
}

-(NSPredicate *)predicate {
    return nil;
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

    UISearchBar *search = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    search.delegate = self;
    self.tableView.tableHeaderView = search;
    [search release];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
