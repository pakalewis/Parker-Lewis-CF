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
#import "math.h"

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
    
    self.dateFormatter = [[NSDateFormatter alloc] init];
    [self.dateFormatter setDateFormat:@"MM-dd-yyyy 'at' hh:mm a"];
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
    
    
    // Show time elapsed and the username of the question asker
    NSDate *currentDate = [NSDate date];
    NSTimeInterval timeElapsedInSeconds = [currentDate timeIntervalSinceDate:[NSDate dateWithTimeIntervalSince1970:currentQuestion.creation_date]];
    if (timeElapsedInSeconds > 60 && timeElapsedInSeconds < 60 * 60) {
        NSTimeInterval timeInMinutes = timeElapsedInSeconds / 60;
        if (timeInMinutes < 1.5) {
            cell.dateLabel.text = [NSString stringWithFormat:@"%.0f minute ago, \n%@ asked:", timeInMinutes, currentQuestion.username];
        } else {
            cell.dateLabel.text = [NSString stringWithFormat:@"%.0f minutes ago, \n%@ asked:", timeInMinutes, currentQuestion.username];
        }
    } else if (timeElapsedInSeconds > 60 * 60 && timeElapsedInSeconds < 60 * 60 * 24){
        NSTimeInterval timeInHours = timeElapsedInSeconds / 60 / 60;
        if (timeInHours < 1.5) {
            cell.dateLabel.text = [NSString stringWithFormat:@"%.0f hour ago, \n%@ asked:", timeInHours, currentQuestion.username];
        } else {
            cell.dateLabel.text = [NSString stringWithFormat:@"%.0f hours ago, \n%@ asked:", timeInHours, currentQuestion.username];
        }
    } else if (timeElapsedInSeconds > 60 * 60 * 24 && timeElapsedInSeconds < 60 * 60 * 24 * 365) {
        NSTimeInterval timeInDays = timeElapsedInSeconds / 60 / 60 / 24;
        if (timeInDays < 1.5) {
            cell.dateLabel.text = [NSString stringWithFormat:@"%.0f day ago, \n%@ asked:", timeInDays, currentQuestion.username];
        } else {
            cell.dateLabel.text = [NSString stringWithFormat:@"%.0f days ago, \n%@ asked:", timeInDays, currentQuestion.username];
        }
    } else if (timeElapsedInSeconds > 60 * 60 * 24 * 365) {
        NSTimeInterval timeInYears = timeElapsedInSeconds / 60 / 60 / 24 / 365;
        if (timeInYears < 1.5) {
            cell.dateLabel.text = [NSString stringWithFormat:@"%.0f year ago, \n%@ asked:", timeInYears, currentQuestion.username];
        } else {
            cell.dateLabel.text = [NSString stringWithFormat:@"%.0f years ago, \n%@ asked:", timeInYears, currentQuestion.username];
        }
    } else {
        cell.dateLabel.text = [NSString stringWithFormat:@"%.0f seconds ago, \n%@ asked:",timeElapsedInSeconds, currentQuestion.username];
    }

    // Get the profile images
    NSInteger currentTag = cell.tag + 1;
    cell.tag = currentTag;
    cell.profileImage.image = nil;
    [[NetworkController networkController] fetchProfileImageForUser:currentQuestion.profileImageURL withCompletion:^(UIImage *image) {
        if (cell.tag == currentTag) {
            cell.profileImage.image = image;
        }
    }];

    // Populate the rest of the labels
    cell.questionLabel.text = currentQuestion.title;
    cell.viewsLabel.text = [NSString stringWithFormat:@"Views: %ld",(long)currentQuestion.view_count];
    cell.answersLabel.text = [NSString stringWithFormat:@"Answers: %ld",(long)currentQuestion.answer_count];
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%@",[self.questionsArray[indexPath.row] title]);
}


- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
    NSLog(@"Searching for %@", searchBar.text);
    
    NSString *requestURLString;
    if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"token"] isKindOfClass:[NSString class]]) {
        // authenticated
        NSString *token = [[NSUserDefaults standardUserDefaults] valueForKey:@"token"];
        requestURLString = [NSString stringWithFormat: @"https://api.stackexchange.com/2.2/search?order=desc&sort=activity&tagged=%@&site=stackoverflow&access_token=%@&key=stuvaUJEX6kTlkHrvBNZVA((", searchBar.text, token];
    } else {
        // not authenticated = no token
        requestURLString = [NSString stringWithFormat: @"https://api.stackexchange.com/2.2/search?order=desc&sort=activity&tagged=%@&site=stackoverflow", searchBar.text];
    }


    [[NetworkController networkController] fetchJSONDataFrom:requestURLString withCompletion:^(NSString * errorString, NSData *rawJSONData) {
        if (errorString != nil) {
            NSLog(@"There was an error: %@", errorString);
        } else {
            
            NSMutableArray *questions = [[Question alloc] parseJSONIntoQuestionArrayFrom:rawJSONData];
            self.questionsArray = questions;
            NSLog(@"%lu", self.questionsArray.count);
            [self.tableView reloadData];
        }
    }];
}

@end
