//
//  ColorExtractorViewController.h
//  ColorApp
//
//  Created by Michael Berg on 7/6/15.
//  Copyright (c) 2015 Michael Berg. All rights reserved.
//
//  This screen allows users to get color values from an image by tapping
//  different parts of the image

#import <UIKit/UIKit.h>
#import "ColorMethods.h"
#import "TipsMethods.h"
#import "Constants.h"

@interface ColorExtractorViewController : UIViewController <UIGestureRecognizerDelegate>

@property (strong, nonatomic) IBOutlet UIImageView *colorExtractorImageView;

@property (strong, nonatomic) IBOutlet UIView *colorPaneSwatchView1;
@property (strong, nonatomic) IBOutlet UIView *colorPaneSwatchView2;
@property (strong, nonatomic) IBOutlet UIView *colorPaneSwatchView3;
@property (strong, nonatomic) IBOutlet UIView *colorPaneSwatchView4;

@property (strong, nonatomic) IBOutlet UIButton *colorPaneSaveColorButton;

@property (nonatomic) UIImage *chosenImage;

@end
