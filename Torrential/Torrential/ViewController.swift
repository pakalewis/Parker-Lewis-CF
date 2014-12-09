//
//  ViewController.swift
//  Torrential
//
//  Created by Andrew Shepard on 10/23/14.
//  Copyright (c) 2014 Andrew Shepard. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate {
    
    @IBOutlet var tableView: UITableView!
    var headerView: UIView!
    
    private var names = ["Adams", "Baker", "Si", "Rattlesnake", "Mailbox", "Cougar", "St. Helens", "Glacier", "Jupiter", "The Brothers", "Constance", "Hood", "Cadillac", "Rainer", "Adams", "Baker", "Si", "Rattlesnake", "Mailbox", "Cougar", "St. Helens", "Glacier", "Jupiter", "The Brothers", "Constance", "Rainer", "Adams", "Baker", "Si", "Rattlesnake", "Mailbox", "Cougar", "St. Helens", "Glacier", "Jupiter", "The Brothers", "Constance", "Hood", "Cadillac"]
    private let identifier = "MyCell"
    private let tableHeaderHeight: CGFloat = 200.0

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: identifier)
        
        self.headerView = tableView.tableHeaderView
        self.tableView.tableHeaderView = nil
        
        self.tableView.addSubview(headerView)
        
        self.tableView.contentInset = UIEdgeInsets(top: tableHeaderHeight, left: 0, bottom: 0, right: 0)
        self.tableView.contentOffset = CGPointMake(0, -tableHeaderHeight)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        updateHeaderViewPosition()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    // MARK: - UITableViewDataSource

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.names.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let name = self.names[indexPath.row]
        let cell = tableView.dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath) as UITableViewCell
        
        cell.textLabel.text = name
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    // MARK: - UIScrollViewDelegate
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        updateHeaderViewPosition()
    }
    
    // MARK: - Private
    
    func updateHeaderViewPosition() {
        var frame = CGRectMake(0, -tableHeaderHeight, self.tableView.bounds.width, tableHeaderHeight)
        
        if self.tableView.contentOffset.y < -tableHeaderHeight {
            frame.origin.y = tableView.contentOffset.y
            frame.size.height = -tableView.contentOffset.y
        }
        
        self.headerView.frame = frame
    }
}

