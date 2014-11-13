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
        self.title = questionItemDict[@"title"];
        self.link = questionItemDict[@"link"];
        self.question_id = questionItemDict[@"question_id"];
        self.score = [questionItemDict[@"score"] integerValue];
        self.answer_count = [questionItemDict[@"answer_count"] integerValue];
        self.view_count = [questionItemDict[@"view_count"] integerValue];
        self.creation_date = [questionItemDict[@"creation_date"] integerValue];
        // putting the 'intergerValue' keywords turns the wrapped NSNumber object into a primitive type
        
        self.ownerDict = (NSDictionary *) questionItemDict[@"owner"];
        self.profileImageURL = (NSString *) self.ownerDict[@"profile_image"];
        self.username = (NSString *) self.ownerDict[@"display_name"];
    }
    return self;
}

- (NSMutableArray *) parseJSONIntoQuestionArrayFrom:(NSData *) data {
    NSError * error = nil;
    NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
    
    // pull out items Array from the JSON
    NSMutableArray *items = jsonDict[@"items"];

    NSMutableArray *questions = [[NSMutableArray alloc] init];
    for (NSDictionary *item in items) {
        Question *newQuestion = [[Question alloc] initWith: item];
        [questions addObject: newQuestion];
    }
    return questions;
}


@end