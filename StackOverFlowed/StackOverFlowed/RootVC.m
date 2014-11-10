//
//  RootVC.m
//  StackOverFlowed
//
//  Created by Parker Lewis on 11/10/14.
//  Copyright (c) 2014 CodeFellows. All rights reserved.
//

#import "RootVC.h"

@interface RootVC ()



@end

@implementation RootVC

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationController.delegate = self;
    

}

- (void)viewWillAppear:(BOOL)animated {
    [self newFunc];
    
}

- (void)newFunc {
    NSLog(@"new func fired");
    
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL" forIndexPath:indexPath];
    
    cell.textLabel.text = [NSString stringWithFormat:@"Hello"];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"TEST");
}



@end
