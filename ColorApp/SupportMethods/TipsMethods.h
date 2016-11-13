//
//  TipsMethods.h
//  ColorApp
//
//  Created by Michael Berg on 7/6/15.
//  Copyright (c) 2015 Michael Berg. All rights reserved.
//
//  Contains methods for showing helpful tips that enable to user to more fully
//  use the features of the app

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Constants.h"

@interface TipsMethods : NSObject

- (void)showInfoButtonTipWithTipNumber:(int)i inViewController:(UIViewController *)vc;
- (void)showNewUserTipFromViewController:(UIViewController *)vc;

@end
