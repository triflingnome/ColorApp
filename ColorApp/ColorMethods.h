//
//  ColorMethods.h
//  ColorApp
//
//  Created by Michael Berg on 7/6/15.
//  Copyright (c) 2015 Michael Berg. All rights reserved.
//
//  Contains methods relating to color conversion or retrival

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ColorMethods : NSObject

- (unsigned char *) colorOfPoint:(CGPoint)point inViewLayer:(CALayer *)viewLayer;

@end
