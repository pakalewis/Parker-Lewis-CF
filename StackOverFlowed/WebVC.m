//
//  WebVC.m
//  StackOverFlowed
//
//  Created by Parker Lewis on 11/11/14.
//  Copyright (c) 2014 CodeFellows. All rights reserved.
//

#import "WebVC.h"


@interface WebVC ()

@property (nonatomic, strong) NSString *publicKey;
@property (nonatomic, strong) NSString *oAuthDomain;
@property (nonatomic, strong) NSString *clientID;
@property (nonatomic, strong) NSString *oAuthURL;


@end

@implementation WebVC

- (void)viewDidLoad {
    [super viewDidLoad];

    self.webView = [[WKWebView alloc] init];
    self.webView.frame = self.view.frame;
    [self.view addSubview:self.webView];

    
    self.publicKey = @"stuvaUJEX6kTlkHrvBNZVA((";
    self.oAuthDomain = @"https://stackexchange.com/oauth/login_success";
    self.clientID = @"3829";
    self.oAuthURL = @"https://stackexchange.com/oauth/dialog";

    
    
    NSString *loginURLString = [NSString stringWithFormat:@"%@?client_id=%@&redirect_uri=%@&scope=read_inbox", self.oAuthURL, self.clientID, self.oAuthDomain];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:loginURLString]];
    [self.webView loadRequest:urlRequest];
    
    

    // necessary???
//    self.webView.navigationDelegate = self;
    
    
    // this is for requesting a specific url
    
//    NSString *urlString = self.selectedQuestion.link;
//    NSURL *goToURL = [[NSURL alloc] initWithString:urlString];
//    NSURL *goToURL = [NSURL URLWithString:@"http://www.google.com"];
//    NSURLRequest *urlRequest = [[NSURLRequest alloc] initWithURL: goToURL];
//    [self.webView loadRequest:urlRequest];
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    
    NSURLRequest *request = navigationAction.request;
    NSURL *url = request.URL;
    NSString *urlString = [url absoluteString];
    NSLog(@"%@", urlString);
}

@end
