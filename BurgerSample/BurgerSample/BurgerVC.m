//
//  BurgerVC.m
//  BurgerSample
//
//  Created by Parker Lewis on 11/24/14.
//  Copyright (c) 2014 CodeFellows. All rights reserved.
//

#import "BurgerVC.h"

@interface BurgerVC ()


@property (strong, nonatomic) DrawBurgerChoices *drawBurgerChoices;
@property (strong, nonatomic) UILabel *chooseYourMealLabel;
@property (strong, nonatomic) UILabel *choiceLabel;


-(void)handleSingleTapGesture:(UITapGestureRecognizer *)tapGestureRecognizer;

@end

@implementation BurgerVC

- (void)viewDidLoad {
    [super viewDidLoad];

    // Load the drawings
    self.drawBurgerChoices = [[[DrawBurgerChoices alloc] init] autorelease];
    self.drawBurgerChoices.translatesAutoresizingMaskIntoConstraints = NO;
    self.drawBurgerChoices.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.drawBurgerChoices];

    
    // Make burger label
    self.chooseYourMealLabel = [[UILabel alloc] init];
    self.chooseYourMealLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.chooseYourMealLabel.text = @"Choose your meal";
    self.chooseYourMealLabel.backgroundColor = [UIColor clearColor];
    self.chooseYourMealLabel.font = [UIFont boldSystemFontOfSize:20];
    self.chooseYourMealLabel.textColor = [UIColor blackColor];
    self.chooseYourMealLabel.layer.cornerRadius = 15;
    self.chooseYourMealLabel.layer.borderColor = [[UIColor blackColor] CGColor];
    self.chooseYourMealLabel.layer.borderWidth = 4;
    self.chooseYourMealLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.chooseYourMealLabel];
    
    // Make label
    self.choiceLabel = [[UILabel alloc] init];
    self.choiceLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.choiceLabel.text = @"You will eat: ";
    self.choiceLabel.font = [UIFont boldSystemFontOfSize:20];
    self.choiceLabel.textColor = [UIColor blackColor];
    self.choiceLabel.backgroundColor = [UIColor clearColor];
    self.choiceLabel.layer.borderColor = [[UIColor blackColor] CGColor];
    self.choiceLabel.layer.borderWidth = 1;
    self.choiceLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.choiceLabel];


    self.singleTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTapGesture:)];
    [self.drawBurgerChoices addGestureRecognizer: self.singleTapGestureRecognizer];
    
    
    [self setupConstraints];

}

-(void)handleSingleTapGesture:(UITapGestureRecognizer *)tapGestureRecognizer {
    


    NSDictionary *userInfo = [[NSDictionary alloc] init];

    CGPoint p = [tapGestureRecognizer locationInView:self.drawBurgerChoices];
    if (p.x < self.drawBurgerChoices.frame.size.width / 2 && p.y < self.drawBurgerChoices.frame.size.height / 2) {
        NSLog(@"it's in burger section");
        self.choiceLabel.text = @"You will eat: BURGERS";
        userInfo = @{@"meal": @0};
    } else if (p.x > self.drawBurgerChoices.frame.size.width / 2 && p.y < self.drawBurgerChoices.frame.size.height / 2) {
        NSLog(@"it's in hotdog section");
        self.choiceLabel.text = @"You will eat: HOTDOGS";
        userInfo = @{@"meal": @1};
    } else if (p.x < self.drawBurgerChoices.frame.size.width / 2 && p.y > self.drawBurgerChoices.frame.size.height / 2) {
        NSLog(@"it's in pizza section");
        self.choiceLabel.text = @"You will eat: PIZZA";
        userInfo = @{@"meal": @2};
    } else {
        NSLog(@"it's in taco");
        self.choiceLabel.text = @"You will eat: TACOS";
        userInfo = @{@"meal": @3};
    }
    
    NSNotification *newMealNotification = [[NSNotification alloc] initWithName:@"NEW_MEAL_CHOICE" object:nil userInfo:userInfo];
    [[NSNotificationCenter defaultCenter] postNotification:newMealNotification];

}


- (void) setupConstraints {
    
    NSDictionary *viewsDictionary = @{@"drawBurgerChoices": self.drawBurgerChoices,
                                      @"chooseYourMealLabel": self.chooseYourMealLabel,
                                      @"choiceLabel": self.choiceLabel};
    
    [self.view addConstraints:[NSLayoutConstraint
                              constraintsWithVisualFormat:@"H:[chooseYourMealLabel(200)]"
                              options:0
                              metrics:nil
                              views:viewsDictionary]];
    
    [self.view addConstraints:[NSLayoutConstraint
                               constraintsWithVisualFormat:@"V:[chooseYourMealLabel(50)]"
                               options:NSLayoutFormatDirectionLeadingToTrailing
                               metrics:nil
                               views:viewsDictionary]];
    
    [self.view addConstraints:[NSLayoutConstraint
                               constraintsWithVisualFormat:@"V:|-30-[chooseYourMealLabel]"
                               options:NSLayoutFormatDirectionLeadingToTrailing
                               metrics:nil
                               views:viewsDictionary]];


    [self.view addConstraint:[NSLayoutConstraint constraintWithItem: self.chooseYourMealLabel
                                                          attribute: NSLayoutAttributeCenterX
                                                          relatedBy: NSLayoutRelationEqual
                                                             toItem: self.view
                                                          attribute: NSLayoutAttributeCenterX
                                                         multiplier: 1
                                                           constant: 0]
     ];

    
    
    
    
    
    
    [self.view addConstraints:[NSLayoutConstraint
                               constraintsWithVisualFormat:@"H:[drawBurgerChoices(300)]"
                               options:NSLayoutFormatDirectionLeadingToTrailing
                               metrics:nil
                               views:viewsDictionary]];
    
    [self.view addConstraints:[NSLayoutConstraint
                               constraintsWithVisualFormat:@"V:[drawBurgerChoices(300)]"
                               options:NSLayoutFormatDirectionLeadingToTrailing
                               metrics:nil
                               views:viewsDictionary]];
    
    [self.view addConstraints:[NSLayoutConstraint
                               constraintsWithVisualFormat:@"V:[chooseYourMealLabel]-30-[drawBurgerChoices]"
                               options:NSLayoutFormatDirectionLeadingToTrailing
                               metrics:nil
                               views:viewsDictionary]];

    [self.view addConstraint:[NSLayoutConstraint constraintWithItem: self.drawBurgerChoices
                                                          attribute: NSLayoutAttributeCenterX
                                                          relatedBy: NSLayoutRelationEqual
                                                             toItem: self.view
                                                          attribute: NSLayoutAttributeCenterX
                                                         multiplier: 1
                                                           constant: 0]
     ];

    
    
    
    [self.view addConstraints:[NSLayoutConstraint
                               constraintsWithVisualFormat:@"H:[choiceLabel(300)]"
                               options:0
                               metrics:nil
                               views:viewsDictionary]];
    
    [self.view addConstraints:[NSLayoutConstraint
                               constraintsWithVisualFormat:@"V:[choiceLabel(100)]"
                               options:0
                               metrics:nil
                               views:viewsDictionary]];
    
    [self.view addConstraints:[NSLayoutConstraint
                               constraintsWithVisualFormat:@"V:[drawBurgerChoices]-30-[choiceLabel]"
                               options:NSLayoutFormatDirectionLeadingToTrailing
                               metrics:nil
                               views:viewsDictionary]];

    [self.view addConstraint:[NSLayoutConstraint constraintWithItem: self.choiceLabel
                                                          attribute: NSLayoutAttributeCenterX
                                                          relatedBy: NSLayoutRelationEqual
                                                             toItem: self.view
                                                          attribute: NSLayoutAttributeCenterX
                                                         multiplier: 1
                                                           constant: 0]
     ];
}



- (void)dealloc
{
    [super dealloc];
}

@end
