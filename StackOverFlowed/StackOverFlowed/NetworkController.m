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



- (void) fetchJSONDataFrom:(NSString *)urlString withCompletion:(void (^)(NSString *, NSData *))success {

    NSURL *requestURL = [NSURL URLWithString:urlString];
    
    NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession] dataTaskWithURL:requestURL completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if ([response isKindOfClass: [NSHTTPURLResponse class]]) {
            NSHTTPURLResponse * httpResponse = (NSHTTPURLResponse *) response;
            NSLog(@"status code is %ld",(long)[httpResponse statusCode]);
            if ([httpResponse statusCode] >= 200 && [httpResponse statusCode] <= 204 ) {
                [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                    success(nil, data);
                }];
            } else {
                [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                    NSLog(@"%@",error.localizedDescription);
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
