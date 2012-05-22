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
@property (nonatomic, retain) NSURLConnection *connection;

@end

@implementation RJAppTableViewController

@synthesize appstoreUrl;
@synthesize connection;
@synthesize selectedSegment;

#pragma mark - support

#pragma mark - UITableViewDelegate Method

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *reuseId = @"appstorecell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseId];
    }
    
    RJAppStoreApp *app = [self.fetchController objectAtIndexPath:indexPath];
    cell.textLabel.text = app.title;
    cell.detailTextLabel.text = app.appDescription;
    //NSLog(@"the title for %@ is %@ of type %@", app.appId, app.title, app.appType);
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
    //[self.fetchController performFetch:nil];

    [self beginNetworkRequest];
}

- (void)beginNetworkRequest {
    [self.connection cancel];
    
    NSAssert(self.appstoreUrl, @"Appstore url must be set");
    NSURL *url = [NSURL URLWithString:self.appstoreUrl];
    NSLog(@"begin network request appstore url is %@", url);
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [NSURLConnection sendAsynchronousRequest:request 
                                       queue:[[[NSOperationQueue alloc] init] autorelease] 
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error){
                               NSLog(@"Request completed: %@", response.description);
                               
                               RJDataModel *dataModel = (RJDataModel *)[RJDataModel sharedInstance];
                               [dataModel insertAppStoreAppsFromJSONData:data platformType:self.selectedSegment];
                               [dataModel save];
                               
                           }];
    self.connection = [NSURLConnection connectionWithRequest:request delegate:self];
    [self.connection start];

}

- (void)viewWillAppear:(BOOL)animated {
    [self.connection cancel];
    
    [self beginNetworkRequest];
       
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
