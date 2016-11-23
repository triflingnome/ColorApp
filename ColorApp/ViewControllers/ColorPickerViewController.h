//
//  ViewController.h
//  ColorApp
//
//  Created by Michael Berg on 6/5/15.
//  Copyright (c) 2015 Michael Berg. All rights reserved.
//
//  This screen allows for users to generate their own colors by manipulating
//  numerical values

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "LoadColorViewController.h"
#import "TipsMethods.h"
#import "Constants.h"

@interface ColorPickerViewController : UIViewController <LoadColorDelegate, UIGestureRecognizerDelegate>

@property (nonatomic) IBOutlet UISlider *colorSlider1;// for Red or Cyan
@property (nonatomic) IBOutlet UISlider *colorSlider2;// Green or Magenta
@property (nonatomic) IBOutlet UISlider *colorSlider3;// Blue or Yellow
@property (nonatomic) IBOutlet UISlider *colorSlider4;// Alpha or K

@property (nonatomic) IBOutlet UILabel *colorSliderValueLabel1;
@property (nonatomic) IBOutlet UILabel *colorSliderValueLabel2;
@property (nonatomic) IBOutlet UILabel *colorSliderValueLabel3;
@property (nonatomic) IBOutlet UILabel *colorSliderValueLabel4;

@property (nonatomic) IBOutlet UIView *colorSwatchView1;
@property (nonatomic) IBOutlet UIView *colorSwatchView2;
@property (nonatomic) IBOutlet UIView *colorSwatchView3;
@property (nonatomic) IBOutlet UIView *colorSwatchView4;


@end

