//
//  AppDelegate.h
//  ColorApp
//
//  Created by Michael Berg on 6/5/15.
//  Copyright (c) 2015 Michael Berg. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "Constants.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (readonly, strong) NSPersistentContainer *persistentContainer;

@end
