//
//  AppDelegate.m
//  ColorApp
//
//  Created by Michael Berg on 6/5/15.
//  Copyright (c) 2015 Michael Berg. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"HasLaunchedOnce"]) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"HasLaunchedOnce"];
        
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:USER_DEFAULT_SHOW_NEW_USER_TIP];
        
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
    return YES;
}

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "sunstrider.SavedHues" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

#pragma mark - Core Data stack

@synthesize persistentContainer = _persistentContainer;

- (NSPersistentContainer *)persistentContainer {
    @synchronized (self) {
        if (_persistentContainer == nil) {
            _persistentContainer = [[NSPersistentContainer alloc] initWithName:@"SavedHues"];
            
            NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"SavedHues.sqlite"];
            NSPersistentStoreDescription *storeDescription = [[NSPersistentStoreDescription alloc] initWithURL:storeURL];
            _persistentContainer.persistentStoreDescriptions = @[storeDescription];
            
            [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription, NSError *error) {
                if (error != nil) {
                    NSLog(@"Unresolved error %@, %@", error, error.userInfo);
                    abort();
                }
            }];
        }
    }
    
    return _persistentContainer;
}

@end
