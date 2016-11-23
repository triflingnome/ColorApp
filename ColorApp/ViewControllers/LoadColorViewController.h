//
//  LoadColorViewController.h
//  ColorApp
//
//  Created by Michael Berg on 6/29/15.
//  Copyright (c) 2015 Michael Berg. All rights reserved.
//
//  Similar in functionality to SavedColorsVC, but doesn't allow for deletion, only relaying
//  values back to ColorPickerVC. Implements the Delegate design pattern to send those values
//  back to ColorPickerVC

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "LoadColorTableViewCell.h"
#import "TipsMethods.h"
#import "Constants.h"

@protocol LoadColorDelegate <NSObject>

-(void)returnHueValues:(float *)hueValues;

@end

@interface LoadColorViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, weak) id <LoadColorDelegate> delegate;

@end
