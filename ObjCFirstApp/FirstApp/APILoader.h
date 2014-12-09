//
//  APILoader.h
//  FirstApp
//
//  Created by Andrew Shepard on 11/10/14.
//  Copyright (c) 2014 Andrew Shepard. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface APILoader : NSObject

- (void)loadData:(void (^)(NSArray *, NSError *))success;

@end
