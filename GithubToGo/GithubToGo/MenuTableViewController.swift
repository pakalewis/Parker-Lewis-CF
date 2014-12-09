//
//  MenuTableViewController.swift
//  GithubToGo
//
//  Created by Bradley Johnson on 10/23/14.
//  Copyright (c) 2014 Code Fellows. All rights reserved.
//

import UIKit

class MenuTableViewController: UITableViewController,UISearchBarDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.searchBar.delegate = self

    }
    
    func searchBar(searchBar: UISearchBar,
        shouldChangeTextInRange range: NSRange,
        replacementText text: String) -> Bool {
            println(text)
            
            return text.validate()
    }
    
//    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
//        println("clicked")
//    }
//    
   
}
