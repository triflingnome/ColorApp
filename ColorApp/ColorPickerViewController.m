//
//  ViewController.m
//  ColorApp
//
//  Created by Michael Berg on 6/5/15.
//  Copyright (c) 2015 Michael Berg. All rights reserved.
//
//  This screen allows for users to generate their own colors by manipulating
//  numerical values

#import "ColorPickerViewController.h"

@interface ColorPickerViewController () <LoadColorDelegate> {
    NSMutableArray *colorSwatchViews;
    NSInteger selectedColorSwatchView;
    TipsMethods *tipsMethodsClassInstance;
    DatabaseMethods *databaseMethodsClassInstance;
}

@end

@implementation ColorPickerViewController

// sets default values for the color sliders and the color swatches
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = COLOR_PICKER_TITLE;
    tipsMethodsClassInstance = [[TipsMethods alloc] init];
    databaseMethodsClassInstance = [[DatabaseMethods alloc] init];
    
    selectedColorSwatchView = 0;
    
    colorSwatchViews = [[NSMutableArray alloc]init];
    [colorSwatchViews addObject:self.colorSwatchView1];
    [colorSwatchViews addObject:self.colorSwatchView2];
    [colorSwatchViews addObject:self.colorSwatchView3];
    [colorSwatchViews addObject:self.colorSwatchView4];
    
    // set colorSwatchView1 to default value then display
    self.colorSliderValueLabel1.text = [NSString stringWithFormat:@"%d", (int)self.colorSlider1.value];
    self.colorSliderValueLabel2.text = [NSString stringWithFormat:@"%d", (int)self.colorSlider2.value];
    self.colorSliderValueLabel3.text = [NSString stringWithFormat:@"%d", (int)self.colorSlider3.value];
    self.colorSliderValueLabel4.text = [NSString stringWithFormat:@"%d", (int)self.colorSlider4.value];
    
    // set default color for all swatches
    for ( int i = 0;i < [colorSwatchViews count];i++) {
        [self updateColorSwatchView];
        selectedColorSwatchView++;
    }
    
    // set border of colorSwatchView1 to show it is selected
    selectedColorSwatchView = 0;
    self.colorSwatchView1.layer.borderColor = [UIColor whiteColor].CGColor;
    self.colorSwatchView1.layer.borderWidth = 3.0f;
    
    // add tap gesture to colorSwatchViews
    UITapGestureRecognizer *colorSwatchView1TapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(colorSwatchView1Selected:)];
    colorSwatchView1TapGesture.delegate = self;
    [self.colorSwatchView1 addGestureRecognizer:colorSwatchView1TapGesture];
    UITapGestureRecognizer *colorSwatchView2TapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(colorSwatchView2Selected:)];
    colorSwatchView2TapGesture.delegate = self;
    [self.colorSwatchView2 addGestureRecognizer:colorSwatchView2TapGesture];
    UITapGestureRecognizer *colorSwatchView3TapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(colorSwatchView3Selected:)];
    colorSwatchView3TapGesture.delegate = self;
    [self.colorSwatchView3 addGestureRecognizer:colorSwatchView3TapGesture];
    UITapGestureRecognizer *colorSwatchView4TapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(colorSwatchView4Selected:)];
    colorSwatchView4TapGesture.delegate = self;
    [self.colorSwatchView4 addGestureRecognizer:colorSwatchView4TapGesture];
    UITapGestureRecognizer *colorSwatchView5TapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(colorSwatchView5Selected:)];
    colorSwatchView5TapGesture.delegate = self;
}// end viewDidLoad

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)showInfoButtonTipSelector:(id)sender {
    [tipsMethodsClassInstance showInfoButtonTipWithTipNumber:0
                                            inViewController:self];
}

// sets the background color to the current values of the sliders
- (void)updateColorSwatchView {
    UIView *colorSwatchToUpdate = [colorSwatchViews objectAtIndex:selectedColorSwatchView];
    colorSwatchToUpdate.backgroundColor = [UIColor colorWithRed:self.colorSlider1.value/255.f green:self.colorSlider2.value/255.f blue:self.colorSlider3.value/255.f alpha:self.colorSlider4.value/100.f];
}


#pragma mark - UISlider sliderValueChanged methods

// these methods update onscreen elements to give the user feedback
- (IBAction)colorSlider1ValueChanged:(id)sender {
    self.colorSliderValueLabel1.text = [NSString stringWithFormat:@"%d", (int)self.colorSlider1.value];
    [self updateColorSwatchView];
    //self.colorDisplay.backgroundColor = [UIColor redColor];
}

- (IBAction)colorSlider2ValueChanged:(id)sender {
    self.colorSliderValueLabel2.text = [NSString stringWithFormat:@"%d", (int)self.colorSlider2.value];
    [self updateColorSwatchView];
    //self.colorDisplay.backgroundColor = [UIColor greenColor];
}

- (IBAction)colorSlider3ValueChanged:(id)sender {
    self.colorSliderValueLabel3.text = [NSString stringWithFormat:@"%d", (int)self.colorSlider3.value];
    [self updateColorSwatchView];
    //self.colorDisplay.backgroundColor = [UIColor blueColor];
}

- (IBAction)colorSlider4ValueChanged:(id)sender {
    self.colorSliderValueLabel4.text = [NSString stringWithFormat:@"%d", (int)self.colorSlider4.value];
    [self updateColorSwatchView];
    //self.colorDisplay.backgroundColor = [UIColor blackColor];
}

// typically called when a new color swatch is selected and the colorSliders need to be adjusted to
// reflect the new color's RGBA components
- (void)updateColorSliders:(UIView *)selectedColorSwatchView {
    CGFloat R, G, B, A;
    [selectedColorSwatchView.backgroundColor getRed:&R green:&G blue:&B alpha:&A];
    
    R *= 255.f;
    G *= 255.f;
    B *= 255.f;
    A *= 100.f;
    
    //NSLog(@"%f, %f, %f, %f", R, G, B, A);
    
    self.colorSlider1.value = R;
    self.colorSliderValueLabel1.text = [NSString stringWithFormat:@"%d", (int)R];
    self.colorSlider2.value = G;
    self.colorSliderValueLabel2.text = [NSString stringWithFormat:@"%d", (int)G];
    self.colorSlider3.value = B;
    self.colorSliderValueLabel3.text = [NSString stringWithFormat:@"%d", (int)B];
    self.colorSlider4.value = A;
    self.colorSliderValueLabel4.text = [NSString stringWithFormat:@"%d", (int)A];
}


#pragma mark -- UIView colorSwatchView methods

// these methods give the user feedback, showing which color swatch they have selected
- (void)colorSwatchView1Selected:(UITapGestureRecognizer *)gestureRecognizer {
    [self unselectAllColorSwatchViews];
    
    self.colorSwatchView1.layer.borderColor = [UIColor whiteColor].CGColor;
    self.colorSwatchView1.layer.borderWidth = 3.0f;
    selectedColorSwatchView = 0;
    [self updateColorSliders:self.colorSwatchView1];
}

- (void)colorSwatchView2Selected:(UITapGestureRecognizer *)gestureRecognizer {
    [self unselectAllColorSwatchViews];
    
    self.colorSwatchView2.layer.borderColor = [UIColor whiteColor].CGColor;
    self.colorSwatchView2.layer.borderWidth = 3.0f;
    selectedColorSwatchView = 1;
    [self updateColorSliders:self.colorSwatchView2];
}

- (void)colorSwatchView3Selected:(UITapGestureRecognizer *)gestureRecognizer {
    [self unselectAllColorSwatchViews];
    
    self.colorSwatchView3.layer.borderColor = [UIColor whiteColor].CGColor;
    self.colorSwatchView3.layer.borderWidth = 3.0f;
    selectedColorSwatchView = 2;
    [self updateColorSliders:self.colorSwatchView3];
}

- (void)colorSwatchView4Selected:(UITapGestureRecognizer *)gestureRecognizer {
    [self unselectAllColorSwatchViews];
    
    self.colorSwatchView4.layer.borderColor = [UIColor whiteColor].CGColor;
    self.colorSwatchView4.layer.borderWidth = 3.0f;
    selectedColorSwatchView = 3;
    [self updateColorSliders:self.colorSwatchView4];
}

- (void)unselectAllColorSwatchViews {
    for (UIView *colorSwatchView in colorSwatchViews) {
        colorSwatchView.layer.borderColor = [UIColor clearColor].CGColor;
        colorSwatchView.layer.borderWidth = 0.0f;
    }
}

// Presents a UIAlertController allowing the user to give their new color a name
// before saving it to the phone
- (IBAction)saveHue:(id)sender {
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
                                                                                        RedVal:self.colorSlider1.value
                                                                                      GreenVal:self.colorSlider2.value
                                                                                       BlueVal:self.colorSlider3.value
                                                                                      AlphaVal:self.colorSlider4.value];
                                   } else {
                                       NSLog(@"%@", hueNameTextField.text);
                                       [databaseMethodsClassInstance saveHueToDatabaseWithName:hueNameTextField.text
                                                                                        RedVal:self.colorSlider1.value
                                                                                      GreenVal:self.colorSlider2.value
                                                                                       BlueVal:self.colorSlider3.value
                                                                                      AlphaVal:self.colorSlider4.value];
                                   }
                               }];
    
    [alertController addAction:cancelAction];
    [alertController addAction:saveAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark -- LoadColorDelegate protocol method

// values returned from the LoadColorVC
- (void)returnHueValues:(float *)hueValues {
    NSLog(@"returnHueValues triggered");
    
    UIView *colorSwatchToUpdate = [colorSwatchViews objectAtIndex:selectedColorSwatchView];
    colorSwatchToUpdate.backgroundColor = [UIColor colorWithRed:hueValues[0]/255.f
                                                          green:hueValues[1]/255.f
                                                           blue:hueValues[2]/255.f
                                                          alpha:hueValues[3]/100.f];
    
    [self updateColorSliders:colorSwatchToUpdate];
}// end returnHueValues

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    LoadColorViewController *loadColorVC =(LoadColorViewController*)segue.destinationViewController;
    loadColorVC.delegate = self;
    //editVC.infoString = self.infoLabel.text;
    
}

@end
