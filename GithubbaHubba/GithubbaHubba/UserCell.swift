//
//  UserCell.swift
//  GithubbaHubba
//
//  Created by Parker Lewis on 10/22/14.
//  Copyright (c) 2014 Parker Lewis. All rights reserved.
//

import UIKit

class UserCell: UICollectionViewCell {
  
    
    
    @IBOutlet weak var userAvatarImageView: UIImageView!
    
    @IBOutlet weak var userName: UILabel!
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.userAvatarImageView.image = nil
        self.userName.text = nil
        
    }
    
    
}
