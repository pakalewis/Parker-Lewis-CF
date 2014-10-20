//
//  NetworkController.swift
//  GithubbaHubba
//
//  Created by Parker Lewis on 10/20/14.
//  Copyright (c) 2014 Parker Lewis. All rights reserved.
//

import Foundation

class NetworkController {
    
    func getDataAndReturnJSON(url : NSURL, completionHandler: (errorDescription : String?, repos : [Repo]?) -> (Void)) {
        
        // setup data task for resource at URL
        // makes a GET requests, by default
        let session = NSURLSession.sharedSession()

        let dataTask = session.dataTaskWithURL(url, completionHandler: { (JSONdata, response, error) -> Void in
            
            if error != nil {
                println(error.localizedDescription)
            } else {
                println("no error")
            }
            
            
            if let httpResponse = response as? NSHTTPURLResponse {
                println("http response code: \(httpResponse.statusCode)")
                switch httpResponse.statusCode {
                case 200...204:
//                    for header in httpResponse.allHeaderFields {
//                        println("header: \(header)")
//                    }
//                    let responseString = NSString(data: JSONdata, encoding: NSUTF8StringEncoding)
//                    println("responseString: \(responseString)")
                    
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