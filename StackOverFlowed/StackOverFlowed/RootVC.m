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
        NSLog(@"Token not available");
        self.navigationItem.rightBarButtonItem = loginButton;
        self.isAuthenticated = NO;
    } else {
        self.navigationItem.rightBarButtonItem = nil;
        self.isAuthenticated = YES;
    }    
}


- (void)requestOAuthAccess:(id)sender {
    NSLog(@"Log in button fired");

    // initialize next view controller
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    WebVC *newWebVC = [storyboard instantiateViewControllerWithIdentifier:@"WEB_VC"];
    [self.navigationController pushViewController:newWebVC animated:true];
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat height = CGRectGetHeight(self.view.bounds);
    return (height - 30) / 3;
}




@end
