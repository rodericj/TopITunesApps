//
//  RJTopFreeAppsViewController.m
//  TopITunesApps
//
//  Created by roderic campbell on 5/18/12.
//  Copyright (c) 2012 Roderic. All rights reserved.
//

#import "RJTopFreeAppsViewController.h"

#define kIPadPlatform  @"topfreeipadapplications"
#define kIPhonePlatform @"topfreeapplications"

@interface RJTopFreeAppsViewController ()
@end

@implementation RJTopFreeAppsViewController


#pragma mark - stuff for the Concrete RJAppTableViewController

- (NSString *)appstoreUrl {
    NSString *platformString = self.selectedSegment == 0 ? kIPhonePlatform : kIPadPlatform;
    NSString *ret = [NSString stringWithFormat:@"http://itunes.apple.com/us/rss/%@/limit=25/json", platformString];
    NSLog(@"the top free apps appstore url is %@", ret);
    return ret;
}



-(NSPredicate *)predicate {
    NSLog(@"here we set up the predicate, the segment is %d", self.selectedSegment);
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"priceAmount == 0 AND appType == %@", [NSNumber numberWithInt:self.selectedSegment]];
    NSLog(@"predicate is %@", predicate);
    return predicate;
}

#pragma mark - lifecycle
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

}

- (void)viewDidUnload
{    
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
