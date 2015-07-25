//
//  ColorOfPoint.m
//  ColorApp
//
//  Created by Michael Berg on 7/6/15.
//  Copyright (c) 2015 Michael Berg. All rights reserved.
//
//  Contains methods relating to color conversion or retrival

#import "ColorMethods.h"

@implementation ColorMethods

// Returns an unsigned char array of 4 elements, representing the Red, Green, Blue, Alpha
// components of a color
- (unsigned char *) colorOfPoint:(CGPoint)point inViewLayer:(CALayer *)viewLayer
{
    unsigned char *pixel = (unsigned char *)malloc(sizeof(char) * 4);
    
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    CGContextRef context = CGBitmapContextCreate(pixel, 1, 1, 8, 4, colorSpace, kCGBitmapAlphaInfoMask & kCGImageAlphaPremultipliedLast);
    
    CGContextTranslateCTM(context, -point.x, -point.y);
    
    [viewLayer renderInContext:context];
    
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    
    //NSLog(@"in ColorMethods -- pixel: %d %d %d %d", pixel[0], pixel[1], pixel[2], pixel[3]);
    
    return pixel;
}

@end
