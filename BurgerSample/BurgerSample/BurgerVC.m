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
//@property (strong, nonatomic)  NSLayoutConstraint *burgerLabelX;

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
    self.burgerLabel.text = @"Choose your meal";
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


-(void)willTransitionToTraitCollection:(UITraitCollection *)newCollection withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    
    
    if (newCollection.verticalSizeClass == 1) {
        NSLog(@"compact");
    }
    if (newCollection.verticalSizeClass == 2) {
        NSLog(@"regular");
    }
    
    
//    
//    2014-11-29 18:07:12.436 BurgerSample[10138:22656591] Trait collection = <UITraitCollection: 0x7fad2b4c6e40; _UITraitNameUserInterfaceIdiom = Phone, _UITraitNameDisplayScale = 2.000000, _UITraitNameHorizontalSizeClass = Compact, _UITraitNameVerticalSizeClass = Compact, _UITraitNameTouchLevel = 0, _UITraitNameInteractionModel = 1>
//    2014-11-29 18:07:29.516 BurgerSample[10138:22656591] Trait collection = <UITraitCollection: 0x7fad2b4c9930; _UITraitNameUserInterfaceIdiom = Phone, _UITraitNameDisplayScale = 2.000000, _UITraitNameHorizontalSizeClass = Compact, _UITraitNameVerticalSizeClass = Regular, _UITraitNameTouchLevel = 0, _UITraitNameInteractionModel = 1>
//
//    
//
//    - (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
//    {
//        [super willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
//        
//        if (UIInterfaceOrientationIsPortrait(toInterfaceOrientation))
//            self.mapViewHeightConstraint.constant = 480.0;
//        else
//            self.mapViewHeightConstraint.constant = 0.0;
//    }
}


- (void) setupConstraints {
    
    NSDictionary *viewsDictionary = @{@"drawBurgerChoices":self.drawBurgerChoices,
                                      @"burgerLabel":self.burgerLabel};
    
    [self.view addConstraints:[NSLayoutConstraint
                              constraintsWithVisualFormat:@"H:[burgerLabel(200)]"
                              options:0
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
                               constraintsWithVisualFormat:@"H:[drawBurgerChoices(280)]"
                               options:NSLayoutFormatDirectionLeadingToTrailing
                               metrics:nil
                               views:viewsDictionary]];
    
    [self.view addConstraints:[NSLayoutConstraint
                               constraintsWithVisualFormat:@"V:[drawBurgerChoices(280)]"
                               options:NSLayoutFormatDirectionLeadingToTrailing
                               metrics:nil
                               views:viewsDictionary]];
    
//    [self.view addConstraints:[NSLayoutConstraint
//                               constraintsWithVisualFormat:@"V:|-30-[drawBurgerChoices]"
//                               options:NSLayoutFormatDirectionLeadingToTrailing
//                               metrics:nil
//                               views:viewsDictionary]];

//    [self.view addConstraint:[NSLayoutConstraint constraintWithItem: self.drawBurgerChoices
//                                                          attribute: NSLayoutAttributeCenterX
//                                                          relatedBy: NSLayoutRelationEqual
//                                                             toItem: self.view
//                                                          attribute: NSLayoutAttributeCenterX
//                                                         multiplier: 1
//                                                           constant: 0]
//     ];

    [self.view addConstraint:[NSLayoutConstraint constraintWithItem: self.drawBurgerChoices
                                                          attribute: NSLayoutAttributeCenterY
                                                          relatedBy: NSLayoutRelationEqual
                                                             toItem: self.view
                                                          attribute: NSLayoutAttributeCenterY
                                                         multiplier: 1
                                                           constant: -20]
     ];
    
//    [self.view addConstraint:[NSLayoutConstraint constraintWithItem: self.drawBurgerChoices
//                                                          attribute: NSLayoutAttributeWidth
//                                                          relatedBy: NSLayoutRelationEqual
//                                                             toItem: self.drawBurgerChoices
//                                                          attribute: NSLayoutAttributeHeight
//                                                         multiplier: 1
//                                                           constant: 0]
//     ];
//    
//    [self.view addConstraint:[NSLayoutConstraint constraintWithItem: self.drawBurgerChoices
//                                                          attribute: NSLayoutAttributeWidth
//                                                          relatedBy: NSLayoutRelationEqual
//                                                             toItem: self.view
//                                                          attribute: NSLayoutAttributeWidth
//                                                         multiplier: 0.8
//                                                           constant: 0]
//     ];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem: self.drawBurgerChoices
                                                          attribute: NSLayoutAttributeRight
                                                          relatedBy: NSLayoutRelationEqual
                                                             toItem: self.view
                                                          attribute: NSLayoutAttributeRight
                                                         multiplier: 0.9                                                           constant: 0]
     ];
}



- (void)dealloc
{
    [super dealloc];
}

@end
