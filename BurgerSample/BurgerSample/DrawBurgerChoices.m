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
    

    // Draw sections
    UIBezierPath *path = [[[UIBezierPath alloc] init] autorelease];

    [path moveToPoint:CGPointMake(minX, midY)];
    [path addLineToPoint:CGPointMake(maxX, midY)];
    [path moveToPoint:CGPointMake(midX, minY)];
    [path addLineToPoint:CGPointMake(midX, maxY)];
    [[UIColor blackColor] setStroke];
    [path stroke];


    
    // MARK: HAMBURGER:

    // Bottom bun
    UIBezierPath *bottomBun = [[[UIBezierPath alloc] init] autorelease];
    [bottomBun moveToPoint:CGPointMake(midX * .1, midY * .7)];
    [bottomBun addLineToPoint:CGPointMake(midX * .9, midY * .7)];
    [bottomBun addCurveToPoint:CGPointMake(midX * .85, midY * .8) controlPoint1:CGPointMake(midX * .9, midY * .775) controlPoint2:CGPointMake(midX * .875, midY * .8)];
    [bottomBun addLineToPoint:CGPointMake(midX * .15, midY * .8)];
    [bottomBun addCurveToPoint:CGPointMake(midX * .1, midY * .7) controlPoint1:CGPointMake(midX * .125, midY * .8) controlPoint2:CGPointMake(midX * .1, midY * .725)];
    bottomBun.lineWidth = 3;
    [[UIColor orangeColor] setFill];
    [[UIColor blackColor] setStroke];
    [bottomBun fill];
    [bottomBun stroke];
    
    
    // Meat patty
    UIBezierPath *meatPatty = [[[UIBezierPath alloc] init] autorelease];
    [meatPatty moveToPoint:CGPointMake(midX * .15, midY * .7)];
    [meatPatty addLineToPoint:CGPointMake(midX * .15, midY * .6)];
    [meatPatty addLineToPoint:CGPointMake(midX * .85, midY * .6)];
    [meatPatty addLineToPoint:CGPointMake(midX * .85, midY * .7)];
    [meatPatty addLineToPoint:CGPointMake(midX * .15, midY * .7)];
    meatPatty.lineWidth = 3;
    [[UIColor brownColor] setFill];
    [[UIColor blackColor] setStroke];
    [meatPatty fill];
    [meatPatty stroke];
    
    
    // Tomato
    UIBezierPath *tomato = [[[UIBezierPath alloc] init] autorelease];
    [tomato moveToPoint:CGPointMake(midX * .175, midY * .6)];
    [tomato addLineToPoint:CGPointMake(midX * .175, midY * .5)];
    [tomato addLineToPoint:CGPointMake(midX * .825, midY * .5)];
    [tomato addLineToPoint:CGPointMake(midX * .825, midY * .6)];
    [tomato addLineToPoint:CGPointMake(midX * .175, midY * .6)];
    tomato.lineWidth = 2;
    [[UIColor redColor] setFill];
    [[UIColor blackColor] setStroke];
    [tomato fill];
    [tomato stroke];
    
    
    // Lettuce
    UIBezierPath *lettuce = [[[UIBezierPath alloc] init] autorelease];
    [lettuce moveToPoint:CGPointMake(midX * .1, midY * .475)];
    [lettuce addCurveToPoint:CGPointMake(midX * .3, midY * .475) controlPoint1:CGPointMake(midX * .175, midY * .45) controlPoint2:CGPointMake(midX * .225, midY * .45)];
    [lettuce addCurveToPoint:CGPointMake(midX * .5, midY * .475) controlPoint1:CGPointMake(midX * .375, midY * .5) controlPoint2:CGPointMake(midX * .425, midY * .5)];
    [lettuce addCurveToPoint:CGPointMake(midX * .7, midY * .475) controlPoint1:CGPointMake(midX * .575, midY * .45) controlPoint2:CGPointMake(midX * .625, midY * .45)];
    [lettuce addCurveToPoint:CGPointMake(midX * .9, midY * .475) controlPoint1:CGPointMake(midX * .775, midY * .5) controlPoint2:CGPointMake(midX * .825, midY * .5)];
    [lettuce addLineToPoint:CGPointMake(midX * .9, midY * .425)];
    [lettuce addCurveToPoint:CGPointMake(midX * .7, midY * .425) controlPoint1:CGPointMake(midX * .825, midY * .45) controlPoint2:CGPointMake(midX * .775, midY * .45)];
    [lettuce addCurveToPoint:CGPointMake(midX * .5, midY * .425) controlPoint1:CGPointMake(midX * .625, midY * .4) controlPoint2:CGPointMake(midX * .575, midY * .4)];
    [lettuce addCurveToPoint:CGPointMake(midX * .3, midY * .425) controlPoint1:CGPointMake(midX * .425, midY * .45) controlPoint2:CGPointMake(midX * .375, midY * .45)];
    [lettuce addCurveToPoint:CGPointMake(midX * .1, midY * .425) controlPoint1:CGPointMake(midX * .225, midY * .4) controlPoint2:CGPointMake(midX * .175, midY * .4)];
    [lettuce addLineToPoint:CGPointMake(midX * .1, midY * .475)];

    lettuce.lineWidth = 2;
    [[UIColor greenColor] setFill];
    [[UIColor blackColor] setStroke];
    [lettuce fill];
    [lettuce stroke];

    
    // Cheese
    UIBezierPath *cheese = [[[UIBezierPath alloc] init] autorelease];
    [cheese moveToPoint:CGPointMake(midX * .15, midY * .4)];
    [cheese addLineToPoint:CGPointMake(midX * .15, midY * .35)];
    [cheese addLineToPoint:CGPointMake(midX * .85, midY * .35)];
    [cheese addLineToPoint:CGPointMake(midX * .85, midY * .4)];
    [cheese addLineToPoint:CGPointMake(midX * .15, midY * .4)];
    cheese.lineWidth = 2;
    [[UIColor yellowColor] setFill];
    [[UIColor blackColor] setStroke];
    [cheese fill];
    [cheese stroke];
    
    

    
    // Top bun
    UIBezierPath *topBun = [[[UIBezierPath alloc] init] autorelease];
    [topBun moveToPoint:CGPointMake(midX * .2, midY * .35)];
    [topBun addCurveToPoint:CGPointMake(midX * .1, midY * .3) controlPoint1:CGPointMake(midX * .125, midY * .35) controlPoint2:CGPointMake(midX * .1, midY * .325)];
    [topBun addCurveToPoint:CGPointMake(midX * .5, midY * .175) controlPoint1:CGPointMake(midX * .1, midY * .225) controlPoint2:CGPointMake(midX * .2, midY * .175)];
    [topBun addCurveToPoint:CGPointMake(midX * .9, midY * .3) controlPoint1:CGPointMake(midX * .8, midY * .175) controlPoint2:CGPointMake(midX * .9, midY * .225)];
    [topBun addCurveToPoint:CGPointMake(midX * .8, midY * .35) controlPoint1:CGPointMake(midX * .9, midY * .325) controlPoint2:CGPointMake(midX * .875, midY * .35)];
    [topBun addLineToPoint:CGPointMake(midX * .2, midY * .35)];
    topBun.lineWidth = 3;
    [[UIColor orangeColor] setFill];
    [[UIColor blackColor] setStroke];
    [topBun fill];
    [topBun stroke];

    
    
    // MARK: HOT DOG:
    
    // Bottom bun
    UIBezierPath *bottomHotDogBun = [[[UIBezierPath alloc] init] autorelease];
    [bottomHotDogBun moveToPoint:CGPointMake(midX + midX * .25, midY * .65)];
    [bottomHotDogBun addLineToPoint:CGPointMake(midX + midX * .75, midY * .65)];
    [bottomHotDogBun addCurveToPoint:CGPointMake(midX + midX * .85, midY * .5) controlPoint1:CGPointMake(midX + midX * .80, midY * .65) controlPoint2:CGPointMake(midX + midX * .85, midY * .6)];
    [bottomHotDogBun addLineToPoint:CGPointMake(midX + midX * .15, midY * .5)];
    [bottomHotDogBun addCurveToPoint:CGPointMake(midX + midX * .25, midY * .65) controlPoint1:CGPointMake(midX + midX * .15, midY * .6) controlPoint2:CGPointMake(midX + midX * .2, midY * .65)];
    bottomHotDogBun.lineWidth = 3;
    [[UIColor orangeColor] setFill];
    [[UIColor blackColor] setStroke];
    [bottomHotDogBun fill];
    [bottomHotDogBun stroke];
    
    
    // Hot dog
    UIBezierPath *hotDog = [[[UIBezierPath alloc] init] autorelease];
    [hotDog moveToPoint:CGPointMake(midX + midX * .15, midY * .5)];
    [hotDog addLineToPoint:CGPointMake(midX + midX * .85, midY * .5)];
    [hotDog addCurveToPoint:CGPointMake(midX + midX * .9, midY * .45) controlPoint1:CGPointMake(midX + midX * .875, midY * .5) controlPoint2:CGPointMake(midX + midX * .9, midY * .475)];
    [hotDog addCurveToPoint:CGPointMake(midX + midX * .85, midY * .4) controlPoint1:CGPointMake(midX + midX * .9, midY * .425) controlPoint2:CGPointMake(midX + midX * .875, midY * .4)];
    [hotDog addLineToPoint:CGPointMake(midX + midX * .15, midY * .4)];
    [hotDog addCurveToPoint:CGPointMake(midX + midX * .1, midY * .45) controlPoint1:CGPointMake(midX + midX * .125, midY * .4) controlPoint2:CGPointMake(midX + midX * .1, midY * .425)];
    [hotDog addCurveToPoint:CGPointMake(midX + midX * .15, midY * .5) controlPoint1:CGPointMake(midX + midX * .1, midY * .475) controlPoint2:CGPointMake(midX + midX * .125, midY * .5)];
    hotDog.lineWidth = 3;
    [[UIColor brownColor] setFill];
    [[UIColor blackColor] setStroke];
    [hotDog fill];
    [hotDog stroke];
    
    
    // Top bun
    UIBezierPath *topHotDogBun = [[[UIBezierPath alloc] init] autorelease];
    [topHotDogBun moveToPoint:CGPointMake(midX + midX * .85, midY * .4)];
    [topHotDogBun addLineToPoint:CGPointMake(midX + midX * .15, midY * .4)];
    [topHotDogBun addCurveToPoint:CGPointMake(midX + midX * .25, midY * .3) controlPoint1:CGPointMake(midX + midX * .15, midY * .35) controlPoint2:CGPointMake(midX + midX * .2, midY * .3)];
    [topHotDogBun addLineToPoint:CGPointMake(midX + midX * .75, midY * .3)];
    [topHotDogBun addCurveToPoint:CGPointMake(midX + midX * .85, midY * .4) controlPoint1:CGPointMake(midX + midX * .8, midY * .3) controlPoint2:CGPointMake(midX + midX * .85, midY * .35)];
    topHotDogBun.lineWidth = 3;
    [[UIColor orangeColor] setFill];
    [[UIColor blackColor] setStroke];
    [topHotDogBun fill];
    [topHotDogBun stroke];
    
    // Ketchup
    UIBezierPath *ketchup = [[[UIBezierPath alloc] init] autorelease];
    [ketchup moveToPoint:CGPointMake(midX + midX * .15, midY * .475)];
    [ketchup addCurveToPoint:CGPointMake(midX + midX * .3, midY * .475) controlPoint1:CGPointMake(midX + midX * .175, midY * .45) controlPoint2:CGPointMake(midX + midX * .225, midY * .45)];
    [ketchup addCurveToPoint:CGPointMake(midX + midX * .5, midY * .475) controlPoint1:CGPointMake(midX + midX * .375, midY * .5) controlPoint2:CGPointMake(midX + midX * .425, midY * .5)];
    [ketchup addCurveToPoint:CGPointMake(midX + midX * .7, midY * .475) controlPoint1:CGPointMake(midX + midX * .575, midY * .45) controlPoint2:CGPointMake(midX + midX * .625, midY * .45)];
    [ketchup addCurveToPoint:CGPointMake(midX + midX * .85, midY * .475) controlPoint1:CGPointMake(midX + midX * .775, midY * .5) controlPoint2:CGPointMake(midX + midX * .825, midY * .5)];
    ketchup.lineWidth = 2;
    [[UIColor redColor] setStroke];
    [ketchup stroke];
    
    
    
    // Mustard
    UIBezierPath *mustard = [[[UIBezierPath alloc] init] autorelease];
    [mustard moveToPoint:CGPointMake(midX + midX * .15, midY * .45)];
    [mustard addCurveToPoint:CGPointMake(midX + midX * .3, midY * .45) controlPoint1:CGPointMake(midX + midX * .175, midY * .425) controlPoint2:CGPointMake(midX + midX * .225, midY * .425)];
    [mustard addCurveToPoint:CGPointMake(midX + midX * .5, midY * .45) controlPoint1:CGPointMake(midX + midX * .375, midY * .475) controlPoint2:CGPointMake(midX + midX * .425, midY * .475)];
    [mustard addCurveToPoint:CGPointMake(midX + midX * .7, midY * .45) controlPoint1:CGPointMake(midX + midX * .575, midY * .425) controlPoint2:CGPointMake(midX + midX * .625, midY * .425)];
    [mustard addCurveToPoint:CGPointMake(midX + midX * .85, midY * .45) controlPoint1:CGPointMake(midX + midX * .775, midY * .475) controlPoint2:CGPointMake(midX + midX * .825, midY * .475)];
    mustard.lineWidth = 2;
    [[UIColor yellowColor] setStroke];
    [mustard stroke];
    
    
    
    
}



@end
