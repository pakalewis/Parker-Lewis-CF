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
    
    var initialURLString : String?
    
    override func loadView() {
        
//        let webViewConfig = WKWebViewConfiguration()
//        self.webView = WKWebView(frame: self.view.frame, configuration: <#WKWebViewConfiguration#>)
        self.webView.allowsBackForwardNavigationGestures = true
        self.view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //make the correct URL
        println("go to this url \(self.initialURLString!)")
        let goToURL = NSURL(string: self.initialURLString!)
        
        self.webView.loadRequest(NSURLRequest(URL: goToURL!))

    }

    
    
}
