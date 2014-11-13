//
//  User.m
//  StackOverFlowed
//
//  Created by Parker Lewis on 11/13/14.
//  Copyright (c) 2014 CodeFellows. All rights reserved.
//

#import "User.h"

@implementation User


- (instancetype) initWith: (NSData *) rawJSONDATA {
    self = [super init];
    if (self) {

        NSError * error = nil;
        NSDictionary *userDict = [NSJSONSerialization JSONObjectWithData:rawJSONDATA options:0 error:&error];

        NSLog(@"%@",userDict);
        
        // pull out items Array from the JSON
        NSArray *items = userDict[@"items"];
        
        NSDictionary *itemArray = items.firstObject;
        
        self.displayName = itemArray[@"display_name"];
        self.profileImageURL = itemArray[@"profile_image"];
        self.link = itemArray[@"link"];
        self.aboutMe = itemArray[@"about_me"];
        self.questionCount = [itemArray[@"question_count"] integerValue];
        self.answerCount = [itemArray[@"answer_count"] integerValue];
        self.upvoteCount = [itemArray[@"upvote_count"] integerValue];
        self.downvoteCount = [itemArray[@"downvote_count"] integerValue];
        self.viewCount = [itemArray[@"view_count"] integerValue];
    }
    return self;
}

@end
