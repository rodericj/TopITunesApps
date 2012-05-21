//
//  RJTopPaidAppsViewController.m
//  TopITunesApps
//
//  Created by roderic campbell on 5/18/12.
//  Copyright (c) 2012 Roderic. All rights reserved.
//

#import "RJTopPaidAppsViewController.h"

@interface RJTopPaidAppsViewController ()

@end

@implementation RJTopPaidAppsViewController


- (NSString *)appstoreUrl {
    return @"http://itunes.apple.com/us/rss/toppaidapplications/limit=25/json";
}

-(NSPredicate *)predicate {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"appType == 1"];
    return predicate;
}

#pragma mark life cycle methods

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
