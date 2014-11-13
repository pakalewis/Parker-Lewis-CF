//
//  NetworkController.h
//  StackOverFlowed
//
//  Created by Parker Lewis on 11/11/14.
//  Copyright (c) 2014 CodeFellows. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NetworkController : NSObject

+ (id)networkController;

- (void)fetchQuestionsForTag: (NSString *) tag withCompletion: (void (^)(NSString *, NSMutableArray *))success;

- (void) fetchProfileImageForUser: (NSString *)profileImageURL withCompletion:(void (^)(UIImage *)) completionHandler;



@end
