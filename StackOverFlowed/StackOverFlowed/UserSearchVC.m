//
//  UserSearchVC.m
//  StackOverFlowed
//
//  Created by Parker Lewis on 11/15/14.
//  Copyright (c) 2014 CodeFellows. All rights reserved.
//

#import "UserSearchVC.h"
#import <SVProgressHUD.h>
#import "NetworkController.h"
#import "User.h"
#import "UserCell.h"


@interface UserSearchVC ()

@end

@implementation UserSearchVC

- (void)viewDidLoad {
    [super viewDidLoad];

    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;

    
    UINib *nib = [UINib nibWithNibName:@"UserCell" bundle:[NSBundle mainBundle]];
    [self.collectionView registerNib:nib forCellWithReuseIdentifier:@"USER_CELL"];


}


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    // Ternary operator: if self.usersArray.count is greater than 0 then return self.usersArray.count. Else, return 0
    return self.usersArray.count > 0 ? self.usersArray.count : 0;
}



- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UserCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"USER_CELL" forIndexPath:indexPath];

    User *currentUser = self.usersArray[indexPath.row];
    cell.username.text = currentUser.displayName;
    cell.backgroundColor = [UIColor redColor];
    return cell;

}



- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HEADER" forIndexPath:indexPath];
    
    CGRect headerFrame = header.frame;
    UISearchBar *searchbar = [[UISearchBar alloc] initWithFrame:headerFrame];
    searchbar.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    searchbar.delegate = self;
    searchbar.placeholder = @"Search for users...";
    [header addSubview:searchbar];
    return header;
}



- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    NSLog(@"%@",searchBar.text);
    
    
    [SVProgressHUD show];
    
    
    NSString *requestURLString;
    NSString *token = [[NSUserDefaults standardUserDefaults] valueForKey:@"token"];
    requestURLString = [NSString stringWithFormat: @"https://api.stackexchange.com/2.2/users?order=desc&sort=reputation&inname=%@&site=stackoverflow&filter=!G*lE4GjY0j6tW*dQy5SwEQdm8i&access_token=%@&key=stuvaUJEX6kTlkHrvBNZVA((", searchBar.text, token];
    
    
    [[NetworkController networkController] fetchJSONDataFrom:requestURLString withCompletion:^(NSString *errorString, NSData *rawJSONData) {
        if (errorString != nil) {
            NSLog(@"There was an error: %@", errorString);
        } else {
            NSMutableArray *users = [[User alloc] parseJSONIntoUserArrayFrom:rawJSONData];
            self.usersArray = users;
            NSLog(@"%lu", self.usersArray.count);
            
            [self.collectionView reloadData];
            [SVProgressHUD dismiss];

            
            
//            [[NetworkController networkController] fetchProfileImageForUser:self.currentUser.profileImageURL withCompletion:^(UIImage *image) {
//                self.profileImageView.image = image;
//                [SVProgressHUD dismiss];
//            }];
        }
    }];
    

}


@end
