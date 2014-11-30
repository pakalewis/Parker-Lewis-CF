//
//  MealOrder.h
//  BurgerSample
//
//  Created by Parker Lewis on 11/24/14.
//  Copyright (c) 2014 CodeFellows. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MealOrder : NSObject


typedef enum {
    hamburger,
    hotdog,
    pizza,
    taco
} mainMeal;



@property (assign, nonatomic) BOOL tomato;
@property (assign, nonatomic) BOOL onion;
@property (assign, nonatomic) BOOL lettuce;
@property (assign, nonatomic) BOOL ketchup;
@property (assign, nonatomic) BOOL mustard;


@end
