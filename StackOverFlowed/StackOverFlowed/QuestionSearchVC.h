//
//  QuestionSearchVC.h
//  StackOverFlowed
//
//  Created by Parker Lewis on 11/10/14.
//  Copyright (c) 2014 CodeFellows. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QuestionSearchVC : UIViewController <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, UINavigationControllerDelegate>

@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, weak) IBOutlet UISearchBar *searchBar;


@property (nonatomic, strong) NSMutableArray *questionsArray;
@property (nonatomic, strong) NSDateFormatter *dateFormatter;
@property (nonatomic, assign) BOOL isAuthenticated;

@end

