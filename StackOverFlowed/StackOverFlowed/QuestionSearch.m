//
//  QuestionSearch.m
//  StackOverFlowed
//
//  Created by Parker Lewis on 11/10/14.
//  Copyright (c) 2014 CodeFellows. All rights reserved.
//

#import "QuestionSearch.h"
#import "Question.h"
#import "NetworkController.h"
#import "WebVC.h"

@interface QuestionSearch ()



@end

@implementation QuestionSearch 

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.searchBar.delegate = self;
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    return self.questionsArray.count;
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL" forIndexPath:indexPath];
    
//    Question *currentQuestion = self.questionsArray[indexPath.row];
//    cell.textLabel.text = currentQuestion.title;
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}


- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
    NSLog(@"Searching for %@", searchBar.text);
    [[NetworkController networkController] fetchQuestionsForTag:searchBar.text withCompletion:^(NSString * errorString, NSMutableArray * fetchedQuestions) {
        if (errorString != nil) {
            NSLog(@"There was an error!");
        } else {
            self.questionsArray = fetchedQuestions;
            NSLog(@"%lu", self.questionsArray.count);
            [self.tableView reloadData];
        }
    }];
    
    
}

@end
