//
//  NetworkController.m
//  StackOverFlowed
//
//  Created by Parker Lewis on 11/11/14.
//  Copyright (c) 2014 CodeFellows. All rights reserved.
//

#import "NetworkController.h"
#import "Question.h"


@interface NetworkController()

@property NSOperationQueue *imageQueue;

@end


@implementation NetworkController


// Makes a singleton
+ (id)networkController {
    static NetworkController *networkController = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        networkController = [[self alloc] init];
    });
    
    return networkController;
}



- (void) fetchQuestionsForTag:(NSString *)tag withCompletion:(void (^)(NSString *, NSMutableArray *))success {
    NSString *requestURLString;

    if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"token"] isKindOfClass:[NSString class]]) {
        // authenticated
        NSString *token = [[NSUserDefaults standardUserDefaults] valueForKey:@"token"];
        requestURLString = [NSString stringWithFormat: @"https://api.stackexchange.com/2.2/search?order=desc&sort=activity&tagged=%@&site=stackoverflow&access_token=%@&key=stuvaUJEX6kTlkHrvBNZVA((", tag, token];
    } else {
        // not authenticated = no token
        requestURLString = [NSString stringWithFormat: @"https://api.stackexchange.com/2.2/search?order=desc&sort=activity&tagged=%@&site=stackoverflow", tag];
    }


    NSLog(@"Request URL: %@", requestURLString);
    NSURL *requestURL = [NSURL URLWithString:requestURLString];
    
    NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession] dataTaskWithURL:requestURL completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if ([response isKindOfClass: [NSHTTPURLResponse class]]) {
            NSHTTPURLResponse * httpResponse = (NSHTTPURLResponse *) response;
            if ([httpResponse statusCode] >= 200 && [httpResponse statusCode] <= 204 ) {
                NSLog(@"fetching questions");

                // Make array to store the fetched questions
                NSMutableArray *questions = [[Question alloc] parseJSONIntoQuestionArrayFrom:data];
                [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                    success(nil, questions);
                }];
            } else {
                [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                    success(error.localizedDescription, nil);
                }];
            }
        }
    }];
    [dataTask resume];
}


- (void) fetchProfileImageForUser: (NSString *)profileImageURL withCompletion:(void (^)(UIImage *)) completionHandler; {
    
    self.imageQueue = [[NSOperationQueue alloc] init];
    [self.imageQueue addOperationWithBlock:^{
        NSURL *url = [NSURL URLWithString: profileImageURL];
        NSData *data = [NSData dataWithContentsOfURL:url];
        UIImage *profileImageToReturn = [UIImage imageWithData:data];
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            completionHandler(profileImageToReturn);
        }];
    }];    
}

@end
