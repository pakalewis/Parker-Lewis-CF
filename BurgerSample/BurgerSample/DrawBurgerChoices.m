//
//  DrawBurgerChoices.m
//  BurgerSample
//
//  Created by Parker Lewis on 11/25/14.
//  Copyright (c) 2014 CodeFellows. All rights reserved.
//

#import "DrawBurgerChoices.h"

@implementation DrawBurgerChoices



- (void)drawRect:(CGRect)rect {
    
    
//    CGPoint center = CGPointMake(CGRectGetMidX(rect), CGRectGetMidY(rect));
    
    float minX = CGRectGetMinX(rect);
    float minY = CGRectGetMinY(rect);
    float midX = CGRectGetMidX(rect);
    float midY = CGRectGetMidY(rect);
    float maxX = CGRectGetMaxX(rect);
    float maxY = CGRectGetMaxY(rect);
    
    UIBezierPath *path = [[[UIBezierPath alloc] init] autorelease];

    // Draw sections
    [path moveToPoint:CGPointMake(minX, midY)];
    [path addLineToPoint:CGPointMake(maxX, midY)];
    [path moveToPoint:CGPointMake(midX, minY)];
    [path addLineToPoint:CGPointMake(midX, maxY)];
    

    
    [path moveToPoint:CGPointMake(midX * .1, midY * .9)];
    [path addLineToPoint:CGPointMake(midX * .1, midY * .8)];
    [path addLineToPoint:CGPointMake(midX * .2, midY * .8)];
    [path addLineToPoint:CGPointMake(midX * .2, midY * .6)];
    [path addLineToPoint:CGPointMake(midX * .1, midY * .6)];
    [path addLineToPoint:CGPointMake(midX * .1, midY * .55)];
    [path addCurveToPoint:CGPointMake(midX * .5, midY * .3) controlPoint1:CGPointMake(midX * .1, midY * .5) controlPoint2:CGPointMake(midX * .4, midY * .3)];
    [path addCurveToPoint:CGPointMake(midX * .9, midY * .55) controlPoint1:CGPointMake(midX * .6, midY * .3) controlPoint2:CGPointMake(midX * .9, midY * .5)];
    [path addLineToPoint:CGPointMake(midX * .9, midY * .6)];
    [path addLineToPoint:CGPointMake(midX * .8, midY * .6)];
    [path addLineToPoint:CGPointMake(midX * .8, midY * .8)];
    [path addLineToPoint:CGPointMake(midX * .9, midY * .8)];
    [path addLineToPoint:CGPointMake(midX * .9, midY * .9)];
    [path addLineToPoint:CGPointMake(midX * .1, midY * .9)];

    
    
    [path moveToPoint:CGPointMake(maxX * .6, midY * .4)];
    [path addLineToPoint:CGPointMake(maxX * .9, midY * .4)];
    [path addLineToPoint:CGPointMake(maxX * .9, midY * .9)];
    [path addLineToPoint:CGPointMake(maxX * .9, midY * .9)];
    [path addLineToPoint:CGPointMake(maxX * .9, midY * .9)];
    [path addLineToPoint:CGPointMake(maxX * .9, midY * .9)];

    
    
    path.lineWidth = 4;
    [[UIColor orangeColor] setFill];
    [[UIColor blackColor] setStroke];
    [path fill];
    [path stroke];
}



@end
