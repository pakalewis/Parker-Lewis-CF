//
//  UserCollectionVC.swift
//  GithubbaHubba
//
//  Created by Parker Lewis on 10/20/14.
//  Copyright (c) 2014 Parker Lewis. All rights reserved.
//

import UIKit

class UserCollectionVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UISearchBarDelegate {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var instructionsLabel: UILabel!
    
    var networkController : NetworkController!
    var userArray = [User]()
    var currentUser = User()
    var defaultImage = UIImage(named: "default")

    var initialCellFrame: CGRect?
    var initialImageFrame: CGRect?
    
    var returnedFromSingleUserView = false
    
    override func viewWillAppear(animated: Bool) {
        if self.returnedFromSingleUserView {
            self.collectionView.hidden = false
        } else {
            self.collectionView.hidden = true
        }
        self.instructionsLabel.text = "Use the search bar to search GitHub Users"
        self.view.addSubview(self.instructionsLabel)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        // grab reference to singular NetworkController from AppDelegate
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        self.networkController = appDelegate.globalNetworkController
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        if !self.networkController.authenticated {
            // check to see if OAuth token is saved in NSUserDefaults
            let userDefaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
            if let tokenCheck = userDefaults.objectForKey("OauthToken") as? String {
                // token already stored
                println("Authorized token already saved: \(tokenCheck)")
                
                self.networkController.setupAuthenticatedSession()
            } else {
                // no token so fire the NetworkController that requests authorization
                
                // make alert controller
                var alert = self.networkController.makeAlertBeforeSafariOpens()
                self.presentViewController(alert, animated: true, completion: nil)
            }
        } else {
            println("ALREADY AUTHENTICATED")
        }
        
    }


    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.userArray.count
    }
    
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("USER_CELL", forIndexPath: indexPath) as UserCell

        
        self.currentUser = self.userArray[indexPath.row] as User
        self.currentUser.avatarImage = self.defaultImage
        
        cell.userName.text = self.currentUser.userName
        cell.userAvatarImageView.image = self.defaultImage
        
        
        var currentCellTag = cell.tag + 1
        cell.tag = currentCellTag
        
        
        
        // if the avatar has already been downloaded, show it in the cell's image
//        if currentUser.avatarImage != nil {
//            if currentCellTag == cell.tag {
//                cell.userAvatarImageView.image = self.currentUser.avatarImage
//            }
//        } else {
//            // avatar image is not available yet
//            // download avatar, provided the cell is still visible
//            self.networkController.downloadImage(self.currentUser.avatarURL!, completionHandler: { (image) -> Void in
//                if currentCellTag == cell.tag {
//                    // store image in User object
//                    self.currentUser.avatarImage = image
//                    cell.userAvatarImageView.image = image
//                }
//            })
//        }
        return cell
    }
    
    
    
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        // Grab the attributes of the tapped upon cell
        let attributes = collectionView.layoutAttributesForItemAtIndexPath(indexPath)
        
        // Grab the onscreen rectangle of the tapped upon cell, relative to the collection view
        self.initialCellFrame = self.view.convertRect(attributes!.frame, fromView: collectionView)

        
        // HOW DO I GRAB THE FRAME OF THE IMAGE ON THE CELL I SELECTED???
        // I WANT TO SET THE initialCellFrame to be that frame rather than the whole cell's frame
        let cell = collectionView.cellForItemAtIndexPath(indexPath) as UserCell
        self.initialImageFrame = cell.userAvatarImageView.frame

        
        // initialize next view controller
        var destinationVC = storyboard?.instantiateViewControllerWithIdentifier("SINGLE_USER_VC") as SingleUserVC

        // Set currentUser and reverseOrigin properties on next view controller
        self.currentUser = self.userArray[indexPath.row]
        destinationVC.currentUser = self.currentUser
        destinationVC.frameToReturnImageTo = self.initialImageFrame
        
        // ensure that the collectionview is not hidden
        self.returnedFromSingleUserView = true
        
        self.navigationController?.pushViewController(destinationVC, animated: true)
    }
    
    
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        let searchText = searchBar.text
        println("user wants to search for: \(searchText)")
        
        searchBar.resignFirstResponder()
        
        if self.networkController.authenticated {
            // returns true if authenticated so do the network call
            // this is the base github url for searching users
            var urlSearchString = "https://api.github.com/search/users?per_page=90&"
            // modify it with the search term(s) from the search bar
            urlSearchString = urlSearchString + "q=\(searchText)"
            println("urlSearchString: \(urlSearchString)")
            let url = NSURL(string: urlSearchString)
            
            self.networkController.fetchJSONData(url!, completionHandler: { (errorDescription, rawJSONData) -> (Void) in
                
                if errorDescription != nil {
                    println("there was an error getting the JSON")
                } else {
                    println("getting json for User")
                    self.userArray = self.networkController.parseJSONDataForUsers(rawJSONData!)!
                    self.collectionView.reloadData()
                    self.collectionView.hidden = false
                    self.instructionsLabel.hidden = true
                }
            })
            
        } else {
            println("not authenticated. present alert")
            var alert = UIAlertController(title: "Session is not authenticated", message: "Tap OK to authenticate", preferredStyle: UIAlertControllerStyle.Alert)
            let OKAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default) { (action) -> Void in
                var alert = self.networkController.makeAlertBeforeSafariOpens()
                self.presentViewController(alert, animated: true, completion: nil)
            }
            let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil)
            alert.addAction(OKAction)
            alert.addAction(cancelAction)
            self.presentViewController(alert, animated: true, completion: nil)
        }
        
    }
    
    func searchBar(searchBar: UISearchBar, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        return text.validateStringWithoutSpecialCharacters()
    }
    
    
}
