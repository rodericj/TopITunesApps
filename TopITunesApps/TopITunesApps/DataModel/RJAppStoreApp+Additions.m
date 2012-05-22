//
//  RJAppStoreApp+Additions.m
//  TopITunesApps
//
//  Created by roderic campbell on 5/20/12.
//  Copyright (c) 2012 Roderic. All rights reserved.
//

#import "RJAppStoreApp+Additions.h"


@implementation RJAppStoreApp (Additions)

- (void)updateAppWithJSON:(NSDictionary *)jsonDict {
    NSLog(@"parsing all the info");
   // NSDictionary *entry = [jsonDict objectForKey:@"entry"];
    NSString *description = [[jsonDict objectForKey:@"summary"] objectForKey:@"label"];
    
    // app description
    self.appDescription = description;

    // TODO set app type
    
    // developer
    self.developer = [[jsonDict objectForKey:@"im:artist"] objectForKey:@"label"];
    
    // imageUrl - Naively take the first image
    self.imageUrl = [[[jsonDict objectForKey:@"im:image"] objectAtIndex:0] objectForKey:@"label"];
    
    // iTunesLink
    self.iTunesLink = [[jsonDict objectForKey:@"id"] objectForKey:@"label"];

    NSString *priceString = [[[jsonDict objectForKey:@"im:price"] objectForKey:@"attributes"] objectForKey:@"amount"];
    
    NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
    [f setNumberStyle:NSNumberFormatterDecimalStyle];
    NSNumber * priceValue = [f numberFromString:priceString];
    [f release];
    
    // price
    self.priceAmount = priceValue;

    // currency
    self.priceCurrency = [[[jsonDict objectForKey:@"im:price"] objectForKey:@"attributes"] objectForKey:@"currency"];

        
    // releaseDate
    // TODO come back to this
    // This will need to be some kind of static Date Formatter for efficiency sake
//    self.releaseDate = [[jsonDict objectForKey:@"im:releaseDate"] objectForKey:@"label"];

    // rights
    self.rights = [[jsonDict objectForKey:@"rights"] objectForKey:@"label"];

    // title
    NSString *title = [[jsonDict objectForKey:@"title"] objectForKey:@"label"];
    self.title = title;

}
@end
