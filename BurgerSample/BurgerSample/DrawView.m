//
//  DrawView.m
//  BurgerSample
//
//  Created by Parker Lewis on 11/25/14.
//  Copyright (c) 2014 CodeFellows. All rights reserved.
//

#import "DrawView.h"

@implementation DrawView

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.


- (void)drawRect:(CGRect)rect {
    
    
    
    UIBezierPath *path = [[[UIBezierPath alloc] init] autorelease];
    [path moveToPoint:CGPointMake(10, 90)];
    [path addLineToPoint:CGPointMake(10, 80)];
    [path addLineToPoint:CGPointMake(20, 80)];
    [path addLineToPoint:CGPointMake(20, 60)];
    [path addLineToPoint:CGPointMake(10, 60)];
    [path addCurveToPoint:CGPointMake(90, 60) controlPoint1:CGPointMake(30, 30) controlPoint2:CGPointMake(70, 30)];
    [path addLineToPoint:CGPointMake(80, 60)];
    [path addLineToPoint:CGPointMake(80, 80)];
    [path addLineToPoint:CGPointMake(90, 80)];
    [path addLineToPoint:CGPointMake(90, 90)];
    [path addLineToPoint:CGPointMake(10, 90)];

    
    
    [path moveToPoint:CGPointMake(rect.origin.x, rect.origin.y)];
    [path addLineToPoint:CGPointMake(20, 10)];
    [path addLineToPoint:CGPointMake(20, 20)];
    [path addLineToPoint:CGPointMake(10, 20)];
    [path addLineToPoint:CGPointMake(10, 10)];

    
    
    path.lineWidth = 4;
    [[UIColor orangeColor] setFill];
    [[UIColor blackColor] setStroke];
    [path fill];
    [path stroke];
}



@end
