//
//  UserCollectionVC.swift
//  GithubbaHubba
//
//  Created by Parker Lewis on 10/20/14.
//  Copyright (c) 2014 Parker Lewis. All rights reserved.
//

import UIKit

class UserCollectionVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UISearchBarDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var instructionsLabel: UILabel!
    
    var userArray = [User]()
    var defaultImage = UIImage(named: "default")
    var initialImageFrame : CGRect?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.navigationController?.delegate = self
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.instructionsLabel.text = "Use the search bar to search GitHub Users"
        self.instructionsLabel.backgroundColor = UIColor.lightGrayColor()
        self.view.addSubview(self.instructionsLabel)
    }
    

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        if !NetworkController.controller.authenticated {
            // check to see if OAuth token is saved in NSUserDefaults
            let userDefaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
            if let tokenCheck = userDefaults.objectForKey("OauthToken") as? String {
                // token already stored
                println("Authorized token already saved: \(tokenCheck)")
                
                NetworkController.controller.setupAuthenticatedSession()
            } else {
                // no token so fire the NetworkController that requests authorization
                
                // make alert controller
                var alert = NetworkController.controller.makeAlertBeforeSafariOpens()
                self.presentViewController(alert, animated: true, completion: nil)
            }
        } else {
            println("ALREADY AUTHENTICATED")
        }
        
    }


    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.userArray.count
    }
    
    
    
    // CELL FOR ITEM AT INDEXPATH
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("USER_CELL", forIndexPath: indexPath) as UserCell
        let thisUser = self.userArray[indexPath.row]
        
        cell.activityIndicator.startAnimating()
        cell.activityIndicator.hidesWhenStopped = true
        cell.activityIndicator.color = UIColor.blackColor()
        
        
        // set cell image and text. load default image first before downloading
        cell.userName.text = thisUser.userName
        cell.userAvatarImageView.image = self.defaultImage
        
        
        // tags to check if the cell is still on screen
        var currentTag = cell.tag + 1
        cell.tag = currentTag
        

        // if the avatar has already been downloaded, show it in the cell's image
        // MAKE A CACHE AND CHECK IF THE AVATAR IMAGE WAS ALREADY DOWNLOADED. DO THIS INSTEAD OF CHECKING IF THE USER OBJECT HAS AN IMAGE. REMOVE THE AVATARIMAGE PROPERTY FROM THE USER OBJECT
        if thisUser.avatarImage != nil {
            // THIS WILL CHECK THE CACHE INSTEAD OF THE CURRENT USER OBJECT
            cell.userAvatarImageView.image = thisUser.avatarImage
        } else {
            // avatar image is not available yet
            // download avatar, provided the cell is still visible
            NetworkController.controller.downloadImage(thisUser.avatarURL!, completionHandler: { (image) -> Void in
                // STORE IMAGE IN CACHE

                if cell.tag == currentTag {
                    cell.userAvatarImageView.image = image
                    cell.activityIndicator.stopAnimating()
                }
            })
        }
        
        return cell
    }
    
    
    
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        println("cell was selected at \(indexPath)")
        // initialize next view controller
        var destinationVC = storyboard?.instantiateViewControllerWithIdentifier("SINGLE_USER_VC") as SingleUserVC

        // Set currentUser on next view controller
        destinationVC.selectedUser = self.userArray[indexPath.row]
        
        self.navigationController?.pushViewController(destinationVC, animated: true)
    }
    
    
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        let searchText = searchBar.text
        println("user wants to search for: \(searchText)")
                
        searchBar.resignFirstResponder()
        
        if NetworkController.controller.authenticated {
            // returns true if authenticated so do the network call
            // this is the base github url for searching users
            var urlSearchString = "https://api.github.com/search/users?per_page=90&"
            // modify it with the search term(s) from the search bar
            urlSearchString = urlSearchString + "q=\(searchText)"
            println("urlSearchString: \(urlSearchString)")
            let url = NSURL(string: urlSearchString)
            
            NetworkController.controller.fetchJSONData(url!, completionHandler: { (errorDescription, rawJSONData) -> (Void) in
                
                if errorDescription != nil {
                    println("there was an error getting the JSON")
                } else {
                    println("getting json for User")
                    self.userArray = NetworkController.controller.parseJSONDataForUsers(rawJSONData!)!
                    
                    if self.userArray.count > 0 {
                        self.instructionsLabel.hidden = true
                    }
                    
                    self.collectionView.reloadData()
                }
            })
            
        } else {
            println("not authenticated. present alert")
            var alert = UIAlertController(title: "Session is not authenticated", message: "Tap OK to authenticate", preferredStyle: UIAlertControllerStyle.Alert)
            let OKAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default) { (action) -> Void in
                var alert = NetworkController.controller.makeAlertBeforeSafariOpens()
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
    

    
    func navigationController(navigationController: UINavigationController, animationControllerForOperation operation: UINavigationControllerOperation, fromViewController fromVC: UIViewController, toViewController toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        // Check to make sure what the fromVC and toVCs are. If correct, implement animator files
        if let userCollectionVC = fromVC as? UserCollectionVC {
            if let singleUserVC = toVC as? SingleUserVC {
                
                println("show animation")
                
                let animator = AnimatorToSingleUser()
                return animator
            }
        }
            
        else if let singleUserVC = fromVC as? SingleUserVC {
            if let userCollectionVC = toVC as? UserCollectionVC {
                
                println("hide animation")
                
                let animator = AnimatorBackToUserCollection()
                return animator
            }
        }
        
        // All other transitions don't use any animations
        return nil
    }

    
}
