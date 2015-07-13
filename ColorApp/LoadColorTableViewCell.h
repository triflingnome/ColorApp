//
//  LoadColorTableViewCell.h
//  ColorApp
//
//  Created by Michael Berg on 7/1/15.
//  Copyright (c) 2015 Michael Berg. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoadColorTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIView *hueSwatchView;
@property (strong, nonatomic) IBOutlet UILabel *hueNameLabel;

@end
