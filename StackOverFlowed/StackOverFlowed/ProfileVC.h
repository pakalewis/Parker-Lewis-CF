//
//  ProfileVC.h
//  StackOverFlowed
//
//  Created by Parker Lewis on 11/13/14.
//  Copyright (c) 2014 CodeFellows. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

@interface ProfileVC : UIViewController <UINavigationControllerDelegate>

@property (nonatomic, weak) IBOutlet UIImageView *profileImageView;
@property (nonatomic, weak) IBOutlet UILabel *usernameLabel;
@property (nonatomic, weak) IBOutlet UILabel *countsLabel;


@property (nonatomic, assign) BOOL isAuthenticated;
@property (nonatomic, assign) BOOL showSelectedUser;
@property (nonatomic, strong) User *currentUser;


 -(IBAction) profileLinkButtonPressed : (id) sender;



@end
