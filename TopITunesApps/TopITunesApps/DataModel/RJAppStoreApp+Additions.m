//
//  RJAppStoreApp+Additions.m
//  TopITunesApps
//
//  Created by roderic campbell on 5/20/12.
//  Copyright (c) 2012 Roderic. All rights reserved.
//

#import "RJAppStoreApp+Additions.h"


@implementation RJAppStoreApp (Additions)
- (void)updateAppWithJSONFromSearch:(NSDictionary *)jsonDict {
    NSString *description = [jsonDict objectForKey:@"description"];
    
    // app description
    if (![description isEqualToString:self.appDescription]) {
        self.appDescription = description;
    }
    
    // developer
    NSString *developer = [jsonDict objectForKey:@"artistName"];
    
    if (![developer isEqualToString:self.developer]) {
        self.developer = developer;
    }
    
    // imageUrl
    NSString *imageUrl = [jsonDict objectForKey:@"artworkUrl60"];
    
    if (![imageUrl isEqualToString:self.imageUrl]) {
        self.imageUrl = imageUrl;
    }
    
    // iTunesLink
    NSString *iTunesLink = [jsonDict objectForKey:@"trackViewUrl"];
    if (![iTunesLink isEqualToString:self.iTunesLink]) {
        self.iTunesLink = iTunesLink;
    }
    
    // currency
    NSString *priceCurrency = [jsonDict objectForKey:@"currency"];
    if (![priceCurrency isEqualToString:self.priceCurrency]) {
        self.priceCurrency = priceCurrency;
    }
    
    // price
    NSNumber *priceAmount = [jsonDict objectForKey:@"price"];
    if(![priceAmount isEqualToNumber:self.priceAmount]) {
        self.priceAmount = priceAmount;
    }
    
    // releaseDate
    // TODO come back to this
    // This will need to be some kind of static Date Formatter for efficiency sake
    //    self.releaseDate = [[jsonDict objectForKey:@"im:releaseDate"] objectForKey:@"label"];
    
    // title
    NSString *title = [jsonDict objectForKey:@"trackName"];
    if (![title isEqualToString:self.title]) {
        self.title = title;
    }
    
    NSLog(@"title is %@", title);

}

- (void)updateAppWithJSON:(NSDictionary *)jsonDict {
   // NSDictionary *entry = [jsonDict objectForKey:@"entry"];
    NSString *description = [[jsonDict objectForKey:@"summary"] objectForKey:@"label"];
    
    // app description
    if (![description isEqualToString:self.appDescription]) {
        self.appDescription = description;
    }
    
    // developer
    NSString *developer = [[jsonDict objectForKey:@"im:artist"] objectForKey:@"label"];
    
    if (![developer isEqualToString:self.developer]) {
        self.developer = developer;
    }
    
    // imageUrl - Naively take the first image
    NSString *imageUrl = [[[jsonDict objectForKey:@"im:image"] objectAtIndex:0] objectForKey:@"label"];

    if (![imageUrl isEqualToString:self.imageUrl]) {
        self.imageUrl = imageUrl;
    }
    
    // iTunesLink
    NSString *iTunesLink = [[jsonDict objectForKey:@"id"] objectForKey:@"label"];
    if (![iTunesLink isEqualToString:self.iTunesLink]) {
        self.iTunesLink = iTunesLink;
    }

    
    NSString *priceString = [[[jsonDict objectForKey:@"im:price"] objectForKey:@"attributes"] objectForKey:@"amount"];
    
    NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
    [f setNumberStyle:NSNumberFormatterDecimalStyle];
    NSNumber * priceValue = [f numberFromString:priceString];
    [f release];
    
    // price
    if (![priceValue isEqualToNumber:self.priceAmount]) {
        self.priceAmount = priceValue;
    }

    // currency
    NSString *priceCurrency = [[[jsonDict objectForKey:@"im:price"] objectForKey:@"attributes"] objectForKey:@"currency"];
    if (![priceCurrency isEqualToString:self.priceCurrency]) {
        self.priceCurrency = priceCurrency;
    }
        
    // releaseDate
    // TODO come back to this
    // This will need to be some kind of static Date Formatter for efficiency sake
//    self.releaseDate = [[jsonDict objectForKey:@"im:releaseDate"] objectForKey:@"label"];

    // rights
    NSString *rights = [[jsonDict objectForKey:@"rights"] objectForKey:@"label"];
    if (![rights isEqualToString:self.rights]) {
        self.rights = rights;
    }

    // title
    NSString *title = [[jsonDict objectForKey:@"title"] objectForKey:@"label"];
    if (![title isEqualToString:self.title]) {
        self.title = title;
    }

    NSLog(@"title is %@", title);
}
@end
