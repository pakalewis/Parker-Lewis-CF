//
//  WebVC.h
//  StackOverFlowed
//
//  Created by Parker Lewis on 11/11/14.
//  Copyright (c) 2014 CodeFellows. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
#import "Question.h"

@interface WebVC : UIViewController <WKNavigationDelegate>

@property (nonatomic, strong) WKWebView *webView;

@property (nonatomic, strong) NSString *questionURL;
@property (nonatomic, strong) NSString *profileURL;


@end
