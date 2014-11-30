//
//  MenuVC.h
//  BurgerSample
//
//  Created by Parker Lewis on 11/24/14.
//  Copyright (c) 2014 CodeFellows. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BurgerVC.h"
#import "ToppingsVC.h"
#import "SidesVC.h"
#import "MealOrder.h"

@interface MenuVC : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) UIViewController *burgerVC;
@property (strong, nonatomic) UIViewController *toppingsVC;
@property (strong, nonatomic) UIViewController *sidesVC;
@property (strong, nonatomic) UIView *containerView;
@property (strong, nonatomic) MealOrder *mealOrder;


#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

- (IBAction)didPressMenuButton:(id)sender;

    
@end
