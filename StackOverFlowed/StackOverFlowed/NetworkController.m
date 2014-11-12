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
    NSString *requestURLString = [NSString stringWithFormat: @"https://api.stackexchange.com/2.2/search?order=desc&sort=activity&tagged=%@&site=stackoverflow", tag];

    NSLog(@"Request URL: %@", requestURLString);
    NSURL *requestURL = [NSURL URLWithString:requestURLString];
    
    NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession] dataTaskWithURL:requestURL completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if ([response isKindOfClass: [NSHTTPURLResponse class]]) {
            NSHTTPURLResponse * httpResponse = (NSHTTPURLResponse *) response;
            if ([httpResponse statusCode] >= 200 && [httpResponse statusCode] <= 204 ) {
                NSLog(@"fetching questions");
                NSError * error = nil;
                NSDictionary *rawData = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];

                // pull out items Array from the JSON
                NSArray *items = rawData[@"items"];

                // Make array to store the fetched questions
                NSMutableArray *questions = [[NSMutableArray alloc] init];
                for (NSDictionary *item in items) {
                    Question *newQuestion = [[Question alloc] initWith: item];
                    [questions addObject: newQuestion];
                }
                [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                    success(nil, questions);
                }];
            }
        }
    }];
    [dataTask resume];
}


@end
