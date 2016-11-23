//
//  SavedColorsViewController.h
//  ColorApp
//
//  Created by Michael Berg on 6/22/15.
//  Copyright (c) 2015 Michael Berg. All rights reserved.
//
//  This screen shows the user all their saved colors and allows them to delete any color
//  they wish. SavedColorTableViewCell is used for this screen's table view

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "SavedColorsTableViewCell.h"
#import "TipsMethods.h"
#import "DatabaseMethods.h"
#import "Constants.h"

@interface SavedColorsViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end
