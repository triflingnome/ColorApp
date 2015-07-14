//
//  ColorMenuViewController.h
//  ColorApp
//
//  Created by Michael Berg on 6/22/15.
//  Copyright (c) 2015 Michael Berg. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MobileCoreServices/UTCoreTypes.h>
#import "ColorExtractorViewController.h"
#import "TipsMethods.h"
#import "Constants.h"

@interface ColorMenuViewController : UIViewController <UIImagePickerControllerDelegate>

@property (nonatomic) IBOutlet UIBarButtonItem *infoBarButton;

@end
