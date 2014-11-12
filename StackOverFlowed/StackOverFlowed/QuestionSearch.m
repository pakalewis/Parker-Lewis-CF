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
#import "QuestionCell.h"

@interface QuestionSearch ()



@end

@implementation QuestionSearch 

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.searchBar.delegate = self;
    
    UINib *nib = [UINib nibWithNibName:@"QuestionCell" bundle:[NSBundle mainBundle]];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"QUESTION_CELL"];
    
//    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.questionsArray.count > 0 ? self.questionsArray.count : 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 91;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    QuestionCell *cell = [tableView dequeueReusableCellWithIdentifier:@"QUESTION_CELL" forIndexPath:indexPath];
    
    Question *currentQuestion = self.questionsArray[indexPath.row];
    
    cell.questionLabel.text = currentQuestion.title;
    cell.profileImage.backgroundColor = [UIColor blueColor];
//    cell.dateLabel.text = currentQuestion.creation_date;
    cell.viewsLabel.text = [NSString stringWithFormat:@"Views: %ld",(long)currentQuestion.view_count];
    cell.answersLabel.text = [NSString stringWithFormat:@"Answers: %ld",(long)currentQuestion.answer_count];
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}


- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
    NSLog(@"Searching for %@", searchBar.text);
    [[NetworkController networkController] fetchQuestionsForTag:searchBar.text withCompletion:^(NSString * errorString, NSMutableArray * fetchedQuestions) {
        if (errorString != nil) {
            NSLog(@"There was an error: %@", errorString);
        } else {
            self.questionsArray = fetchedQuestions;
            NSLog(@"%lu", self.questionsArray.count);
            [self.tableView reloadData];
        }
    }];
    
    
}

@end
