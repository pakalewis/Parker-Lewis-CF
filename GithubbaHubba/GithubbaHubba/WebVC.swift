//
//  WebVC.swift
//  GithubbaHubba
//
//  Created by Parker Lewis on 10/23/14.
//  Copyright (c) 2014 Parker Lewis. All rights reserved.
//

import UIKit
import WebKit

class WebVC: UIViewController, WKNavigationDelegate {

    var webView : WKWebView?
    var initialURLString : String?

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.webView = WKWebView(frame: self.view.bounds)

        if let newWebView = webView {
            let goToURL = NSURL(string: self.initialURLString!)
            let urlRequest = NSURLRequest(URL: goToURL!)
            newWebView.loadRequest(urlRequest)
            newWebView.navigationDelegate = self
            self.view.addSubview(newWebView)
        }
    }
    
    
    func webView(webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        println("loading")
        
        self.view.bringSubviewToFront(self.activityIndicator)
        self.activityIndicator.startAnimating()
        self.activityIndicator.hidesWhenStopped = true
        self.activityIndicator.color = UIColor.blackColor()

    }

    
    
    func webView(webView: WKWebView, didFinishNavigation navigation: WKNavigation!) {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
        println("finished")
        self.activityIndicator.stopAnimating()
    }
}

