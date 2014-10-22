//
//  NetworkController.swift
//  GithubbaHubba
//
//  Created by Parker Lewis on 10/20/14.
//  Copyright (c) 2014 Parker Lewis. All rights reserved.
//

import UIKit
import Foundation

class NetworkController {
    
    
//    class var sharedInstance: NetworkController {
//    struct Static {
//        static var instance: NetworkController?
//        static var token: dispatch_once_t = 0
//        }
//        dispatch_once(&Static.token) {
//            Static.instance = NetworkController()
//        }
//        return Static.instance!
//    }
    
    
    var authenticatedSession : NSURLSession?
    var authenticated : Bool = false
    var OAuthToken : String?
    
    //MARK: NetworkController properties
    // these two were created after 'registering' this app with my github account
    let clientID = "client_id=4232abfcfa7cb78ef009"
    let clientSecret = "client_secret=39dfc48aab852e83a2444bd68770863819f5f38f"
    
    // Part of the URL that redirects users in the app to go request the OAuth from GitHub. GET request from the API documentation
    let githubOAuthURL = "https://github.com/login/oauth/authorize?"
    
    // parameters added to above URL. defines which parts of the API this app wants access to. user will accept or decline
    let scope = "scope=user,repo"
    
    // The URL in your app where users will be sent after authorization.
    let redirectURL = "redirect_uri=goToGithubbaHubbaApp://github.com"
    
    // defines URL to actually ask for the OAuth token
    let githubPOSTURL = "https://github.com/login/oauth/access_token"


    init() {
        
    }
    
    // this gets called from any of RepoVC, UserVC, or ProfileVC if there is no Oauth token yet
    func makeAlertBeforeSafariOpens() -> UIAlertController {
        var alert = UIAlertController(title: "Alert", message: "Safari will now open so that you can log in to GitHub.com", preferredStyle: UIAlertControllerStyle.Alert)
        let OKAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default) { (action) -> Void in
            self.requestOAuthAccess()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil)
        alert.addAction(OKAction)
        alert.addAction(cancelAction)
        
        return alert
    }
    
    //MARK: OAuth stuff
    func requestOAuthAccess() {
        println("requestOAuthAccess fired")
        
        // construct the URL for requesting
        let urlString = githubOAuthURL + clientID + "&" + redirectURL + "&" + scope
        let url = NSURL(string: urlString)
        println("url to request OAuth Access: \(url!)")
        
        
        // talks to the app as a whole. calls the openURL func in the AppDelegate
        UIApplication.sharedApplication().openURL(url!)
    }
    
    
    
    func handleOAuthURL(callbackURL : NSURL) {
        println("handleOAuthURL fired")
        // parse through the url that given to us by Github. need to get the code

        // this grabs the part of the URL after the ?: "code=a5d8cc5eaf68c1b9a06e"
        let query = callbackURL.query
        
        // this makes an array of strings: ["", "a5d8cc5eaf68c1b9a06e"]
        let components = query?.componentsSeparatedByString("code=")

        // this grabs the last item in that array, which is the code we need
        let code = components?.last
        println("code: \(code!)")

        // construct the query url for the final POST call which will eventually return the token
        let urlQuery = clientID + "&" + clientSecret + "&" + "code=\(code!)"
        println("urlQuery: \(urlQuery)")
        
        // create request and perform setup
        let POSTURL = NSURL(string: githubPOSTURL)
        var request = NSMutableURLRequest(URL: POSTURL!)
        request.HTTPMethod = "POST"
        var postData = urlQuery.dataUsingEncoding(NSASCIIStringEncoding, allowLossyConversion: true)
        let length = postData!.length
        request.setValue("\(length)", forHTTPHeaderField: "Content-Length")
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.HTTPBody = postData

        let dataRequest = NSURLSession.sharedSession().dataTaskWithRequest(request, completionHandler: { (data, response, error) -> Void in
            
            if error != nil {
                // there is an error
                println(error.localizedDescription)
            } else {
                if let httpResponse = response as? NSHTTPURLResponse {
                    switch httpResponse.statusCode {
                    case 200...204:
                        var tokenResponse = NSString(data: data, encoding: NSASCIIStringEncoding)
                        println("token response \(tokenResponse!)")
                        
                        // parse the tokenResponse and get the actual token
                        let tokenResponseDissected = tokenResponse?.componentsSeparatedByString("&")
                        let firstHalfOfTokenString = tokenResponseDissected?.first as NSString
                        let furtherDissection = firstHalfOfTokenString.componentsSeparatedByString("=")
                        let actualToken = furtherDissection.last as String
                        self.OAuthToken = actualToken
                        println("actualToken: \(actualToken)")

                        // now save the token in NSUserDefaults
                        let userDefaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
                        if (userDefaults.stringForKey("OauthToken") == nil) {
                            println("need to save the token")
                            userDefaults.setObject(actualToken, forKey: "OauthToken")
                        } else {
                            var tempToken = userDefaults.objectForKey("OauthToken") as String
                            println("token already saved: \(tempToken)")
                        }
                        self.setupAuthenticatedSession()
                        
                        
                    default:
                        println("default case on status code: \(httpResponse.statusCode)")
                    }
                }

            }
        })
        dataRequest.resume()
    }
    
    
    func setupAuthenticatedSession() {
        println("setupAuthenticatedSession() fired")
        // grab the token and save it in the self.OAuthToken property
        let userDefaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
        self.OAuthToken = userDefaults.objectForKey("OauthToken") as? String
        
        // set up configuration with the token. this config will be passed to the NSURLSession
        var configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
        configuration.HTTPAdditionalHeaders = ["Authorization" : "token \(self.OAuthToken!)"]
        self.authenticatedSession = NSURLSession(configuration: configuration)
//        println(self.authenticatedSession?.configuration.HTTPAdditionalHeaders)

        self.authenticated = true
        println("authenticated?: \(self.authenticated)")
    }
    
    
    
    //MARK: JSON stuff
    func getDataAndReturnJSON(url : NSURL, completionHandler: (errorDescription : String?, repos : [Repo]?) -> (Void)) {
        
        println("getDataAndReturnJSON fired")
        // setup data task for resource at URL
        // makes a GET requests, by default
        println(self.authenticatedSession?.configuration.HTTPAdditionalHeaders)

        let dataTask = self.authenticatedSession!.dataTaskWithURL(url, completionHandler: { (JSONdata, response, error) -> Void in
            
            if error != nil {
                println(error.localizedDescription)
            } else {
                println("no error")
            }
            
            
            if let httpResponse = response as? NSHTTPURLResponse {
//                println("http response code: \(httpResponse.statusCode)")
//                for header in httpResponse.allHeaderFields {
//                    println("header: \(header)")
//                }
//                let responseString = NSString(data: JSONdata, encoding: NSUTF8StringEncoding)
//                println("responseString: \(responseString)")

                
                switch httpResponse.statusCode {
                case 200...204:
                    
                    let repos = self.parseJSONDataIntoArrayOfRepos(JSONdata)
                    println("resulting array of repos: \(repos?.count)")
                    NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                        completionHandler(errorDescription: nil, repos: repos)
                    })
                default:
                    println("bad response? \(httpResponse.statusCode)")
                }
            }
        })
        dataTask.resume()
    }
    
    
    func parseJSONDataIntoArrayOfRepos(rawJSONData : NSData ) -> [Repo]? {
        var error : NSError?
       
        if let completeJSONDict = NSJSONSerialization.JSONObjectWithData(rawJSONData, options: nil, error: &error) as? NSDictionary {
            println("json serialized")
            var repoArrayToReturn = [Repo]()

            if let itemsInJSONArray = completeJSONDict["items"] as? NSArray {
                println("count of items \(itemsInJSONArray.count)")
                for itemDict in itemsInJSONArray {
                    var repoName = itemDict["name"] as String
                    var repoURL = itemDict["html_url"] as String
                    var newRepo = Repo(name: repoName, url: repoURL)
                    repoArrayToReturn.append(newRepo)
                }
            }
            return repoArrayToReturn
        }
        return nil
    }

    
}