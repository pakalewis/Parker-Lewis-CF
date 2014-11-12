//
//  QuestionSearch.h
//  StackOverFlowed
//
//  Created by Parker Lewis on 11/10/14.
//  Copyright (c) 2014 CodeFellows. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QuestionSearch : UIViewController <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>

@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, weak) IBOutlet UISearchBar *searchBar;


@property (nonatomic, strong) NSMutableArray *questionsArray;

@end

