//
//  ViewController.swift
//  Localization
//
//  Created by Parker Lewis on 2/13/15.
//  Copyright (c) 2015 CodeFellows. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var secondLabel: UILabel!

    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        self.secondLabel.text = NSLocalizedString("TEST_STRING", comment: "comment line")
        
        
        
        let newLabel = UILabel(frame: CGRectMake(20, 400, 200, 30))
        newLabel.backgroundColor = UIColor.greenColor()
        newLabel.text = NSLocalizedString("TEST_STRING", comment: "comment line")
        self.view.addSubview(newLabel)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

