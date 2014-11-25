//
//  MenuVC.m
//  BurgerSample
//
//  Created by Parker Lewis on 11/24/14.
//  Copyright (c) 2014 CodeFellows. All rights reserved.
//

#import "MenuVC.h"
#import "MenuCell.h"

@interface MenuVC ()

@property (assign, nonatomic) BOOL isMenuShown;
@property (strong, nonatomic) NSArray *menuSections;

@end

@implementation MenuVC



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.isMenuShown = YES;
    self.menuSections = @[@"MEAT", @"TOPPINGS", @"SIDES"];
    
    
    self.menuTableView.delegate = self;
    self.menuTableView.dataSource = self;
    UINib *nib = [UINib nibWithNibName:@"MenuCell" bundle: nil];
    [self.menuTableView registerNib: nib forCellReuseIdentifier:@"CELL"];
    
    self.toppingsVC = [[self.storyboard instantiateViewControllerWithIdentifier:@"TOPPINGS_VC"] autorelease];
    self.sidesVC = [[self.storyboard instantiateViewControllerWithIdentifier:@"SIDES_VC"] autorelease];
    
    [self addChildViewController: self.toppingsVC];
    [self addChildViewController: self.sidesVC];

    
    self.containerView = [[UIView alloc] init];
    self.containerView.frame = CGRectMake(self.view.frame.size.width / 2, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height);
    [self.view insertSubview:self.containerView belowSubview:self.menuButton];
    
    
    [self.containerView addSubview:self.toppingsVC.view];
    self.toppingsVC.view.frame = self.containerView.bounds;

    [self.containerView addSubview:self.sidesVC.view];
    self.sidesVC.view.frame = self.containerView.bounds;

    
    
    [self.toppingsVC didMoveToParentViewController: self];
    [self.sidesVC didMoveToParentViewController: self];
    
    
    
}




- (IBAction)didPressMenuButton:(id)sender {


    self.isMenuShown = YES;
    
    [UIView animateWithDuration:0.5 animations:^{
        self.containerView.frame = CGRectMake(self.view.frame.size.width / 2, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height);
    }];
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.view.frame.size.height / self.menuSections.count;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.menuSections.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MenuCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL"];

    cell.menuLabel.text = self.menuSections[indexPath.row];    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    self.isMenuShown = NO;
    
    [UIView animateWithDuration:0.5 animations:^{
        self.containerView.frame = CGRectMake(self.view.frame.size.width, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height);

    } completion:^(BOOL finished) {
        
        [self.containerView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        if (indexPath.row == 0) {
            [self.containerView addSubview:self.toppingsVC.view];
            self.toppingsVC.view.frame = self.containerView.bounds;
        } else {
            [self.containerView addSubview:self.sidesVC.view];
            self.sidesVC.view.frame = self.containerView.bounds;
        }
        
        [UIView animateWithDuration:0.5 animations:^{
            self.containerView.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height);
        }];
    }];
}



-(void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {

    
//    [UIView animateWithDuration:0.01 animations:^{
        if (self.isMenuShown) {
            self.containerView.frame = CGRectMake(size.width / 2, 0, size.width, size.height);
        } else {
            self.containerView.frame = CGRectMake(0, 0, size.width, size.height);
        }
//    }];

}



- (void)dealloc
{
    [_toppingsVC release];
    [_sidesVC release];
    [super dealloc];
}




@end
