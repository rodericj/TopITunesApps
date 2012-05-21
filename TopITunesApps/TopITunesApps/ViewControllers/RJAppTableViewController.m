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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *reuseId = @"appstorecell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseId];
    }
    
    RJAppStoreApp *app = [self.fetchController objectAtIndexPath:indexPath];
    cell.textLabel.text = app.title;
    cell.detailTextLabel.text = app.appDescription;
    NSLog(@"the title for %@ is %@", app.appId, app.title);
    return cell;
}

- (NSString *)entityName {
    return @"RJAppStoreApp";
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

- (void)viewWillAppear:(BOOL)animated {
    [self.connection cancel];
    
    NSAssert(self.appstoreUrl, @"Appstore url must be set");
    NSURL *url = [NSURL URLWithString:self.appstoreUrl];
    NSLog(@"appstore url is %@", url);
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [NSURLConnection sendAsynchronousRequest:request 
                                       queue:[[[NSOperationQueue alloc] init] autorelease] 
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error){
                               NSLog(@"Request completed: %@", response.description);
                               
                               RJDataModel *dataModel = (RJDataModel *)[RJDataModel sharedInstance];
                               [dataModel insertAppStoreAppsFromJSONData:data];
                               
                           }];
    self.connection = [NSURLConnection connectionWithRequest:request delegate:self];
    [self.connection start];
    
    [super viewWillAppear:animated];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
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
