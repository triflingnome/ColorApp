//
//  SavedColorsViewController.h
//  ColorApp
//
//  Created by Michael Berg on 6/22/15.
//  Copyright (c) 2015 Michael Berg. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "SavedColorsTableViewCell.h"
#import "TipsMethods.h"
#import "Constants.h"

@interface SavedColorsViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end
