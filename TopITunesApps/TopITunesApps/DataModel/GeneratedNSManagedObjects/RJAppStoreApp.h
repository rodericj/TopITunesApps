//
//  RJAppStoreApp.h
//  TopITunesApps
//
//  Created by roderic campbell on 5/20/12.
//  Copyright (c) 2012 Roderic. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface RJAppStoreApp : NSManagedObject

@property (nonatomic, retain) NSString * appDescription;
@property (nonatomic, retain) NSNumber * appId;
@property (nonatomic, retain) NSNumber * appType;
@property (nonatomic, retain) NSString * developer;
@property (nonatomic, retain) NSString * imageUrl;
@property (nonatomic, retain) NSString * iTunesLink;
@property (nonatomic, retain) NSNumber * priceAmount;
@property (nonatomic, retain) NSString * priceCurrency;
@property (nonatomic, retain) NSNumber * rank;
@property (nonatomic, retain) NSDate * releaseDate;
@property (nonatomic, retain) NSString * rights;
@property (nonatomic, retain) NSString * title;

@end
