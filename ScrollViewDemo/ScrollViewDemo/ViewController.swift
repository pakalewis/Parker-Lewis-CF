//
//  ViewController.swift
//  ScrollViewDemo
//
//  Created by Bradley Johnson on 10/23/14.
//  Copyright (c) 2014 Code Fellows. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet var scrollView: UIScrollView!
    var redBox: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.scrollView.delegate = self
        self.scrollView.backgroundColor = UIColor.lightGrayColor()
        
        self.redBox = UIView(frame: CGRect(x: -50.0, y: 1800.0, width: 100.0, height: 100.0))
        
        self.redBox.backgroundColor = UIColor.redColor()
        
        self.scrollView.addSubview(redBox)
        
        self.scrollView.contentSize = CGSize(width: self.scrollView.contentSize.width, height: 2000)
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func scrollViewDidScroll(scrollView: UIScrollView) {
        println("bounds: \(scrollView.bounds)")
        println("content offset: \(scrollView.contentOffset)")
    }
}

