//
//  ColorAppNavigationController.m
//  ColorApp
//
//  Created by Michael Berg on 6/22/15.
//  Copyright (c) 2015 Michael Berg. All rights reserved.
//
//  Custom class whose superclass is UINavigationController. This subclass is made
//  to change the colors of the navigation bar and the text shown to better fit
//  the desired aesthetic

#import "ColorAppNavigationController.h"

@interface ColorAppNavigationController ()

@end

@implementation ColorAppNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationBar.barTintColor = [UIColor darkGrayColor];
    self.navigationBar.barStyle = UIBarStyleBlack;
    self.navigationBar.tintColor = [UIColor whiteColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
