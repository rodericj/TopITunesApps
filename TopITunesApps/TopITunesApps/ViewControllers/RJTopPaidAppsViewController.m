//
//  RJTopPaidAppsViewController.m
//  TopITunesApps
//
//  Created by roderic campbell on 5/18/12.
//  Copyright (c) 2012 Roderic. All rights reserved.
//

#import "RJTopPaidAppsViewController.h"

#define kIPadPlatform  @"toppaidipadapplications"
#define kIPhonePlatform @"toppaidapplications"

@interface RJTopPaidAppsViewController ()
@property (nonatomic, assign) BOOL iPadOnly;
@end

@implementation RJTopPaidAppsViewController
@synthesize iPadOnly;

- (NSString *)appstoreUrl {
    NSString *platformString = self.selectedSegment == 0 ? kIPhonePlatform : kIPadPlatform;
    NSString *ret = [NSString stringWithFormat:@"http://itunes.apple.com/us/rss/%@/limit=25/json", platformString];
    return ret;
}

-(NSPredicate *)predicate {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"priceAmount != 0 AND appType == %@", [NSNumber numberWithInt:self.selectedSegment]];
    return predicate;
}

#pragma mark life cycle methods

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.iPadOnly = NO;
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
