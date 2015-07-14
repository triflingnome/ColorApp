//
//  TipsMethods.m
//  ColorApp
//
//  Created by Michael Berg on 7/6/15.
//  Copyright (c) 2015 Michael Berg. All rights reserved.
//

#import "TipsMethods.h"

@interface TipsMethods () {
    NSArray *sampleTips;
    NSArray *colorMenuTips;
    NSArray *colorPickerTips;
    NSArray *colorExtractorTips;
    NSArray *savedColorsTips;
    NSArray *loadColorsTips;
    NSArray *colorOptionsTips;
}

@end

@implementation TipsMethods

- (id)init {
    if (self = [super init]) {
        sampleTips = [NSArray arrayWithObjects:@"Tip 1", @"Tip 2", @"Tip 3", @"Tip 4", nil];
        colorMenuTips = [NSArray arrayWithObjects:COLOR_MENU_TIP_1, COLOR_MENU_TIP_2, COLOR_MENU_TIP_3, COLOR_MENU_TIP_4, nil];
        colorPickerTips = [NSArray arrayWithObjects:COLOR_PICKER_TIP_1, COLOR_PICKER_TIP_2, COLOR_PICKER_TIP_3, COLOR_PICKER_TIP_4, nil];
        colorExtractorTips = [NSArray arrayWithObjects:COLOR_EXTRACTOR_TIP_1, COLOR_EXTRACTOR_TIP_2, COLOR_EXTRACTOR_TIP_3, nil];
        savedColorsTips = [NSArray arrayWithObjects:SAVED_COLORS_TIP_1, SAVED_COLORS_TIP_2, nil];
        loadColorsTips = [NSArray arrayWithObjects:LOAD_COLORS_TIP_1, LOAD_COLORS_TIP_2, nil];
        colorOptionsTips = [NSArray arrayWithObjects:COLOR_OPTIONS_TIP_1, COLOR_OPTIONS_TIP_2, nil];
    }// end if
    
    return self;
}

- (void)showNewUserTipFromViewController:(UIViewController *)vc {
    if ([[NSUserDefaults standardUserDefaults] boolForKey:USER_DEFAULT_SHOW_NEW_USER_TIP]) {
        // show alertcontroller
        UIAlertController *newUserTip = [UIAlertController alertControllerWithTitle:@"Welcome to Hue Harnesser!"
                                                                            message:@"With this app you'll be able enhance your color choices and add an extra utility to your artist or design tools.\n\nIf you're ever confused, lost or seeking to better understand the capabilities of this app, tap the the white 'i' button at the top of any screen. Those tips should help you out :D"
                                                                     preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Ok, let's get to it!"
                                                           style:UIAlertActionStyleCancel
                                                         handler:^(UIAlertAction *action) {
                                                             // set NewUserTip to NO
                                                             [[NSUserDefaults standardUserDefaults] setBool:NO forKey:USER_DEFAULT_SHOW_NEW_USER_TIP];
                                                             [[NSUserDefaults standardUserDefaults] synchronize];
                                                         }];
        [newUserTip addAction:okAction];
        [vc presentViewController:newUserTip animated:YES completion:nil];
    }// end if
}// end showNewUserTipFromViewController:

- (void)showInfoButtonTipWithTipNumber:(int)i inViewController:(UIViewController *)vc {
    NSArray *tips;
    
    if ([vc.title isEqualToString:COLOR_PICKER_TITLE]) {
        tips = colorPickerTips;
    } else if ([vc.title isEqualToString:SAVED_COLORS_TITLE]) {
        tips = savedColorsTips;
    } else if ([vc.title isEqualToString:LOAD_COLORS_TITLE]) {
        tips = loadColorsTips;
    } else if ([vc.title isEqualToString:COLOR_EXTRACTOR_TITLE]) {
        tips = colorExtractorTips;
    } else if ([vc.title isEqualToString:COLOR_OPTIONS_TITLE]) {
        tips = colorOptionsTips;
    } else {// ColorMenu
        tips = colorMenuTips;
    }
    
    UIAlertController *infoButtonTip = [UIAlertController alertControllerWithTitle:@"Helpful Tip"
                                                                           message:tips[i]
                                                                    preferredStyle:UIAlertControllerStyleAlert];
    
    if (i < [tips count] - 1) {
        UIAlertAction *nextTipAction = [UIAlertAction actionWithTitle:@"Next tip..."
                                                                style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction *action) {
                                                                  [self showInfoButtonTipWithTipNumber:i+1
                                                                                      inViewController:vc];
                                                              }];
        [infoButtonTip addAction:nextTipAction];
    }
    
    UIAlertAction *thanksAction = [UIAlertAction actionWithTitle:@"Thanks for the help"
                                                           style:UIAlertActionStyleCancel
                                                         handler:nil];
    [infoButtonTip addAction:thanksAction];
    [vc presentViewController:infoButtonTip animated:YES completion:nil];
}// end showInfoButtonTipWithTipNumber: inViewController:

@end
