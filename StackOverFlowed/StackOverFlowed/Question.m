//
//  Question.m
//  StackOverFlowed
//
//  Created by Parker Lewis on 11/10/14.
//  Copyright (c) 2014 CodeFellows. All rights reserved.
//

#import "Question.h"


@implementation Question



- (instancetype) initWith: (NSDictionary *) questionItemDict {
    self = [super init];
    if (self) {
        self.title = (NSString*) questionItemDict[@"title"];
        self.link = (NSString*) questionItemDict[@"link"];
        self.question_id = questionItemDict[@"question_id"];
        self.score = [questionItemDict[@"score"] integerValue];
        self.answer_count = [questionItemDict[@"answer_count"] integerValue];
        self.view_count = [questionItemDict[@"view_count"] integerValue];
//        if ([questionItemDict[@"is_answered"]  isEqual: @"false"]) {
//            self.is_answered = false;
//        } else {
//            self.is_answered = true;
//        }
    }
    return self;
}

@end
