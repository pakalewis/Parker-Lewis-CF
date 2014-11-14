//
//  StackOverFlowedTests.m
//  StackOverFlowedTests
//
//  Created by Parker Lewis on 11/10/14.
//  Copyright (c) 2014 CodeFellows. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "Question.h"

@interface StackOverFlowedTests : XCTestCase

@end

@implementation StackOverFlowedTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}



- (void)testJSONParsing {
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    NSString *path = [bundle pathForResource:@"sample" ofType:@"json"];
    NSData *json = [NSData dataWithContentsOfFile:path];
    XCTAssertNotNil(json);
    
    NSMutableArray *array = [[Question alloc] parseJSONIntoQuestionArrayFrom:json];
    XCTAssertEqual(array.count, 10);
}


@end
