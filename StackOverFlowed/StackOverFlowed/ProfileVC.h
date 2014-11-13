//
//  ProfileVC.h
//  StackOverFlowed
//
//  Created by Parker Lewis on 11/13/14.
//  Copyright (c) 2014 CodeFellows. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

@interface ProfileVC : UIViewController

@property (nonatomic, weak) IBOutlet UIImageView *profileImageView;
@property (nonatomic, weak) IBOutlet UILabel *usernameLabel;
@property (nonatomic, weak) IBOutlet UILabel *countsLabel;

@property (nonatomic, strong) User *currentUser;


@end
