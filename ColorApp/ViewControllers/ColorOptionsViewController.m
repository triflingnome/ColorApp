//
//  ColorOptionsViewController.m
//  ColorApp
//
//  Created by Michael Berg on 7/6/15.
//  Copyright (c) 2015 Michael Berg. All rights reserved.
//
//  NOT BEING USED AS OF v1.1. NAVIGATION TO THIS VC HAS BEEN HIDDEN IN
//  THE STORYBOARD FILE

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
    
    [self setSwitchStatesBasedOnUserDefaults];
}

- (IBAction)showInfoButtonTipSelector:(id)sender {
    [tipsMethodsClassInstance showInfoButtonTipWithTipNumber:0
                                            inViewController:self];
}

- (void)setSwitchStatesBasedOnUserDefaults {
    //NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"ShowStarterTips"]) {
        [self.starterTipsSwitch setOn:YES];
    } else {
        [self.starterTipsSwitch setOn:NO];
    }
    
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"ShowTipOfTheDay"]) {
        [self.tipOfTheDaySwtich setOn:YES];
    } else {
        [self.tipOfTheDaySwtich setOn:NO];
    }
}

#pragma mark -- Switch State Toggled Methods

- (IBAction)starterTipsSwitchToggled:(id)sender {
    if ([self.starterTipsSwitch isOn]) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"ShowStarterTips"];
    } else {
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"ShowStarterTips"];
    }
    
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (IBAction)tipOfTheDaySwitchToggled:(id)sender {
    if ([self.tipOfTheDaySwtich isOn]) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"ShowTipOfTheDay"];
    } else {
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"ShowTipOfTheDay"];
    }
    
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
