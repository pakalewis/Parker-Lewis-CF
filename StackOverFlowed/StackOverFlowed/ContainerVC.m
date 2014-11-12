//
//  ContainerVC.m
//  StackOverFlowed
//
//  Created by Parker Lewis on 11/12/14.
//  Copyright (c) 2014 CodeFellows. All rights reserved.
//

#import "ContainerVC.h"

@interface ContainerVC ()

@end

@implementation ContainerVC 

- (void)viewDidLoad {
    [super viewDidLoad];

    UISplitViewController *splitVC = self.childViewControllers[0];
    splitVC.delegate = self;

}

// Instead of using the extra container VC, the AppDelegate could be used instead.
// Make it conform to the UISplitViewControllerDelegate protocol and then add this method in the AppDelegate.m file

- (BOOL)splitViewController:(UISplitViewController *)splitViewController collapseSecondaryViewController:(UIViewController *)secondaryViewController ontoPrimaryViewController:(UIViewController *)primaryViewController {
    return true;
}

@end
