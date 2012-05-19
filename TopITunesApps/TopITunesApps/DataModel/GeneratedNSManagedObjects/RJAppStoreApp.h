//
//  RJAppStoreApp.h
//  TopITunesApps
//
//  Created by roderic campbell on 5/18/12.
//  Copyright (c) 2012 Roderic. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface RJAppStoreApp : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * appDescription;
@property (nonatomic, retain) NSNumber * rating;
@property (nonatomic, retain) NSNumber * appType;
@property (nonatomic, retain) NSNumber * cost;
@property (nonatomic, retain) NSString * developer;

@end
