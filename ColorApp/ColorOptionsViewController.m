//
//  ColorOptionsViewController.m
//  ColorApp
//
//  Created by Michael Berg on 7/6/15.
//  Copyright (c) 2015 Michael Berg. All rights reserved.
//

#import "ColorOptionsViewController.h"

@interface ColorOptionsViewController () {
    TipsMethods *tipsMethodsClassInstance;
}

@end

@implementation ColorOptionsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = COLOR_OPTIONS_TITLE;
    tipsMethodsClassInstance = [[TipsMethods alloc] init];
    //[tipsMethodsClassInstance showStarterTipFromViewController:self];
    
    [self setSwitchStatesBasedOnUserDefaults];
}// end viewDidLoad

- (void)setSwitchStatesBasedOnUserDefaults {
    //NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"ShowStarterTips"]) {
        [self.starterTipsSwitch setOn:YES];
    } else {
        [self.starterTipsSwitch setOn:NO];
    }// end if-else
    
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"ShowTipOfTheDay"]) {
        [self.tipOfTheDaySwtich setOn:YES];
    } else {
        [self.tipOfTheDaySwtich setOn:NO];
    }// end if-else

}// setSwitchStatesBasedOnUserDefaults

#pragma mark -- Switch State Toggled Methods

- (IBAction)starterTipsSwitchToggled:(id)sender {
    if ([self.starterTipsSwitch isOn]) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"ShowStarterTips"];
    } else {
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"ShowStarterTips"];
    }// end if-else
    
    [[NSUserDefaults standardUserDefaults] synchronize];
}// end starterTipsSwitchToggled:

- (IBAction)tipOfTheDaySwitchToggled:(id)sender {
    if ([self.tipOfTheDaySwtich isOn]) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"ShowTipOfTheDay"];
    } else {
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"ShowTipOfTheDay"];
    }// end if-else
    
    [[NSUserDefaults standardUserDefaults] synchronize];
}// end tipOfTheDaySwitchToggled:

@end
