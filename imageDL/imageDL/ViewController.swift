//
//  ViewController.swift
//  imageDL
//
//  Created by Parker Lewis on 8/25/14.
//  Copyright (c) 2014 Parker Lewis. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var actInd: UIActivityIndicatorView!
    var imageDownloadQueue = NSOperationQueue()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // this sets the priority of the queue
        // UserInitiated is pretty high but not higher priority than the mainQueue
        self.imageDownloadQueue.qualityOfService = NSQualityOfService.UserInitiated
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        //set up URL
        var myURL = NSURL(string: "http://s2.reutersmedia.net/resources/r/?m=02&d=20140429&t=2&i=892620990&w=580&fh=&fw=&ll=&pl=&r=LYNXMPEA3S024")
        
        self.actInd.startAnimating()
        sleep(5)
        
        // there is always a mainQueue that should basically be empty
        // here we create a second queue to do some work in the background
        // this puts the image DL on the second queue and then once the DL is done, you add a task to the mainQueue to set the imageView with the image we DLed
        imageDownloadQueue.addOperationWithBlock { () -> Void in
            // create data from url
            var myData = NSData(contentsOfURL: myURL!)
            // take data and turn into image
            var myImage = UIImage(data: myData!)
            NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                self.imageView.image = myImage
                self.actInd.stopAnimating()
            })
        }

    }
}

