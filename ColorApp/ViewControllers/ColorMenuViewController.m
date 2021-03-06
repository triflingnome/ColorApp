//
//  ColorMenuViewController.m
//  ColorApp
//
//  Created by Michael Berg on 6/22/15.
//  Copyright (c) 2015 Michael Berg. All rights reserved.
//
//  The root screen of the navigation controller which allows for accessing the other
//  screens in the app

#import "ColorMenuViewController.h"

#import "ColorApp-Swift.h"

@interface ColorMenuViewController () {
    TipsMethods *tipsMethodsClassInstance;
}

@end

@implementation ColorMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    tipsMethodsClassInstance = [[TipsMethods alloc] init];
    [tipsMethodsClassInstance showNewUserTipFromViewController:self];// tips that only displays once,
                                                                     // informing them of the tip system
}

#pragma mark -- Button Actions

- (IBAction)showInfoButtonTipSelector:(id)sender {
    [tipsMethodsClassInstance showInfoButtonTipWithTipNumber:0
                                            inViewController:self];
}

// query's the user to pick an image source they want to get colors from
- (IBAction)colorExtractorButtonSingleTapped:(id)sender {
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    imagePicker.mediaTypes = @[(NSString *) kUTTypeImage];
    imagePicker.allowsEditing = YES;
    
    UIAlertController *actionSheetAlertController = [UIAlertController alertControllerWithTitle:@"Choose Hue Extractor Image Source"
                                                                                        message:@"The Hue Extractor requires an image to work with. Do you want to take a picture with your camera or upload one from your photo library?"
                                                                                 preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"Cancel", @"Cancel Action")
                                                           style:UIAlertActionStyleCancel
                                                         handler:^(UIAlertAction *action) {
                                                            NSLog(@"Cancel Action");
                                                         }];
    [actionSheetAlertController addAction:cancelAction];
    UIAlertAction *cameraAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"Camera", @"Camera Action")
                                                           style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction *action) {
                                                             NSLog(@"Camera Action");
                                                             imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
                                                             [self presentViewController:imagePicker animated:YES completion: nil];
                                                         }];
    [actionSheetAlertController addAction:cameraAction];
    UIAlertAction *photosAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"Photo Library", @"Photo Library Action")
                                                           style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction *action) {
                                                             NSLog(@"Photos Action");
                                                             imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                                                             [self presentViewController:imagePicker animated:YES completion: nil];
                                                         }];
    [actionSheetAlertController addAction:photosAction];
    
    [self presentViewController:actionSheetAlertController animated:YES completion:nil];
}

- (IBAction)colorPickerButtonSingleTapped:(id)sender {
    HHPickerNavigationHandler *pickerNavigationHandler = [[HHPickerNavigationHandler alloc] initWithNavigationController:self.navigationController
                                                                                                                animated:YES
                                                                                                              storyboard:self.storyboard];
    [pickerNavigationHandler handleNavigation];
}

- (IBAction)colorCollectionButtonSingleTapped:(id)sender {
    HHSavedNavigationHandler *savedNavigationHandler = [[HHSavedNavigationHandler alloc] initWithNavigationController:self.navigationController
                                                                                                             animated:YES
                                                                                                           storyboard:self.storyboard];
    [savedNavigationHandler handleNavigation];
}

#pragma mark -- UIImagePickerViewController delegate methods

// after the image source has been determined, that data is sent to the ColorExtractorVC to be worked with
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    NSString *mediaType = info[UIImagePickerControllerMediaType];
    
    if ([mediaType isEqualToString:(NSString *)kUTTypeImage]) {
        UIImage *editedImage = info[UIImagePickerControllerEditedImage];
        
        HHExtractorNavigationHandler *extractorNavigationHandler = [[HHExtractorNavigationHandler alloc] initWithNavigationController:self.navigationController
                                                                                                                             animated:YES
                                                                                                                                image:editedImage
                                                                                                                           storyboard:self.storyboard];
        [extractorNavigationHandler handleNavigation];
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
