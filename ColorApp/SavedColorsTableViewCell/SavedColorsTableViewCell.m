//
//  SavedColorsTableViewCell.m
//  ColorApp
//
//  Created by Michael Berg on 7/1/15.
//  Copyright (c) 2015 Michael Berg. All rights reserved.
//
//  Custom class whose super class is UITableViewCell so I could customize the
//  cell to specifications

#import "SavedColorsTableViewCell.h"
#define ANIMATION_DURATION 0.5f // in class constant for how long the cell's movement would take
#define CELL_ADJUST -100 // in class constant for how far the cell displaces
#define ANIMATION_DELAY 0.0f // in class constant for any delay before animation

@implementation SavedColorsTableViewCell {
    Boolean topViewAdjusted;
    
    NSLayoutConstraint *originTopViewLeadingSpaceLayoutConstraint;
    NSLayoutConstraint *originTopViewTrailingSpaceLayoutConstraint;
    
    NSLayoutConstraint *adjustedTopViewLeadingSpaceLayoutConstraint;
    NSLayoutConstraint *adjustedTopViewTrailingSpaceLayoutConstraint;
}

// the cell adjusts its position on the screen by changing the LayoutConstraints and move it
// to a new position and animation the change, simulating a the cell sliding left or right
- (void)awakeFromNib {
    // Initialization code
    topViewAdjusted = false;
    
    originTopViewLeadingSpaceLayoutConstraint = self.topViewLeadingSpaceConstraint;
    originTopViewTrailingSpaceLayoutConstraint = self.topViewTrailingSpaceConstraint;
    
    adjustedTopViewLeadingSpaceLayoutConstraint = [NSLayoutConstraint constraintWithItem:self.topView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeading multiplier:1.0 constant:CELL_ADJUST];
    adjustedTopViewTrailingSpaceLayoutConstraint = [NSLayoutConstraint constraintWithItem:self.topView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:CELL_ADJUST];
    
    [self.moveTopViewButton setImage:[UIImage imageNamed:@"Expand-Arrow"] forState:UIControlStateNormal];
    [self.moveTopViewButton setImage:[UIImage imageNamed:@"Collapse-Arrow"] forState:UIControlStateHighlighted];
}

// switches out constraints declared further up to either move the cell to the left or right
- (IBAction)moveTopViewButtonTapped:(id)sender {
    if (!topViewAdjusted) {
        self.moveTopViewButton.highlighted = true;
        [self.contentView setNeedsDisplay];
        
        [UIView animateWithDuration:ANIMATION_DURATION
                              delay:ANIMATION_DELAY
                            options:UIViewAnimationOptionCurveEaseOut
                         animations:^{
                             [self.contentView removeConstraint:self.topViewLeadingSpaceConstraint];
                             [self.contentView addConstraint:adjustedTopViewLeadingSpaceLayoutConstraint];
                             [self.contentView removeConstraint:self.topViewTrailingSpaceConstraint];
                             [self.contentView addConstraint:adjustedTopViewTrailingSpaceLayoutConstraint];
                             
                             [self.contentView layoutIfNeeded];
                         }completion:nil];
        
        self.topViewLeadingSpaceConstraint = adjustedTopViewLeadingSpaceLayoutConstraint;
        self.topViewTrailingSpaceConstraint = adjustedTopViewTrailingSpaceLayoutConstraint;
        
        //self.moveTopViewButton.imageView.image = [UIImage imageNamed:@"Collapse-Arrow"];
        
        topViewAdjusted = true;
    } else {// if topViewAdjusted
        self.moveTopViewButton.highlighted = false;
        [self.contentView setNeedsDisplay];
        
        [UIView animateWithDuration:ANIMATION_DURATION
                              delay:ANIMATION_DELAY
                            options:UIViewAnimationOptionCurveEaseOut
                         animations:^{
                             [self.contentView removeConstraint:self.topViewLeadingSpaceConstraint];
                             [self.contentView addConstraint:originTopViewLeadingSpaceLayoutConstraint];
                             [self.contentView removeConstraint:self.topViewTrailingSpaceConstraint];
                             [self.contentView addConstraint:originTopViewTrailingSpaceLayoutConstraint];
                             
                             [self.contentView layoutIfNeeded];
                         }completion:nil];
        
        self.topViewLeadingSpaceConstraint = originTopViewLeadingSpaceLayoutConstraint;
        self.topViewTrailingSpaceConstraint = originTopViewTrailingSpaceLayoutConstraint;
        
        //self.moveTopViewButton.imageView.image = [UIImage imageNamed:@"Expand-Arrow"];
        
        topViewAdjusted = false;
    }// end if-else
    
}// end moveTopViewButtonTapped

- (IBAction)deleteHueButtonTapped:(id)sender {
    NSLog(@"deleteHueButton tapped");
    NSLog(@"cell hue name: %@", self.hueNameLabel.text);
}

@end
