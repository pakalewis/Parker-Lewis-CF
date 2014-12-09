//
//  ImageViewController.swift
//  Pinchot
//
//  Created by Andrew Shepard on 10/21/14.
//  Copyright (c) 2014 Andrew Shepard. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController {
    
    // Save final location of animation    
    var reverseOrigin: CGRect?
    var image: UIImage?
    
    @IBOutlet var imageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Single Image"

        // Do any additional setup after loading the view.
        
        self.imageView.image = self.image
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
