//
//  User.h
//  StackOverFlowed
//
//  Created by Parker Lewis on 11/13/14.
//  Copyright (c) 2014 CodeFellows. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

@property (nonatomic, strong) NSString *displayName;
@property (nonatomic, strong) NSString *profileImageURL;
@property (nonatomic, strong) NSString *link;
@property (nonatomic, assign) NSString *aboutMe;
@property (nonatomic, assign) NSInteger questionCount;
@property (nonatomic, assign) NSInteger answerCount;
@property (nonatomic, assign) NSInteger upvoteCount;
@property (nonatomic, assign) NSInteger downvoteCount;
@property (nonatomic, assign) NSInteger viewCount;

- (instancetype) initWithQuestionItemDict: (NSDictionary *) questionItemDict;
- (NSMutableArray *) parseJSONIntoUserArrayFrom: (NSData *) data;

@end
