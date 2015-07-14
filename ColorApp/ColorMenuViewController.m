//
//  ColorMenuViewController.m
//  ColorApp
//
//  Created by Michael Berg on 6/22/15.
//  Copyright (c) 2015 Michael Berg. All rights reserved.
//

#import "ColorMenuViewController.h"

@interface ColorMenuViewController () {
    TipsMethods *tipsMethodsClassInstance;
}

@end

@implementation ColorMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    tipsMethodsClassInstance = [[TipsMethods alloc] init];
    [tipsMethodsClassInstance showNewUserTipFromViewController:self];
}// end viewDidLoad

- (IBAction)showInfoButtonTipSelector:(id)sender {
    [tipsMethodsClassInstance showInfoButtonTipWithTipNumber:0
                                            inViewController:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)colorExtractorButtonSingleTapped:(id)sender {
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    //imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    //imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
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
}// end colorExtractorButtonSingleTapped:

#pragma mark -- UIImagePickerViewController delegate methods

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    // Code here to work with media
    NSString *mediaType = info[UIImagePickerControllerMediaType];
    
    if ([mediaType isEqualToString:(NSString *)kUTTypeImage]) {
        UIImage *editedImage = info[UIImagePickerControllerEditedImage];
        
        // instantiate VC in NavCon, set property to editedImage and push
        ColorExtractorViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"ColorExtractorViewController"];
        vc.chosenImage = editedImage;
        
        [self.navigationController pushViewController:vc animated:YES];
    }// end if
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
