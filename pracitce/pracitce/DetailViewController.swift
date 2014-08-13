//
//  DetailViewController.swift
//  pracitce
//
//  Created by Parker Lewis on 8/13/14.
//  Copyright (c) 2014 Parker Lewis. All rights reserved.
//

import Foundation
import UIKit


class DetailViewController: UIViewController {

    
    @IBOutlet weak var firstLabel: UILabel!
    @IBOutlet weak var imagePlace: UIImageView!    
    var namePassed : String!
    var imagePassed : UIImage!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        firstLabel.text = namePassed
        imagePlace.image = imagePassed
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
}
