//
//  LoadColorViewController.h
//  ColorApp
//
//  Created by Michael Berg on 6/29/15.
//  Copyright (c) 2015 Michael Berg. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "LoadColorTableViewCell.h"
#import "TipsMethods.h"
#import "Constants.h"

@protocol LoadColorDelegate <NSObject>

-(void)returnHueValues:(float *)hueValues;

@end

@interface LoadColorViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, weak) id <LoadColorDelegate> delegate;

@end
