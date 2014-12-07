//
//  ToppingsVC.m
//  BurgerSample
//
//  Created by Parker Lewis on 11/24/14.
//  Copyright (c) 2014 CodeFellows. All rights reserved.
//

#import "ToppingsVC.h"
#import "CheckListCell.h"

@interface ToppingsVC ()

@property (strong, nonatomic) UILabel *chooseYourToppingsLabel;
//@property (strong, nonatomic) NSDictionary *hamburgerToppings;
//@property (strong, nonatomic) NSDictionary *hotdogToppings;
//@property (strong, nonatomic) NSDictionary *pizzaToppings;
//@property (strong, nonatomic) NSDictionary *tacoToppings;

@property (strong, nonatomic) NSArray *hamburgerToppings;
@property (strong, nonatomic) NSArray *hamburgerToppingsImages;

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
    
    self.hamburgerToppings = @[@"Tomato", @"Lettuce", @"Cheese", @"Onions", @"Pickles", @"Mustard"];
//    self.hamburgerToppingsImages = @[[UIImage imageNamed:@"tomato"], [UIImage imageNamed:@"lettuce"], [UIImage imageNamed:@"cheese"], [UIImage imageNamed:@"onion"], [UIImage imageNamed:@"pickles"], [UIImage imageNamed:@"mustard"]];
    self.hamburgerToppingsImages = [[[NSArray alloc] initWithObjects: [UIImage imageNamed:@"tomato"], [UIImage imageNamed:@"lettuce"], [UIImage imageNamed:@"cheese"], [UIImage imageNamed:@"onion"], [UIImage imageNamed:@"pickles"], [UIImage imageNamed:@"mustard"], nil] autorelease];

    self.hotdogToppings = @[@"Ketchup", @"Relish", @"Mustard"];
    self.tacoToppings = @[@"Cheese", @"Salsa", @"Lettuce", @"TEST"];
    self.pizzaToppings = @[@"Extra Cheese", @"Pepperoni", @"Sausage", @"Canadian Bacon", @"Pineapple", @"Peppers", @"Onion"];
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
    self.chooseYourToppingsLabel.layer.borderWidth = 2;
    self.chooseYourToppingsLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.chooseYourToppingsLabel];
    
    
    // make tableview
    self.toppingsTableView = [[[UITableView alloc] init] autorelease];
    self.toppingsTableView.translatesAutoresizingMaskIntoConstraints = NO;
    self.toppingsTableView.delegate = self;
    self.toppingsTableView.dataSource = self;
    self.toppingsTableView.scrollEnabled = NO;
    self.toppingsTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.toppingsTableView.backgroundColor = self.themeColor;
    [self.view addSubview:self.toppingsTableView];
    
    
    [self setupConstraints];
   
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(mealChoiceUpdated:) name:@"NEW_MEAL_CHOICE" object:nil];

}


-(void) mealChoiceUpdated:(NSNotification*) notification {
    
    int changedState = [[notification.userInfo objectForKey:@"meal"] intValue];
    NSLog(@"%D", changedState);
    if (changedState == 1) {
        self.currentToppings = self.hamburgerToppings;
        self.chooseYourToppingsLabel.text = @"Choose your hamburger toppings";
    } else if (changedState == 2) {
        self.currentToppings = self.hotdogToppings;
        self.chooseYourToppingsLabel.text = @"Choose your hot dog toppings";
    } else if (changedState == 3) {
        self.currentToppings = self.tacoToppings;
        self.chooseYourToppingsLabel.text = @"Choose your taco toppings";
    } else if (changedState == 4) {
        self.currentToppings = self.pizzaToppings;
        self.chooseYourToppingsLabel.text = @"Choose your pizza toppings";
    } else {
        NSLog(@"NO CHOICE");
    }

    
    [self.toppingsTableView reloadData];
}




-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    CheckListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL"];
    if (cell == nil) {
        cell = [[CheckListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CELL"];
    }
    cell.checkboxImage.image = [UIImage imageNamed:@"uncheckedBox"];
    cell.itemLabel.text = self.currentToppings[indexPath.row];
    cell.backgroundColor = self.view.backgroundColor;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    // make a check for the state to determine which images to load
    cell.itemImage.image = self.hamburgerToppingsImages[0];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.currentToppings.count;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return (self.toppingsTableView.frame.size.height / [self.currentToppings count]) < 100 ? self.toppingsTableView.frame.size.height / [self.currentToppings count] : 100;    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    CheckListCell *currentCell = (CheckListCell*) [self.toppingsTableView cellForRowAtIndexPath:indexPath];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    if (!currentCell.isChecked) {
        currentCell.checkboxImage.image = [UIImage imageNamed:@"checkedBox"];
        currentCell.isChecked = YES;
    } else {
        currentCell.checkboxImage.image = [UIImage imageNamed:@"uncheckedBox"];
        currentCell.isChecked = NO;
    }
}



-(void) setupConstraints {
    NSDictionary *viewsDictionary = @{@"chooseYourToppingsLabel": self.chooseYourToppingsLabel,
                                      @"toppingsTableView": self.toppingsTableView};
    
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
                               constraintsWithVisualFormat:@"H:|-0-[toppingsTableView]-0-|"
                               options:NSLayoutFormatDirectionLeadingToTrailing
                               metrics:nil
                               views:viewsDictionary]];
    
    [self.view addConstraints:[NSLayoutConstraint
                               constraintsWithVisualFormat:@"V:[chooseYourToppingsLabel]-20-[toppingsTableView]-70-|"
                               options:NSLayoutFormatDirectionLeadingToTrailing
                               metrics:nil
                               views:viewsDictionary]];

}

@end
