//
//  UserCell.h
//  StackOverFlowed
//
//  Created by Parker Lewis on 11/15/14.
//  Copyright (c) 2014 CodeFellows. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
@property (weak, nonatomic) IBOutlet UILabel *username;

@end
