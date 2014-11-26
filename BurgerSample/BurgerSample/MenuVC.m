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

typedef enum {
    meat,
    toppings,
    sides
} MenuSection;


@property (assign, nonatomic) BOOL isMenuShown;
@property (nonatomic, assign) MenuSection state;
@property (strong, nonatomic) NSArray *menuSections;
@property (nonatomic, strong) NSArray *colors;
@property (strong, nonatomic) NSArray *menuImages;
@property (strong, nonatomic) UIButton *menuButton;





@end

@implementation MenuVC



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.isMenuShown = YES;
    self.menuSections = [[[NSArray alloc] initWithObjects:@"BURGER", @"TOPPINGS", @"SIDES", nil] autorelease];
                         
    self.colors = [[[NSArray alloc] initWithObjects: UIColorFromRGB(0x2162a6), UIColorFromRGB(0x57a515), UIColorFromRGB(0xd0661e), nil] autorelease];
    
    self.menuImages = [[[NSArray alloc] initWithObjects: [UIImage imageNamed:@"burger"], [UIImage imageNamed:@"toppings"], [UIImage imageNamed:@"sides"], nil] autorelease];

  
    // Create menu button
    // TODO: add constraints programmatically
    self.menuButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.menuButton.backgroundColor = [UIColor blueColor];
    CGRect buttonFrame = CGRectMake(self.view.frame.size.width, CGRectGetMaxY(self.view.frame) - 40, 90, 30);
    [self.menuButton setFrame: buttonFrame];
    [self.menuButton setTitle:@"MENU" forState:UIControlStateNormal];

    
    [self.menuButton addTarget:self action:@selector(didPressMenuButton:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview: self.menuButton];
    
    self.view.backgroundColor = self.colors[0];
    
    
    // Table view set up
    self.menuTableView.delegate = self;
    self.menuTableView.dataSource = self;
    UINib *nib = [UINib nibWithNibName:@"MenuCell" bundle: nil];
    [self.menuTableView registerNib: nib forCellReuseIdentifier:@"CELL"];
    
    
    // Initialize three detail VCs
    self.burgerVC = [[[BurgerVC alloc] init] autorelease];
    self.burgerVC.view.backgroundColor = self.colors[0];
    self.toppingsVC = [[[ToppingsVC alloc] initWithNibName:@"ToppingsVC" bundle:nil] autorelease];
    self.toppingsVC.view.backgroundColor = self.colors[1];
    self.sidesVC = [[[SidesVC alloc] initWithNibName:@"SidesVC" bundle:nil] autorelease];
    self.sidesVC.view.backgroundColor = self.colors[2];
    
    
    [self addChildViewController: self.burgerVC];
    [self addChildViewController: self.toppingsVC];
    [self addChildViewController: self.sidesVC];

    // Make container view
    self.containerView = [[[UIView alloc] init] autorelease];
    self.containerView.frame = CGRectMake(self.view.frame.size.width, 0, self.view.frame.size.width, self.view.frame.size.height);
    [self.view insertSubview:self.containerView belowSubview: self.menuButton];
    
    
    // Add three detail VCs to the containerview
    [self.containerView addSubview:self.burgerVC.view];
    self.burgerVC.view.frame = self.containerView.bounds;
    [self.containerView addSubview:self.toppingsVC.view];
    self.toppingsVC.view.frame = self.containerView.bounds;
    [self.containerView addSubview:self.sidesVC.view];
    self.sidesVC.view.frame = self.containerView.bounds;

    
    
    [self.burgerVC didMoveToParentViewController: self];
    [self.toppingsVC didMoveToParentViewController: self];
    [self.sidesVC didMoveToParentViewController: self];
    
    
    
}




- (IBAction)didPressMenuButton:(id)sender {


    [self animateToMenuLayout];
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.view.frame.size.height / 3;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MenuCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL"];
    cell.contentView.backgroundColor = self.colors[indexPath.row];
    cell.menuCellImage.image = self.menuImages[indexPath.row];
    cell.menuLabel.text = self.menuSections[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
            self.state = meat;
            self.view.backgroundColor = self.colors[0];
    } else if (indexPath.row == 1) {
            self.state = toppings;
            self.view.backgroundColor = self.colors[1];
    } else {
            self.state = sides;
            self.view.backgroundColor = self.colors[2];
    }
    
    [self animateToDetailLayout];

    
    
}



-(void)animateToMenuLayout {
    
    
    self.isMenuShown = YES;
    
    [UIView animateWithDuration:0.5 delay:0.2 usingSpringWithDamping:2.8 initialSpringVelocity:0.2 options:0 animations:^{

        // Slide off menu button
        self.menuButton.frame = CGRectMake(self.view.frame.size.width, self.menuButton.frame.origin.y, self.menuButton.frame.size.width, self.menuButton.frame.size.height);
        
        // Slide over container view
        self.containerView.frame = CGRectMake(self.view.frame.size.width, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height);

    } completion:^(BOOL finished) {
        
        
    }];

    


    
}




-(void)animateToDetailLayout {
    
    
    self.isMenuShown = NO;

    // Slide over the container view first
    [UIView animateWithDuration:0.5 delay:0.4 usingSpringWithDamping:0.8 initialSpringVelocity:0.2 options:0 animations:^{
        
//        self.containerView.frame = CGRectMake(self.view.frame.size.width, 0, self.view.frame.size.width, self.view.frame.size.height);

        
    } completion:^(BOOL finished) {
        [self.containerView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        switch (self.state) {
            case meat:
                [self.containerView addSubview:self.burgerVC.view];
                self.burgerVC.view.frame = self.containerView.bounds;
                break;
            case toppings:
                [self.containerView addSubview:self.toppingsVC.view];
                self.toppingsVC.view.frame = self.containerView.bounds;
                break;
            case sides:
                [self.containerView addSubview:self.sidesVC.view];
                self.sidesVC.view.frame = self.containerView.bounds;
                break;
        }
        
        
        [UIView animateWithDuration:0.5 animations:^{

            
            
            self.containerView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
            self.menuButton.frame = CGRectMake((self.view.frame.size.width / 2) - (self.menuButton.frame.size.width / 2), self.menuButton.frame.origin.y, self.menuButton.frame.size.width, self.menuButton.frame.size.height);
        }];

        
    }];

  
    
    
}

// This detects when rotating device
-(void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {

        if (self.isMenuShown) {
            [self animateToMenuLayout];
        } else {
            [self animateToDetailLayout];
        }

}






- (void)dealloc
{
    [_burgerVC release];
    [_colors release];
    [_toppingsVC release];
    [_sidesVC release];
    [_containerView release];
    [super dealloc];
}




@end
