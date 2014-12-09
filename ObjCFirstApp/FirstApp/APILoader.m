//
//  APILoader.m
//  FirstApp
//
//  Created by Andrew Shepard on 11/10/14.
//  Copyright (c) 2014 Andrew Shepard. All rights reserved.
//

#import "APILoader.h"

@implementation APILoader

- (void)loadData:(void (^)(NSArray *, NSError *))success {
    // load some expensive data, takes a long time
    NSArray *garbage = @[@"Garbage"];
    
    // some time later, call back
    success(garbage, nil);    
}

@end
