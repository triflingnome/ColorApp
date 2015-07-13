//
//  TipsMethods.m
//  ColorApp
//
//  Created by Michael Berg on 7/6/15.
//  Copyright (c) 2015 Michael Berg. All rights reserved.
//

#import "TipsMethods.h"

@interface TipsMethods () {
    NSArray *tipsOfTheDay;
}

@end

@implementation TipsMethods

- (id)init {
    if (self = [super init]) {
        
    }
    
    return self;
}

- (void)showStarterTipFromViewController:(UIViewController *)vc {
    NSString *starterMessage = [[NSString alloc] init];
    
    if ([vc.title isEqualToString:COLOR_PICKER_TITLE]) {
        starterMessage = COLOR_PICKER_STARTER_TIP;
    } else if ([vc.title isEqualToString:SAVED_COLORS_TITLE]) {
        starterMessage = SAVED_COLORS_STARTER_TIP;
    } else if ([vc.title isEqualToString:LOAD_COLORS_TITLE]) {
        starterMessage = LOAD_COLORS_STARTER_TIP;
    } else if ([vc.title isEqualToString:COLOR_EXTRACTOR_TITLE]) {
        starterMessage = COLOR_EXTRACTOR_STARTER_TIP;
    } else if ([vc.title isEqualToString:COLOR_OPTIONS_TITLE]) {
        starterMessage = COLOR_OPTIONS_STARTER_TIP;
    } else {// ColorMenu
        starterMessage = COLOR_MENU_STARTER_TIP;
    }
    
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"ShowStarterTips"]) {
        UIAlertController *starterTipAlert = [UIAlertController alertControllerWithTitle:@"Starter Tip"
                                                                                 message:starterMessage
                                                                          preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"Ok", @"Ok Action")
                                                           style:UIAlertActionStyleDefault
                                                         handler:nil];
        [starterTipAlert addAction:okAction];
        [vc presentViewController:starterTipAlert animated:YES completion:nil];
    }// end if
    
}// end showStarterTip

- (void)showTipOfTheDayFromViewController:(UIViewController *)vc {
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"ShowTipOfTheDay"]) {
        UIAlertController *tipOfTheDayAlert = [UIAlertController alertControllerWithTitle:@"Tip of the Day"
                                                                                  message:@"yeee lmao"
                                                                           preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"Ok", @"Ok Action")
                                                           style:UIAlertActionStyleDefault
                                                         handler:nil];
        [tipOfTheDayAlert addAction:okAction];
        [vc presentViewController:tipOfTheDayAlert animated:YES completion:nil];
    }// end if
    
}// end showTipOfTheDay

@end
