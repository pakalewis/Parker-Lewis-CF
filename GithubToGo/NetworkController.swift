//
//  NetworkController.swift
//  GithubToGo
//
//  Created by Bradley Johnson on 10/21/14.
//  Copyright (c) 2014 Code Fellows. All rights reserved.
//

import UIKit



class NetworkController {
    
    let clientID = "client_id=b7d8f960252fe915b1d0"
    let clientSecret = "client_secret=8df0d49e6f4f5ea932cda29fee87f415d597da59"
    let githubOAuthURL = "https://github.com/login/oauth/authorize?"
    let scope = "scope=user,repo"
    let redirectURL = "redirect_uri=somefancyname://test"
    let githubPOSTURL = "https://github.com/login/oauth/access_token"
    
    //this is step 1 of the Oauth workflow, this is going to take the user out of our app and send them to github
    func requestOAuthAccess() {
        let url = githubOAuthURL + clientID + "&" + redirectURL + "&" + scope
        UIApplication.sharedApplication().openURL(NSURL(string: url)!)
    }
    
    func handleOAuthURL(callbackURL : NSURL) {
        //parse through the url that given to us by Github
        let query = callbackURL.query
        let components = query?.componentsSeparatedByString("code=")
        let code = components?.last
        println(code)
        //constructing the query string for the final POST call
        let urlQuery = clientID + "&" + clientSecret + "&" + "code=\(code!)"
        var request = NSMutableURLRequest(URL: NSURL(string: githubPOSTURL)!)
        request.HTTPMethod = "POST"
        var postData = urlQuery.dataUsingEncoding(NSASCIIStringEncoding, allowLossyConversion: true)
        let length = postData!.length
        request.setValue("\(length)", forHTTPHeaderField: "Content-Length")
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.HTTPBody = postData
        
        let dataTask = NSURLSession.sharedSession().dataTaskWithRequest(request, completionHandler: { (data, response, error) -> Void in
            
            if error != nil {
                println("Hello this is an error")
            } else {
                if let httpResponse = response as? NSHTTPURLResponse {
                    switch httpResponse.statusCode {
                    case 200...204:
                        var tokenResponse = NSString(data: data, encoding: NSASCIIStringEncoding)
                        println(tokenResponse!)
                        
//                        var configuration = NSURLSessionConfiguration()
//                        configuration.setValue("token OAUTH-TOKEN", forKey: "Authorization")
//                        
//                        var mySession = NSURLSession(configuration: configuration)
                    default:
                        println("default case on status code")
                    }
                }
            }
        }).resume()
    }
}
