//
//  SavedColorsTableViewCell.h
//  ColorApp
//
//  Created by Michael Berg on 7/1/15.
//  Copyright (c) 2015 Michael Berg. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SavedColorsTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIButton *deleteHueButton;

@property (strong, nonatomic) IBOutlet UIView *topView;
@property (strong, nonatomic) IBOutlet UIView *hueSwatchView;
@property (strong, nonatomic) IBOutlet UILabel *hueNameLabel;
@property (strong, nonatomic) IBOutlet UIButton *moveTopViewButton;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topViewTrailingSpaceConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topViewLeadingSpaceConstraint;

@end
