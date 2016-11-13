//
//  Constants.m
//  ColorApp
//
//  Created by Michael Berg on 7/7/15.
//  Copyright (c) 2015 Michael Berg. All rights reserved.
//
//  Variables with unchanging values are declared and listed here for easy use throughout
//  the rest of the app

#import "Constants.h"

@implementation Constants

#pragma mark -- User Default String variable assignments

NSString *const USER_DEFAULT_SHOW_NEW_USER_TIP = @"showNewUserTip";

#pragma mark -- VC Title String assignments

NSString *const COLOR_MENU_TITLE = @"";
NSString *const COLOR_PICKER_TITLE = @"Hue Picker";
NSString *const SAVED_COLORS_TITLE = @"Hue Collection";
NSString *const LOAD_COLORS_TITLE = @"Load Hue";
NSString *const COLOR_EXTRACTOR_TITLE = @"Hue Extractor";
NSString *const COLOR_OPTIONS_TITLE = @"Options";

#pragma mark -- Tip String assignments

NSString *const COLOR_MENU_TIP_1 = @"Tapping the Hue Extractor button will allow you to extract color values from any part of an image you either take with your camera or one in your Photo Library";
NSString *const COLOR_MENU_TIP_2 = @"Tapping the Hue Picker button will take you to the Hue Picker screen where you can create your own custom colors by manipulating Red, Green, Blue and Alpha values";
NSString *const COLOR_MENU_TIP_3 = @"Tapping the Hue Collection button will take you to the collection of colors you saved while using the Hue Extractor or Hue Picker";
NSString *const COLOR_MENU_TIP_4 = @"Tapping the gear icon in the upper left corner of the screen will take you to the options screen, where you can customize various options";

NSString *const COLOR_PICKER_TIP_1 = @"Each slider corresponds with the 4 different components of a color, those being (from the first slider down):\n- Red\n- Green\n- Blue\n- Alpha (or opacity)";
NSString *const COLOR_PICKER_TIP_2 = @"You can compare and customize up to 4 colors at a time by tapping on one of the 4 rectangles (or color swatches) at the top of the screen. This action selects a new color swatch so you can easily hold on to your other hue(s) while creating a new hue";
NSString *const COLOR_PICKER_TIP_3 = @"You can save a color by tapping on the color and tapping 'Save Hue' button. You may give this newly saved hue a name for future reference";
NSString *const COLOR_PICKER_TIP_4 = @"Conversely, you can load a color you had previously saved by tapping the 'Load Hue' button, which will load a saved hue into the currently selected color swatch";

NSString *const SAVED_COLORS_TIP_1 = @"This screen shows you all the hues you've saved while working with the Hue Extractor or Hue Picker features";
NSString *const SAVED_COLORS_TIP_2 = @"You can choose to delete any unwanted or unneeded saved hue by tapping on the left arrow in the same row as the color you want to delete, then tapping on the trash can icon that is revealed";

NSString *const LOAD_COLORS_TIP_1 = @"To choose which hue to load, simply tap on the row of the desired hue";
NSString *const LOAD_COLORS_TIP_2 = @"To go back to the Hue Picker without loading a color (thus changing the values of the selected swatch), tap the back button in the top left";

NSString *const COLOR_EXTRACTOR_TIP_1 = @"Tap on any part of the photo to get the color values at that location";
NSString *const COLOR_EXTRACTOR_TIP_2 = @"You can retrieve multiple colors at a time by tapping on one of the 4 gray rectangles at the bottom, then tapping any part of the image. This allows you to retrieve new colors without losing older ones";
NSString *const COLOR_EXTRACTOR_TIP_3 = @"You can save any colors you've extracted by tapping on the color then tapping the 'Save Hue' button";

NSString *const COLOR_OPTIONS_TIP_1 = @"An option is enabled when the switch is on the right side and the switch's background is green";
NSString *const COLOR_OPTIONS_TIP_2 = @"Conversely, an option is disabled when the switch is on the left side and the switch's background is gray";

@end
