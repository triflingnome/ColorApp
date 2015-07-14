//
//  TipsMethods.h
//  ColorApp
//
//  Created by Michael Berg on 7/6/15.
//  Copyright (c) 2015 Michael Berg. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Constants.h"

@interface TipsMethods : NSObject

- (void)showStarterTipFromViewController:(UIViewController *)vc;
- (void)showTipOfTheDayFromViewController:(UIViewController *)vc;

- (void)showInfoButtonTipWithTipNumber:(int)i inViewController:(UIViewController *)vc;
- (void)showNewUserTipFromViewController:(UIViewController *)vc;

@end
