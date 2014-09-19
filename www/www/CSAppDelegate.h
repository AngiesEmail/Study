//
//  CSAppDelegate.h
//  www
//
//  Created by playcrab on 19/9/14.
//  Copyright (c) 2014年 playcrab. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CSAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
