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
    self.webView.navigationDelegate = self;
    [self.view addSubview:self.webView];

    
    self.oAuthURL = @"https://stackexchange.com/oauth/dialog";
    self.clientID = @"3829";
    self.oAuthDomain = @"https://stackexchange.com/oauth/login_success";

    

    NSString *loginURLString = [[NSString alloc] init];
    if (self.questionURL) {
        NSLog(@"there is a question url");
        loginURLString = self.questionURL;
    } else if (self.profileURL) {
        NSLog(@"there is a profile url");
        loginURLString = self.profileURL;
    } else {
        NSLog(@"requesting Oauth");
        loginURLString = [NSString stringWithFormat:@"%@?client_id=%@&redirect_uri=%@&scope=read_inbox", self.oAuthURL, self.clientID, self.oAuthDomain];
    }
    
    
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:loginURLString]];
    [self.webView loadRequest:urlRequest];
}



- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {

    NSURLRequest *request = navigationAction.request;
    NSURL *url = request.URL;
    NSString *urlString = [url absoluteString];

    if ([urlString containsString:@"access_token"]) {
        NSArray *urlComponents = [url.description componentsSeparatedByString:@"="];
        NSString *tokenToStore = urlComponents[1];
        urlComponents = [tokenToStore componentsSeparatedByString:@"&"];
        tokenToStore = urlComponents[0];
        

        [[NSUserDefaults standardUserDefaults] setValue:tokenToStore forKey:@"token"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Congrats!" message:@"You are authorized!" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
             [self.navigationController popViewControllerAnimated:true];
        }];
        [alert addAction:okAction];
        [self presentViewController:alert animated:true completion:nil];
    }
    decisionHandler(WKNavigationActionPolicyAllow);
}

@end












