//
//  SidesVC.m
//  BurgerSample
//
//  Created by Parker Lewis on 11/24/14.
//  Copyright (c) 2014 CodeFellows. All rights reserved.
//

#import "SidesVC.h"

@interface SidesVC ()


@property (strong, nonatomic) NSArray *listOfSides;

@property (strong, nonatomic) UILabel *chooseYourSidesLabel;


@end

@implementation SidesVC

- (void)viewDidLoad {
    [super viewDidLoad];

    self.listOfSides = @[@"French Fries", @"Onion Rings", @"Nuggets", @"Milkshake", @"Soda"];

    
    // Make Toppings label
    self.chooseYourSidesLabel = [[[UILabel alloc] init] autorelease];
    self.chooseYourSidesLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.chooseYourSidesLabel.text = @"Choose your sides";
    self.chooseYourSidesLabel.backgroundColor = [UIColor clearColor];
    self.chooseYourSidesLabel.font = [UIFont boldSystemFontOfSize:20];
    self.chooseYourSidesLabel.textColor = [UIColor blackColor];
    self.chooseYourSidesLabel.layer.cornerRadius = 15;
    self.chooseYourSidesLabel.layer.borderColor = [[UIColor blackColor] CGColor];
    self.chooseYourSidesLabel.layer.borderWidth = 2;
    self.chooseYourSidesLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.chooseYourSidesLabel];

    
    // make tableview
    self.sidesTableView = [[[UITableView alloc] init] autorelease];
    self.sidesTableView.translatesAutoresizingMaskIntoConstraints = NO;
    self.sidesTableView.delegate = self;
    self.sidesTableView.dataSource = self;
    self.sidesTableView.scrollEnabled = NO;
    self.sidesTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.sidesTableView];

    [self setupConstraints];

}


-(void) setupConstraints {
    NSDictionary *viewsDictionary = @{@"chooseYourSidesLabel": self.chooseYourSidesLabel,
                                      @"sidesTableView": self.sidesTableView};
    
    [self.view addConstraints:[NSLayoutConstraint
                               constraintsWithVisualFormat:@"V:[chooseYourSidesLabel(50)]"
                               options:NSLayoutFormatDirectionLeadingToTrailing
                               metrics:nil
                               views:viewsDictionary]];
    
    [self.view addConstraints:[NSLayoutConstraint
                               constraintsWithVisualFormat:@"V:|-30-[chooseYourSidesLabel]"
                               options:NSLayoutFormatDirectionLeadingToTrailing
                               metrics:nil
                               views:viewsDictionary]];
    
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem: self.chooseYourSidesLabel
                                                          attribute: NSLayoutAttributeCenterX
                                                          relatedBy: NSLayoutRelationEqual
                                                             toItem: self.view
                                                          attribute: NSLayoutAttributeCenterX
                                                         multiplier: 1
                                                           constant: 0]
     ];
//    [self.view addConstraints:[NSLayoutConstraint
//                               constraintsWithVisualFormat:@"H:[sidesTableView(300)]"
//                               options:0
//                               metrics:nil
//                               views:viewsDictionary]];
    
    [self.view addConstraints:[NSLayoutConstraint
                               constraintsWithVisualFormat:@"H:|-30-[sidesTableView]-30-|"
                               options:NSLayoutFormatDirectionLeadingToTrailing
                               metrics:nil
                               views:viewsDictionary]];
    
    [self.view addConstraints:[NSLayoutConstraint
                               constraintsWithVisualFormat:@"V:[chooseYourSidesLabel]-30-[sidesTableView]-70-|"
                               options:NSLayoutFormatDirectionLeadingToTrailing
                               metrics:nil
                               views:viewsDictionary]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem: self.sidesTableView
                                                          attribute: NSLayoutAttributeCenterX
                                                          relatedBy: NSLayoutRelationEqual
                                                             toItem: self.view
                                                          attribute: NSLayoutAttributeCenterX
                                                         multiplier: 1
                                                           constant: 0]
     ];
    
    
    
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
    
    cell.textLabel.text = self.listOfSides[indexPath.row];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.listOfSides.count;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.sidesTableView.frame.size.height / [self.listOfSides count];
}

@end
