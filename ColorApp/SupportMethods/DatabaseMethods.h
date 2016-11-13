//
//  DatabaseMethods.h
//  ColorApp
//
//  Created by Michael Berg on 7/6/15.
//  Copyright (c) 2015 Michael Berg. All rights reserved.
//
//  Contains methods that get/set/modify properties contained
//  with the database represented by CoreData

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface DatabaseMethods : NSObject

- (void)saveHueToDatabaseWithName:(NSString *)name
                           RedVal:(float)redval
                         GreenVal:(float)greenval
                          BlueVal:(float)blueval
                         AlphaVal:(float)alphaval;

- (void)removeHueFromDatabaseWithName:(NSString *)name
                               RedVal:(float)redval
                             GreenVal:(float)greenval
                              BlueVal:(float)blueval
                             AlphaVal:(float)alphaval;

@end
