//
//  MenuVC.h
//  BurgerSample
//
//  Created by Parker Lewis on 11/24/14.
//  Copyright (c) 2014 CodeFellows. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuVC : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) UIViewController *toppingsVC;
@property (strong, nonatomic) UIViewController *sidesVC;
@property (strong, nonatomic) UIView *containerView;
@property (assign, nonatomic) IBOutlet UIButton *menuButton;
@property (assign, nonatomic) IBOutlet UITableView *menuTableView;


- (IBAction)didPressMenuButton:(id)sender;

    
@end
