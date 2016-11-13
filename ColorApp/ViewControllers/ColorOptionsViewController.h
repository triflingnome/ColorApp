//
//  ColorOptionsViewController.h
//  ColorApp
//
//  Created by Michael Berg on 7/6/15.
//  Copyright (c) 2015 Michael Berg. All rights reserved.
//
//  Shows the user various options that they can manipulate and set
//
//  NOT BEING USED AS OF v1.1. NAVIGATION TO THIS VC HAS BEEN HIDDEN IN
//  THE STORYBOARD FILE

#import <UIKit/UIKit.h>
#import "TipsMethods.h"
#import "Constants.h"

@interface ColorOptionsViewController : UIViewController

@property (strong, nonatomic) IBOutlet UISwitch *starterTipsSwitch;
@property (strong, nonatomic) IBOutlet UISwitch *tipOfTheDaySwtich;

@end
