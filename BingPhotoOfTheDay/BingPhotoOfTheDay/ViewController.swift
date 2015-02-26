//
//  ViewController.swift
//  BingPhotoOfTheDay
//
//  Created by Parker Lewis on 2/24/15.
//  Copyright (c) 2015 CodeFellows. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let imageQueue = NSOperationQueue()

    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }


    @IBAction func buttonPressed(sender: AnyObject) {

        self.fetchJSONData { (errorDescription, rawJSONData) -> (Void) in
            
            if errorDescription != nil {
                println("there was an error getting the JSON")
            } else {
                println("getting json for User")
                
                self.parseJSONandCreateImage(rawJSONData!)
                
            }
        }
    }
    
    
    func fetchJSONData(completionHandler: (errorDescription : String?, rawJSONData : NSData?) -> (Void)) {
    
        let urlPath: String = "http://www.bing.com/HPImageArchive.aspx?format=js&idx=0&n=1&mkt=en-US"
        let url: NSURL = NSURL(string: urlPath)!
        let downloadTask = NSURLSession.sharedSession().dataTaskWithURL(url, completionHandler: { (JSONData, response, error) -> Void in
            
            if error != nil {
                println("there was an error: \(error.localizedDescription)")
            } else {
                println("no error")
            }
            
            if let httpResponse = response as? NSHTTPURLResponse {
                switch httpResponse.statusCode {
                case 200...204:
                    println("httpResponse is good")
                    NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                        completionHandler(errorDescription: nil, rawJSONData: JSONData)
                    })
                default:
                    println("bad response? \(httpResponse.statusCode)")
                }
            }
        })
        downloadTask.resume()
    }

    
    
    
    
    func parseJSONandCreateImage(rawJSONData : NSData ) {
        var error : NSError?
        
        if let completeJSONDict = NSJSONSerialization.JSONObjectWithData(rawJSONData, options: nil, error: &error) as? NSDictionary {
            
            
            if let imagesArray = completeJSONDict.objectForKey("images") as? NSMutableArray {
                if let insideDict = imagesArray.firstObject as? NSDictionary {
                    if let urlString = insideDict["url"] as? NSString {
                        let fullUrl = "www.bing.com" + urlString
                        println(fullUrl)
                        self.downloadImageFromUrl(fullUrl, completionHandler: { (image) -> Void in
                            self.imageView.image = image
                        })
                    }
                    
                }
                
            }
        }
    }
    

    
    
    func downloadImageFromUrl(imageURLString : String, completionHandler: (image: UIImage) -> Void) {
        self.imageQueue.addOperationWithBlock { () -> Void in
            
            let imageURL = NSURL(string: imageURLString)
            let imageData = NSData(contentsOfURL: imageURL!)
            let image = UIImage(data: imageData!)
            
            // return to main queue and send back the image
            NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                completionHandler(image: image!)
            })
        }
    }


}


