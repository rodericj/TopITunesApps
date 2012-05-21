//
//  RJDataModel.h
//  TopITunesApps
//
//  Created by roderic campbell on 5/18/12.
//  Copyright (c) 2012 Roderic. All rights reserved.
//

#import "DataModel.h"

@interface RJDataModel : DataModel

- (void)insertAppStoreAppsFromJSONData:(NSData *)json;

+ (RJDataModel*)sharedInstance;

@end
