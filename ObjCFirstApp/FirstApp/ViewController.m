//
//  ViewController.m
//  FirstApp
//
//  Created by Andrew Shepard on 11/10/14.
//  Copyright (c) 2014 Andrew Shepard. All rights reserved.
//

#import "ViewController.h"
#import "APILoader.h"

@interface ViewController ()

@property (nonatomic, strong) APILoader *loader;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSArray *people = [NSArray arrayWithObjects:@"Homer", @"Bart", @"Maggie", @"Marge", nil];
    self.people = people;
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
//    
//    NSString * myString = @"Brad";
//    
//    NSLog(@"%p",myString);
//    
//    NSString *anotherString = @"Andy";
//    
//    NSLog(@" %p",anotherString);
//    NSLog(@" %@", anotherString);
//    
//    SEL aSelector = @selector(drawRect:);
//    SEL bSelector = NSSelectorFromString(@"drawRect:");
//    
//    [self.view performSelectorInBackground:aSelector withObject:nil];
//    [self.view performSelectorInBackground:bSelector withObject:nil];
//    
//    [UIView animateWithDuration:2.0 animations:^{
//        //
//    }];
    
    self.loader = [[APILoader alloc] init];
//    self.loader = [APILoader new];
    
    [self.loader loadData:^(NSArray *results, NSError *error) {
        NSLog(@"got data: %@", results);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.people count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    cell.textLabel.text = [NSString stringWithFormat:@"Hello"];
    
    return cell;
}

@end
