//
//  User.m
//  StackOverFlowed
//
//  Created by Parker Lewis on 11/13/14.
//  Copyright (c) 2014 CodeFellows. All rights reserved.
//

#import "User.h"

@implementation User


- (instancetype) initWithQuestionItemDict: (NSDictionary *) questionItemDict {
    self = [super init];
    if (self) {
        self.displayName = questionItemDict[@"display_name"];
        self.profileImageURL = questionItemDict[@"profile_image"];
        self.link = questionItemDict[@"link"];
        self.aboutMe = questionItemDict[@"about_me"];
        self.questionCount = [questionItemDict[@"question_count"] integerValue];
        self.answerCount = [questionItemDict[@"answer_count"] integerValue];
        self.upvoteCount = [questionItemDict[@"upvote_count"] integerValue];
        self.downvoteCount = [questionItemDict[@"downvote_count"] integerValue];
        self.viewCount = [questionItemDict[@"view_count"] integerValue];
    }
    return self;
}


- (NSMutableArray *) parseJSONIntoUserArrayFrom:(NSData *) data {
    NSError * error = nil;
    NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
    // pull out items Array from the JSON
    NSMutableArray *items = jsonDict[@"items"];
    
    NSMutableArray *users = [[NSMutableArray alloc] init];
    for (NSDictionary *item in items) {
        User *newUser = [[User alloc] initWithQuestionItemDict:item];
        [users addObject: newUser];
    }
    return users;
}

@end
