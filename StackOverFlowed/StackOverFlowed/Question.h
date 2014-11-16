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
@property (nonatomic, strong) NSString *link;
@property (nonatomic, assign) NSString *question_id;
@property (nonatomic, assign) NSInteger score;
@property (nonatomic, assign) NSInteger answer_count;
@property (nonatomic, assign) NSInteger view_count;
@property (nonatomic, assign) NSTimeInterval creation_date;

@property (nonatomic, strong) NSDictionary *ownerDict;
@property (nonatomic, strong) NSString *profileImageURL;
@property (nonatomic, strong) NSString *username;

- (instancetype) initWithQuestionItemDict: (NSDictionary *) questionItemDict;
- (NSMutableArray *) parseJSONIntoQuestionArrayFrom:(NSData *) data;


@end
