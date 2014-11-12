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

@interface RootVC ()



@end

@implementation RootVC

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationController.delegate = self;
    
    self.title = @"HOME";
}


- (void)viewWillAppear:(BOOL)animated {
    UIBarButtonItem *loginButton = [[UIBarButtonItem alloc] initWithTitle:@"LOGIN" style: UIBarButtonItemStylePlain target: self action: @selector(requestOAuthAccess:)];
    
    if (![[[NSUserDefaults standardUserDefaults] valueForKey:@"token"] isKindOfClass:[NSString class]]) {
        NSLog(@"Token available");
        self.navigationItem.rightBarButtonItem = loginButton;
    } else {
        self.navigationItem.rightBarButtonItem = nil;
    }    
}


- (void)requestOAuthAccess:(id)sender {
    NSLog(@"FIRED");

    // initialize next view controller
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    WebVC *newWebVC = [storyboard instantiateViewControllerWithIdentifier:@"WEB_VC"];
    [self.navigationController pushViewController:newWebVC animated:true];
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"TEST");
}



@end
