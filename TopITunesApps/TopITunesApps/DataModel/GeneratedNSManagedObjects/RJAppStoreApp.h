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

@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * appDescription;
@property (nonatomic, retain) NSNumber * rating;
@property (nonatomic, retain) NSNumber * appType;
@property (nonatomic, retain) NSNumber * priceAmount;
@property (nonatomic, retain) NSString * developer;
@property (nonatomic, retain) NSNumber * rank;
@property (nonatomic, retain) NSString * priceCurrency;
@property (nonatomic, retain) NSString * rights;
@property (nonatomic, retain) UNKNOWN_TYPE iTunesLink;
@property (nonatomic, retain) NSString * category;
@property (nonatomic, retain) NSDate * releaseDate;
@property (nonatomic, retain) NSString * imageUrl;

@end
