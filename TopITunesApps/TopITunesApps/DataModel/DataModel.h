//
//  DataModel.h
//  PartyMix
//
//  Created by Roderic Campbell on 1/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface DataModel : NSObject  {
	NSPersistentStoreCoordinator        *_persistentStoreCoordinator;
	NSManagedObjectModel                *_managedObjectModel;
	NSManagedObjectContext              *_managedObjectContext;	
}

@property (nonatomic, readonly) NSManagedObjectContext *managedObjectContext;

- (NSFetchRequest *)fetchRequestForEntity:(NSString *)entity where:(NSPredicate *)predicate orderBy:(NSString *)sort;

- (void)save;
@end
