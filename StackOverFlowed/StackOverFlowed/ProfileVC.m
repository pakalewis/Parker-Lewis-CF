//
//  ProfileVC.m
//  StackOverFlowed
//
//  Created by Parker Lewis on 11/13/14.
//  Copyright (c) 2014 CodeFellows. All rights reserved.
//

#import "ProfileVC.h"
#import "User.h"
#import "NetworkController.h"
#import <SVProgressHUD.h>
#import "WebVC.h"
#import "NSString+HTML.h"

@interface ProfileVC ()

@end

@implementation ProfileVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:true];

    [SVProgressHUD show];
    
    self.countsLabel.text = @"";
    self.usernameLabel.text = @"";
    
    
    if (self.shouldDisplayMainUser) {
        // should display main user
        NSString *requestURLString;
        NSString *token = [[NSUserDefaults standardUserDefaults] valueForKey:@"token"];
        requestURLString = [NSString stringWithFormat: @"https://api.stackexchange.com/2.2/me?order=desc&sort=reputation&site=stackoverflow&filter=!G*lE4GjY0j6tW*dQy5SwEQdm8i&access_token=%@&key=stuvaUJEX6kTlkHrvBNZVA((", token];
        
        [[NetworkController networkController] fetchJSONDataFrom:requestURLString withCompletion:^(NSString *errorString, NSData *rawJSONData) {
            if (errorString != nil) {
                NSLog(@"There was an error: %@", errorString);
            } else {
                NSMutableArray *me = [[User alloc] parseJSONIntoUserArrayFrom:rawJSONData];
                NSLog(@"COUNT OF ME ARRAY SHOULD BE ONE:  %lu",(unsigned long)me.count);
                self.currentUser = me.firstObject;
                [self populateProfileInfo];
            }
        }];
        
    } else {
        [self populateProfileInfo];
    }
}


-(void)populateProfileInfo  {
    // populate profile info
    self.countsLabel.text = [NSString stringWithFormat:@"Profile views: %ld\nQuestions asked: %ld\nQuestions answered: %ld\nUpvotes: %ld\nDownvotes: %ld", self.currentUser.viewCount, self.currentUser.questionCount, self.currentUser.answerCount, self.currentUser.upvoteCount, self.currentUser.downvoteCount];
    self.usernameLabel.text = [self.currentUser.displayName kv_decodeHTMLCharacterEntities];

    
    [[NetworkController networkController] fetchProfileImageForUser:self.currentUser.profileImageURL withCompletion:^(UIImage *image) {
        self.profileImageView.image = image;
        [SVProgressHUD dismiss];
    }];

}

-(IBAction) profileLinkButtonPressed : (id) sender; {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    WebVC *newWebVC = [storyboard instantiateViewControllerWithIdentifier:@"WEB_VC"];
    newWebVC.profileURL = self.currentUser.link;
    [self.navigationController pushViewController:newWebVC animated:true];
}


@end
