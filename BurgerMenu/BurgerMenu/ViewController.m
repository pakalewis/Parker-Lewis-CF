//
//  ViewController.m
//  BurgerMenu
//
//  Created by Bradley Johnson on 11/24/14.
//  Copyright (c) 2014 Code Fellows. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (strong,nonatomic) UIViewController *greenVC;
@property (strong,nonatomic) UIViewController *currentVC;
@property (assign, nonatomic) IBOutlet UIButton *burgerButton;

@property (assign,nonatomic) NSString *myString;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.greenVC = [[self.storyboard instantiateViewControllerWithIdentifier:@"GREEN_VC"] autorelease];
    
    self.myString = [NSString stringWithFormat:@"Brad"]; // not using alloc init here, so retain is called for us
    
    [self addChildViewController:self.greenVC];
    self.greenVC.view.frame = self.view.frame;
    //[self.view addSubview:self.greenVC.view];
    [self.view insertSubview:self.greenVC.view belowSubview:self.burgerButton];
    [self.greenVC didMoveToParentViewController:self];
    
}
- (IBAction)didPressBurger:(id)sender {
    NSLog(@" %@",self.myString);
    
    [UIView animateWithDuration:0.4 animations:^{
        self.greenVC.view.frame = CGRectMake(self.view.frame.size.width * .8, 0, self.view.frame.size.width, self.view.frame.size.height);
    } completion:^(BOOL finished) {
        
    }];
}

-(void)dealloc {
    [_greenVC release];
    [_currentVC release];
    [_myString release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
