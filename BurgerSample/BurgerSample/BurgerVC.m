//
//  BurgerVC.m
//  BurgerSample
//
//  Created by Parker Lewis on 11/24/14.
//  Copyright (c) 2014 CodeFellows. All rights reserved.
//

#import "BurgerVC.h"

@interface BurgerVC ()

@end

@implementation BurgerVC

- (void)viewDidLoad {
    [super viewDidLoad];

    DrawView *drawView = [[[DrawView alloc] initWithFrame:CGRectMake(self.view.frame.size.width * 0.1, self.view.frame.size.height * 0.4, self.view.frame.size.width * 0.8, self.view.frame.size.width * 0.8)] autorelease];
//    drawView.backgroundColor = [UIColor clearColor];
    drawView.backgroundColor = [UIColor blueColor];
    
    UILabel *burgerLabel = [[[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width * 0.25, self.view.frame.size.height * 0.1, self.view.frame.size.width * 0.5, 30)] autorelease];
    burgerLabel.text = @"BURGER";
    burgerLabel.backgroundColor = [UIColor greenColor];
    burgerLabel.textAlignment = NSTextAlignmentCenter;
    burgerLabel.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin);

    
    [self.view addSubview:burgerLabel];
    [self.view addSubview:drawView];

}






- (void)dealloc
{
    [super dealloc];
}

@end
