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
@property (strong, nonatomic) UILabel *burgerLabel;

@end

@implementation BurgerVC

- (void)viewDidLoad {
    [super viewDidLoad];

    self.drawBurgerChoices = [[[DrawBurgerChoices alloc] init] autorelease];
    self.drawBurgerChoices.translatesAutoresizingMaskIntoConstraints = NO;
    self.drawBurgerChoices.backgroundColor = [UIColor clearColor];
    
    
    // Make burger label
    self.burgerLabel = [[UILabel alloc] init];
    self.burgerLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.burgerLabel.text = @"Choose your burger";
    self.burgerLabel.backgroundColor = [UIColor clearColor];
    self.burgerLabel.layer.cornerRadius = 15;
    self.burgerLabel.font = [UIFont boldSystemFontOfSize:20];
    self.burgerLabel.textColor = [UIColor blackColor];
    self.burgerLabel.layer.borderColor = [[UIColor blackColor] CGColor];
    self.burgerLabel.layer.borderWidth = 4;

    self.burgerLabel.textAlignment = NSTextAlignmentCenter;
//    self.burgerLabel.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin);

    
    [self.view addSubview:self.burgerLabel];
    [self.view addSubview:self.drawBurgerChoices];
    
    [self setupConstraints];

}


- (void) setupConstraints {
    
    NSDictionary *viewsDictionary = @{@"drawBurgerChoices":self.drawBurgerChoices,
                                      @"burgerLabel":self.burgerLabel};
    
    [self.view addConstraints:[NSLayoutConstraint
                               constraintsWithVisualFormat:@"H:[burgerLabel(200)]"
                               options:NSLayoutFormatDirectionLeadingToTrailing
                               metrics:nil
                               views:viewsDictionary]];
    
    [self.view addConstraints:[NSLayoutConstraint
                               constraintsWithVisualFormat:@"V:[burgerLabel(50)]"
                               options:NSLayoutFormatDirectionLeadingToTrailing
                               metrics:nil
                               views:viewsDictionary]];
    
    [self.view addConstraints:[NSLayoutConstraint
                               constraintsWithVisualFormat:@"V:|-30-[burgerLabel]"
                               options:NSLayoutFormatDirectionLeadingToTrailing
                               metrics:nil
                               views:viewsDictionary]];


    [self.view addConstraint:[NSLayoutConstraint constraintWithItem: self.burgerLabel
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
    
//    [self.view addConstraints:[NSLayoutConstraint
//                               constraintsWithVisualFormat:@"V:|-30-[drawBurgerChoices]"
//                               options:NSLayoutFormatDirectionLeadingToTrailing
//                               metrics:nil
//                               views:viewsDictionary]];

    [self.view addConstraint:[NSLayoutConstraint constraintWithItem: self.drawBurgerChoices
                                                          attribute: NSLayoutAttributeCenterX
                                                          relatedBy: NSLayoutRelationEqual
                                                             toItem: self.view
                                                          attribute: NSLayoutAttributeCenterX
                                                         multiplier: 1
                                                           constant: 0]
     ];

    [self.view addConstraint:[NSLayoutConstraint constraintWithItem: self.drawBurgerChoices
                                                          attribute: NSLayoutAttributeCenterY
                                                          relatedBy: NSLayoutRelationEqual
                                                             toItem: self.view
                                                          attribute: NSLayoutAttributeCenterY
                                                         multiplier: 1
                                                           constant: 0]
     ];

}



- (void)dealloc
{
    [super dealloc];
}

@end
