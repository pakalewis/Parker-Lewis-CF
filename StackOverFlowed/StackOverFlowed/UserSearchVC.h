//
//  UserSearchVC.h
//  StackOverFlowed
//
//  Created by Parker Lewis on 11/15/14.
//  Copyright (c) 2014 CodeFellows. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserSearchVC : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate, UISearchBarDelegate, UINavigationControllerDelegate>

@property (nonatomic, weak) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *usersArray;
@property (nonatomic, assign) BOOL isAuthenticated;


@end
