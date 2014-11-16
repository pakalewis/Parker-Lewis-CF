//
//  RootVC.m
//  StackOverFlowed
//
//  Created by Parker Lewis on 11/10/14.
//  Copyright (c) 2014 CodeFellows. All rights reserved.
//

#import "RootVC.h"
#import "Question.h"
#import "NetworkController.h"
#import "WebVC.h"
#import "UserSearchVC.h"
#import "QuestionSearchVC.h"
#import "ProfileVC.h"

@interface RootVC ()



@end

@implementation RootVC

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationController.delegate = self;
    
    self.title = NSLocalizedString(@"HOME", nil);
}


- (void)viewWillAppear:(BOOL)animated {
    UIBarButtonItem *loginButton = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"LOG IN", nil) style: UIBarButtonItemStylePlain target: self action: @selector(requestOAuthAccess:)];
    
    if (![[[NSUserDefaults standardUserDefaults] valueForKey:@"token"] isKindOfClass:[NSString class]]) {
        NSLog(@"Token available");
        self.navigationItem.rightBarButtonItem = loginButton;
    } else {
        self.navigationItem.rightBarButtonItem = nil;
    }    
}


- (void)requestOAuthAccess:(id)sender {
    NSLog(@"Log in button fired");

    // initialize next view controller
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    WebVC *newWebVC = [storyboard instantiateViewControllerWithIdentifier:@"WEB_VC"];
    [self.navigationController pushViewController:newWebVC animated:true];
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"token"] isKindOfClass:[NSString class]]) {
        // authenticated
        // proceed as normal
        
        if (indexPath.row == 0) {
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            QuestionSearchVC *newQuestionVC = [storyboard instantiateViewControllerWithIdentifier:@"QUESTION_VC"];
            [self.navigationController pushViewController:newQuestionVC animated:true];
        }
        if (indexPath.row == 1) {
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            UserSearchVC *userSearchVC = [storyboard instantiateViewControllerWithIdentifier:@"USER_SEARCH_VC"];
            [self.navigationController pushViewController:userSearchVC animated:true];
        }
        if (indexPath.row == 2) {
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            ProfileVC *newProfileVC = [storyboard instantiateViewControllerWithIdentifier:@"PROFILE_VC"];
            newProfileVC.shouldDisplayMainUser = YES;
            [self.navigationController pushViewController:newProfileVC animated:true];
        }

        
    } else {
        // not authenticated = no token
        // present alert to tell them to log in
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Please Log In!" message:@"You are not yet logged in to your Stack Exchange account." preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *loginAction = [UIAlertAction actionWithTitle:@"Log in" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [self requestOAuthAccess:self];
        }];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:okAction];
        [alert addAction:loginAction];
        [self presentViewController:alert animated:true completion:nil];
    }

    
}



@end
