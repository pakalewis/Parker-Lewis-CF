//
//  WebVC.swift
//  GithubbaHubba
//
//  Created by Parker Lewis on 10/23/14.
//  Copyright (c) 2014 Parker Lewis. All rights reserved.
//

import UIKit
import WebKit

class WebVC: UIViewController {

    let webView = WKWebView()
    
    var currentRepo : Repo?
    
    override func loadView() {
        
//        let webViewConfig = WKWebViewConfiguration()
//        self.webView = WKWebView(frame: self.view.frame, configuration: <#WKWebViewConfiguration#>)
        self.webView.allowsBackForwardNavigationGestures = true
        self.view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //make the correct URL
        let repoURLString = self.currentRepo?.url
        let repoURL = NSURL(string: repoURLString!)
        
        self.webView.loadRequest(NSURLRequest(URL: repoURL!))

    }

    
    
}
