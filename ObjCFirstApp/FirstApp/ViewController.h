//
//  ViewController.h
//  FirstApp
//
//  Created by Andrew Shepard on 11/10/14.
//  Copyright (c) 2014 Andrew Shepard. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSArray *people;

@property (nonatomic, weak) IBOutlet UITableView *tableView;

@end

