//
//  Question.h
//  StackOverFlowed
//
//  Created by Parker Lewis on 11/11/14.
//  Copyright (c) 2014 CodeFellows. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Question : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic) NSString *link;
@property (nonatomic) NSString *question_id;
@property (nonatomic) NSInteger score;
@property (nonatomic) NSInteger answer_count;
@property (nonatomic) NSInteger view_count;
@property (nonatomic) NSTimeInterval creation_date;
//@property (nonatomic) BOOL *is_answered;

- (instancetype) initWith: (NSDictionary *) rawJSONDATA;
- (NSMutableArray *) parseJSONIntoQuestionArrayFrom:(NSData *) data;


@end
