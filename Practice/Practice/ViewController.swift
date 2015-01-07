//
//  ViewController.swift
//  Practice
//
//  Created by Parker Lewis on 12/23/14.
//  Copyright (c) 2014 CodeFellows. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    

    @IBOutlet weak var pickerview: CustomPicker!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func viewDidAppear(animated: Bool) {
        
        
    }
    
    override func viewDidLayoutSubviews() {
        self.pickerview.initialize()

        
        
    }
}

