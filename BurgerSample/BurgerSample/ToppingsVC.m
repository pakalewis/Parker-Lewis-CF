//
//  ToppingsVC.m
//  BurgerSample
//
//  Created by Parker Lewis on 11/24/14.
//  Copyright (c) 2014 CodeFellows. All rights reserved.
//

#import "ToppingsVC.h"
#import "MenuCell.h"

@interface ToppingsVC ()

@property (strong, nonatomic) UILabel *chooseYourToppingsLabel;
//@property (strong, nonatomic) NSDictionary *hamburgerToppings;
//@property (strong, nonatomic) NSDictionary *hotdogToppings;
//@property (strong, nonatomic) NSDictionary *pizzaToppings;
//@property (strong, nonatomic) NSDictionary *tacoToppings;

@property (strong, nonatomic) NSArray *hamburgerToppings;
@property (strong, nonatomic) NSArray *hotdogToppings;
@property (strong, nonatomic) NSArray *pizzaToppings;
@property (strong, nonatomic) NSArray *tacoToppings;
@property (strong, nonatomic) NSArray *currentToppings;






@end

@implementation ToppingsVC


-(void)viewDidLoad {
    [super viewDidLoad];

//    NSArray *values = [NSArray arrayWithObjects: @"tomato", @"lettuce", @"cheese", nil];
//    NSArray *keys = [NSArray arrayWithObjects: [NSNumber numberWithBool:NO], [NSNumber numberWithBool:NO], [NSNumber numberWithBool:NO], nil];
//    self.hamburgerToppings = [[NSDictionary alloc] initWithObjects:values forKeys: keys];
    
    self.hamburgerToppings = @[@"Tomato", @"Lettuce", @"Cheese", @"Onion", @"Pickle", @"Mustard"];
    self.hotdogToppings = @[@"Ketchup", @"Relish", @"Mustard"];
    self.pizzaToppings = @[@"Extra Cheese", @"Pepperoni", @"Sausage", @"Canadian Bacon", @"Pineapple", @"Peppers", @"Onion"];
    self.tacoToppings = @[@"Cheese", @"Salsa", @"Lettuce", @"TEST"];
    self.currentToppings = self.hamburgerToppings;
    
    // Make Toppings label
    self.chooseYourToppingsLabel = [[[UILabel alloc] init] autorelease];
    self.chooseYourToppingsLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.chooseYourToppingsLabel.text = @"Choose your toppings";
    self.chooseYourToppingsLabel.backgroundColor = [UIColor clearColor];
    self.chooseYourToppingsLabel.font = [UIFont boldSystemFontOfSize:20];
    self.chooseYourToppingsLabel.textColor = [UIColor blackColor];
    self.chooseYourToppingsLabel.layer.cornerRadius = 15;
    self.chooseYourToppingsLabel.layer.borderColor = [[UIColor blackColor] CGColor];
    self.chooseYourToppingsLabel.layer.borderWidth = 4;
    self.chooseYourToppingsLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.chooseYourToppingsLabel];
    
    
    // make tableview
    self.toppingsTableView = [[[UITableView alloc] init] autorelease];
    self.toppingsTableView.translatesAutoresizingMaskIntoConstraints = NO;
    self.toppingsTableView.delegate = self;
    self.toppingsTableView.dataSource = self;
    self.toppingsTableView.scrollEnabled = NO;
    self.toppingsTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.toppingsTableView];
    
    
    [self setupConstraints];
   
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(mealChoiceUpdated:) name:@"NEW_MEAL_CHOICE" object:nil];

}


-(void) mealChoiceUpdated:(NSNotification*) notification {
    
    int changedState = [[notification.userInfo objectForKey:@"meal"] intValue];
    if (changedState == 0) {
        self.currentToppings = self.hamburgerToppings;
    } else if (changedState == 1) {
        self.currentToppings = self.hotdogToppings;
    } else if (changedState == 2) {
        self.currentToppings = self.pizzaToppings;
    } else {
        self.currentToppings = self.tacoToppings;
    }

    
    [self.toppingsTableView reloadData];
}




-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    MenuCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL"];
//    cell.contentView.backgroundColor = [UIColor redColor];
//    cell.clipsToBounds = NO;
//    cell.textLabel.text = @"test";
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    return cell;
//   
//    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CELL"];
    }
    cell.backgroundView = [[UIView alloc] init];
//    [cell.backgroundView setBackgroundColor:[UIColor clearColor]];
    cell.backgroundColor = self.view.backgroundColor;
//    [[[cell contentView] subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];

    cell.textLabel.text = self.currentToppings[indexPath.row];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.currentToppings.count;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.toppingsTableView.frame.size.height / [self.currentToppings count];
}


-(void) setupConstraints {
    NSDictionary *viewsDictionary = @{@"chooseYourToppingsLabel": self.chooseYourToppingsLabel,
                                      @"toppingsTableView": self.toppingsTableView};
    
    [self.view addConstraints:[NSLayoutConstraint
                               constraintsWithVisualFormat:@"H:[chooseYourToppingsLabel(240)]"
                               options:0
                               metrics:nil
                               views:viewsDictionary]];
    
    [self.view addConstraints:[NSLayoutConstraint
                               constraintsWithVisualFormat:@"V:[chooseYourToppingsLabel(50)]"
                               options:NSLayoutFormatDirectionLeadingToTrailing
                               metrics:nil
                               views:viewsDictionary]];
    
    [self.view addConstraints:[NSLayoutConstraint
                               constraintsWithVisualFormat:@"V:|-30-[chooseYourToppingsLabel]"
                               options:NSLayoutFormatDirectionLeadingToTrailing
                               metrics:nil
                               views:viewsDictionary]];
    
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem: self.chooseYourToppingsLabel
                                                          attribute: NSLayoutAttributeCenterX
                                                          relatedBy: NSLayoutRelationEqual
                                                             toItem: self.view
                                                          attribute: NSLayoutAttributeCenterX
                                                         multiplier: 1
                                                           constant: 0]
     ];
    
    
    
    [self.view addConstraints:[NSLayoutConstraint
                               constraintsWithVisualFormat:@"H:[toppingsTableView(300)]"
                               options:0
                               metrics:nil
                               views:viewsDictionary]];
//    
//    [self.view addConstraints:[NSLayoutConstraint
//                               constraintsWithVisualFormat:@"V:[toppingsTableView(300)]"
//                               options:NSLayoutFormatDirectionLeadingToTrailing
//                               metrics:nil
//                               views:viewsDictionary]];
    
    [self.view addConstraints:[NSLayoutConstraint
                               constraintsWithVisualFormat:@"V:[chooseYourToppingsLabel]-30-[toppingsTableView]-70-|"
                               options:NSLayoutFormatDirectionLeadingToTrailing
                               metrics:nil
                               views:viewsDictionary]];

    [self.view addConstraint:[NSLayoutConstraint constraintWithItem: self.toppingsTableView
                                                          attribute: NSLayoutAttributeCenterX
                                                          relatedBy: NSLayoutRelationEqual
                                                             toItem: self.view
                                                          attribute: NSLayoutAttributeCenterX
                                                         multiplier: 1
                                                           constant: 0]
     ];

    
    
}

@end
