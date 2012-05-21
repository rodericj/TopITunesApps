//
//  RJTopFreeAppsViewController.m
//  TopITunesApps
//
//  Created by roderic campbell on 5/18/12.
//  Copyright (c) 2012 Roderic. All rights reserved.
//

#import "RJTopFreeAppsViewController.h"

@interface RJTopFreeAppsViewController ()

@end

@implementation RJTopFreeAppsViewController

- (NSString *)appstoreUrl {
    return @"http://itunes.apple.com/us/rss/topfreeapplications/limit=25/json";
}

-(NSPredicate *)predicate {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"appType == 0"];
    return predicate;
}

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
