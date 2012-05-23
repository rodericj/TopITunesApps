//
//  RJAppTableViewController.m
//  TopITunesApps
//
//  Created by roderic campbell on 5/18/12.
//  Copyright (c) 2012 Roderic. All rights reserved.
//

#import "RJAppTableViewController.h"
#import "RJDataModel.h"
#import "RJAppStoreApp.h"

@interface RJAppTableViewController ()

@property (nonatomic, retain) NSString *appstoreUrl;

// There are 2 fetched results controllers. One for each query
@property (nonatomic, retain) NSFetchedResultsController *iPhoneFetchedResultsController;
@property (nonatomic, retain) NSFetchedResultsController *iPadFetchedResultsController;

@end

@implementation RJAppTableViewController

@synthesize appstoreUrl;
@synthesize selectedSegment;

@synthesize iPhoneFetchedResultsController;
@synthesize iPadFetchedResultsController;

#pragma mark - support

#pragma mark - UITableViewDelegate Method

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *reuseId = @"appstorecell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseId];
    }
    
    RJAppStoreApp *app = [self.fetchController objectAtIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"%d %@", indexPath.row + 1, app.title];
    cell.detailTextLabel.text = app.appDescription;

    return cell;
}

- (NSString *)entityName {
    return @"RJAppStoreApp";
}

- (NSPredicate *)predicate {
    NSAssert(NO, @"predicate must be defined in concrete class");
    return nil;
}

#pragma mark lifecycle methods

- (NSString *)sortBy {
    return @"rank";
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)segmentChanged:(UISegmentedControl *)segment {
    self.selectedSegment = segment.selectedSegmentIndex;
       
    NSLog(@"segment changed");
    
    self.selectedSegment = segment.selectedSegmentIndex;
    _fetchController.delegate = nil;
    if (self.selectedSegment == 0) {
        self.iPadFetchedResultsController = _fetchController;
        _fetchController = self.iPhoneFetchedResultsController;
    }
    else {
        self.iPhoneFetchedResultsController = _fetchController;
        _fetchController = self.iPadFetchedResultsController;
    }
    
    [self.tableView reloadData];
    [self beginNetworkRequest];
}
- (void)beginSearchNetworkRequest {
    
}

- (void)beginNetworkRequest {
    
    NSAssert(self.appstoreUrl, @"Appstore url must be set");
    NSURL *url = [NSURL URLWithString:self.appstoreUrl];
    NSLog(@"begin network request appstore url is %@", url);
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_async(queue, ^{
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        NSURLResponse *response;
        NSError *error = nil;
        NSData *data = [NSURLConnection sendSynchronousRequest:request
                                             returningResponse:&response
                                                         error:&error];

        dispatch_async(dispatch_get_main_queue(), ^{
            RJDataModel *dataModel = (RJDataModel *)[RJDataModel sharedInstance];
            [dataModel insertAppStoreAppsFromJSONData:data platformType:self.selectedSegment];
            [dataModel save];
        });
    });
}

- (void)viewWillAppear:(BOOL)animated {    
    [super viewWillAppear:animated];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    UISegmentedControl *header = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"iPhone", @"iPad", nil]];
    header.segmentedControlStyle = UISegmentedControlStyleBar;
    
    self.navigationItem.titleView = header;
    header.selectedSegmentIndex = 0;
    [header addTarget:self
               action:@selector(segmentChanged:)
     forControlEvents:UIControlEventValueChanged];
    
    [header release];
    
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
