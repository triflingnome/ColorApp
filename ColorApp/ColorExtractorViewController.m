//
//  ColorExtractorViewController.m
//  ColorApp
//
//  Created by Michael Berg on 7/6/15.
//  Copyright (c) 2015 Michael Berg. All rights reserved.
//

#import "ColorExtractorViewController.h"

@interface ColorExtractorViewController () {
    UITapGestureRecognizer *singleTapGesture;
    ColorMethods *colorMethodsClassInstance;
    DatabaseMethods *databaseMethodsClassInstance;
    TipsMethods *tipsMethodsClassInstance;
    
    NSMutableArray *colorPaneSwatchViews;
    NSInteger selectedColorPaneSwatchView;
    
    float *redVals;
    float *greenVals;
    float *blueVals;
    float *alphaVals;
}

@end

@implementation ColorExtractorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = COLOR_EXTRACTOR_TITLE;
    tipsMethodsClassInstance = [[TipsMethods alloc] init];
    
    colorMethodsClassInstance = [[ColorMethods alloc] init];
    databaseMethodsClassInstance = [[DatabaseMethods alloc] init];
    selectedColorPaneSwatchView = 0;
    colorPaneSwatchViews = [[NSMutableArray alloc] init];
    [colorPaneSwatchViews addObject:self.colorPaneSwatchView1];
    [colorPaneSwatchViews addObject:self.colorPaneSwatchView2];
    [colorPaneSwatchViews addObject:self.colorPaneSwatchView3];
    [colorPaneSwatchViews addObject:self.colorPaneSwatchView4];
    
    self.colorExtractorImageView.contentMode = UIViewContentModeScaleAspectFit;
    self.colorExtractorImageView.image = self.chosenImage;
    //self.colorExtractorImageView.image = [UIImage imageNamed:@"Debug"];
    
    redVals = (float *)malloc(sizeof(float) * 4);
    greenVals = (float *)malloc(sizeof(float) * 4);
    blueVals = (float *)malloc(sizeof(float) * 4);
    alphaVals = (float *)malloc(sizeof(float) * 4);
    
    // set default values and color for colorPaneSwatchViews
    for (int i = 0;i < 4;i++) {
        redVals[i] = 128.f;
        greenVals[i] = 128.f;
        blueVals[i] = 128.f;
        alphaVals[i] = 50.f;
    }// end if
    for (UIView *currentColorPaneSwatchView in colorPaneSwatchViews) {
        currentColorPaneSwatchView.backgroundColor = [UIColor colorWithRed:128.f/255.f green:128.f/255.f blue:128.f/255.f alpha:50.f/100.f];
    }// end for
    
    [self.colorExtractorImageView setUserInteractionEnabled:YES];
    singleTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapGestureSelector:)];
    [self.colorExtractorImageView addGestureRecognizer:singleTapGesture];
    [self.colorExtractorImageView setMultipleTouchEnabled:YES];
    
    // set border of colorSwatchView1 to show it is selected
    selectedColorPaneSwatchView = 0;
    self.colorPaneSwatchView1.layer.borderColor = [UIColor whiteColor].CGColor;
    self.colorPaneSwatchView1.layer.borderWidth = 3.0f;
    
    // add tap gesture to colorSwatchViews
    UITapGestureRecognizer *colorSwatchView1TapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(colorPaneSwatchView1Selected:)];
    colorSwatchView1TapGesture.delegate = self;
    [self.colorPaneSwatchView1 addGestureRecognizer:colorSwatchView1TapGesture];
    UITapGestureRecognizer *colorSwatchView2TapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(colorPaneSwatchView2Selected:)];
    colorSwatchView2TapGesture.delegate = self;
    [self.colorPaneSwatchView2 addGestureRecognizer:colorSwatchView2TapGesture];
    UITapGestureRecognizer *colorSwatchView3TapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(colorPaneSwatchView3Selected:)];
    colorSwatchView3TapGesture.delegate = self;
    [self.colorPaneSwatchView3 addGestureRecognizer:colorSwatchView3TapGesture];
    UITapGestureRecognizer *colorSwatchView4TapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(colorPaneSwatchView4Selected:)];
    colorSwatchView4TapGesture.delegate = self;
    [self.colorPaneSwatchView4 addGestureRecognizer:colorSwatchView4TapGesture];
    
}// end viewDidLoad

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)showInfoButtonTipSelector:(id)sender {
    [tipsMethodsClassInstance showInfoButtonTipWithTipNumber:0
                                            inViewController:self];
}

- (void)singleTapGestureSelector:(id)sender {
    CGPoint tapLocation = [singleTapGesture locationInView:self.colorExtractorImageView];
    
    UIView *colorPaneSwatchViewToUpdate = [colorPaneSwatchViews objectAtIndex:selectedColorPaneSwatchView];
    
    unsigned char *pixel = [colorMethodsClassInstance colorOfPoint:tapLocation inViewLayer:self.colorExtractorImageView.layer];
    //NSLog(@"in ColorExtractorViewController -- pixel: %d %d %d %d", pixel[0], pixel[1], pixel[2], pixel[3]);
    redVals[selectedColorPaneSwatchView] = pixel[0];
    greenVals[selectedColorPaneSwatchView] = pixel[1];
    blueVals[selectedColorPaneSwatchView] = pixel[2];
    alphaVals[selectedColorPaneSwatchView] = pixel[3];
    
    colorPaneSwatchViewToUpdate.backgroundColor = [UIColor colorWithRed:redVals[selectedColorPaneSwatchView]/255.f
                                                                  green:greenVals[selectedColorPaneSwatchView]/255.f
                                                                   blue:blueVals[selectedColorPaneSwatchView]/255.f
                                                                  alpha:alphaVals[selectedColorPaneSwatchView]/100.f];
}// end singleTapGestureSelector:

- (IBAction)colorPaneSaveColorButtonSingleTapAction:(id)sender {
    UIAlertController *alertController = [UIAlertController
                                          alertControllerWithTitle:@"Save Hue"
                                          message:@"You can give your hue a custom name before saving"
                                          preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField)
     {
         textField.placeholder = NSLocalizedString(@"Hue", @"Hue");
     }];
    
    UIAlertAction *cancelAction = [UIAlertAction
                                   actionWithTitle:NSLocalizedString(@"Cancel", @"Cancel action")
                                   style:UIAlertActionStyleCancel
                                   handler:^(UIAlertAction *action)
                                   {
                                       NSLog(@"Cancel action");
                                   }];
    
    UIAlertAction *saveAction = [UIAlertAction
                                 actionWithTitle:NSLocalizedString(@"Save", @"Save action")
                                 style:UIAlertActionStyleDefault
                                 handler:^(UIAlertAction *action)
                                 {
                                     UITextField *hueNameTextField = alertController.textFields.firstObject;
                                     
                                     NSLog(@"Save action");
                                     if ([hueNameTextField.text isEqualToString:@""]) {
                                         NSLog(@"use default name");
                                         [databaseMethodsClassInstance saveHueToDatabaseWithName:@"Hue"
                                                                                          RedVal:redVals[selectedColorPaneSwatchView]
                                                                                        GreenVal:greenVals[selectedColorPaneSwatchView]
                                                                                         BlueVal:blueVals[selectedColorPaneSwatchView]
                                                                                        AlphaVal:alphaVals[selectedColorPaneSwatchView]];
                                     } else {
                                         NSLog(@"%@", hueNameTextField.text);
                                         [databaseMethodsClassInstance saveHueToDatabaseWithName:hueNameTextField.text
                                                                                          RedVal:redVals[selectedColorPaneSwatchView]
                                                                                        GreenVal:greenVals[selectedColorPaneSwatchView]
                                                                                         BlueVal:blueVals[selectedColorPaneSwatchView]
                                                                                        AlphaVal:alphaVals[selectedColorPaneSwatchView]];
                                     }
                                 }];
    
    [alertController addAction:cancelAction];
    [alertController addAction:saveAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}// colorPaneSaveColorButtonSingleTapAction

#pragma mark -- Hue Pane Swatch View Methods

- (void)colorPaneSwatchView1Selected:(UITapGestureRecognizer *)gestureRecognizer {
    [self unselectAllColorPaneSwatchViews];
    
    self.colorPaneSwatchView1.layer.borderColor = [UIColor whiteColor].CGColor;
    self.colorPaneSwatchView1.layer.borderWidth = 3.0f;
    selectedColorPaneSwatchView = 0;
    //[self updateColorSliders:self.colorSwatchView1];
}

- (void)colorPaneSwatchView2Selected:(UITapGestureRecognizer *)gestureRecognizer {
    [self unselectAllColorPaneSwatchViews];
    
    self.colorPaneSwatchView2.layer.borderColor = [UIColor whiteColor].CGColor;
    self.colorPaneSwatchView2.layer.borderWidth = 3.0f;
    selectedColorPaneSwatchView = 1;
    //[self updateColorSliders:self.colorSwatchView2];
}

- (void)colorPaneSwatchView3Selected:(UITapGestureRecognizer *)gestureRecognizer {
    [self unselectAllColorPaneSwatchViews];
    
    self.colorPaneSwatchView3.layer.borderColor = [UIColor whiteColor].CGColor;
    self.colorPaneSwatchView3.layer.borderWidth = 3.0f;
    selectedColorPaneSwatchView = 2;
    //[self updateColorSliders:self.colorSwatchView3];
}

- (void)colorPaneSwatchView4Selected:(UITapGestureRecognizer *)gestureRecognizer {
    [self unselectAllColorPaneSwatchViews];
    
    self.colorPaneSwatchView4.layer.borderColor = [UIColor whiteColor].CGColor;
    self.colorPaneSwatchView4.layer.borderWidth = 3.0f;
    selectedColorPaneSwatchView = 3;
    //[self updateColorSliders:self.colorSwatchView4];
}

- (void)unselectAllColorPaneSwatchViews {
    for (UIView *colorPaneSwatchView in colorPaneSwatchViews) {
        colorPaneSwatchView.layer.borderColor = [UIColor clearColor].CGColor;
        colorPaneSwatchView.layer.borderWidth = 0.0f;
    }
}

@end
