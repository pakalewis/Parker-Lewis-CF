//
//  User.m
//  StackOverFlowed
//
//  Created by Parker Lewis on 11/13/14.
//  Copyright (c) 2014 CodeFellows. All rights reserved.
//

#import "User.h"

@implementation User


- (instancetype) initWith: (NSDictionary *) rawJSONDATA {
    self = [super init];
    if (self) {

        
        
        
        self.displayName = rawJSONDATA[@"display_name"];
        self.profileImageURL = rawJSONDATA[@"profile_image"];
        self.link = rawJSONDATA[@"link"];
        self.aboutMe = rawJSONDATA[@"about_me"];
        self.questionCount = [rawJSONDATA[@"question_count"] integerValue];
        self.answerCount = [rawJSONDATA[@"answer_count"] integerValue];
        self.upvoteCount = [rawJSONDATA[@"upvote_count"] integerValue];
        self.downvoteCount = [rawJSONDATA[@"downvote_count"] integerValue];
        self.viewCount = [rawJSONDATA[@"view_count"] integerValue];
    }
    return self;
}

@end
