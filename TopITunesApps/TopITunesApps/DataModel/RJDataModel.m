//
//  RJDataModel.m
//  TopITunesApps
//
//  Created by roderic campbell on 5/18/12.
//  Copyright (c) 2012 Roderic. All rights reserved.
//

#import "RJDataModel.h"
#import "RJAppStoreApp+Additions.h"

#define kAppstoreAppName @"RJAppStoreApp"

@implementation RJDataModel

static RJDataModel *_dataModel = nil;

+(RJDataModel*)sharedInstance {
    if (_dataModel == nil) {
        _dataModel = [[super allocWithZone:NULL] init];
    }
    return _dataModel;
}

- (RJAppStoreApp *)insertOrUpdateAppWithAppId:(NSNumber *)appId {

    // Fetch app with appId
    NSFetchRequest *theFetchRequest = [self fetchRequestForEntity:kAppstoreAppName
                                                            where:[NSPredicate predicateWithFormat:@"(appId == %@)", appId]
                                                          orderBy:nil];
    
	theFetchRequest.fetchLimit = 1;
    
    NSError *error = nil;
    NSArray *results = [self.managedObjectContext executeFetchRequest:theFetchRequest error:&error];
	
    if (error) {
        NSLog(@"There was an error when fetching %@", [error localizedDescription]);
        return nil;
    }
    RJAppStoreApp *app;
    //If we have a result, return it
    if ([results count]) {
        NSAssert([results count] == 1, @"We should only have 1 app that matches this query in Core Data");
        app = [results objectAtIndex:0];
        return app;
    }
    
    //If we don't have a result, create one and return it
    app = [NSEntityDescription insertNewObjectForEntityForName:kAppstoreAppName
                                        inManagedObjectContext:self.managedObjectContext];  
    app.appId = appId;

    return app;
}

- (void)insertAppStoreAppsFromJSONData:(NSData *)data platformType:(NSUInteger)platformType{
    NSLog(@"insert");
    NSError *jsonError = nil;
    NSJSONSerialization *object = [NSJSONSerialization JSONObjectWithData:data
                                                                  options:0
                                                                    error:&jsonError];
    
    NSDictionary *dict = (NSDictionary *)object;
    NSArray *items = [[dict objectForKey:@"feed"] objectForKey:@"entry"];
    
    NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
    [f setNumberStyle:NSNumberFormatterDecimalStyle];
    
    NSNumber *platformTypeNumber = [NSNumber numberWithInt:platformType];
    for (int i = 0; i < [items count]; i++) {
        NSDictionary *object = [items objectAtIndex:i];
        NSString *appId = [[[object objectForKey:@"id"] objectForKey:@"attributes"] objectForKey:@"im:id"];


        NSNumber * myNumber = [f numberFromString:appId];
        
        RJAppStoreApp *app = [self insertOrUpdateAppWithAppId:myNumber];
        app.rank = [NSNumber numberWithInt:i];
        app.appType = platformTypeNumber;
        [app updateAppWithJSON:object];
    }
    [f release];
}

@end
