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
@property (strong, nonatomic) UITableView *menuTableView;





@end

@implementation MenuVC



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.mealOrder = [[[MealOrder alloc] init] autorelease];
    
    self.view.backgroundColor = self.colors[0];

    // cancel all constraints
//    [NSLayoutConstraint deactivateConstraints:self.view.constraints];

    
    self.isMenuShown = YES;
    self.menuSections = [[[NSArray alloc] initWithObjects:@"BURGER", @"TOPPINGS", @"SIDES", nil] autorelease];
                         
    self.colors = [[[NSArray alloc] initWithObjects: UIColorFromRGB(0x2162a6), UIColorFromRGB(0x57a515), UIColorFromRGB(0xd0661e), nil] autorelease];
    
    self.menuImages = [[[NSArray alloc] initWithObjects: [UIImage imageNamed:@"burger"], [UIImage imageNamed:@"toppings"], [UIImage imageNamed:@"sides"], nil] autorelease];

    
    
    
    // Table view set up
    self.menuTableView = [[[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain] autorelease];
    self.menuTableView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.menuTableView setSeparatorInset:UIEdgeInsetsZero];
    [self.menuTableView setLayoutMargins:UIEdgeInsetsZero];
    [self.view addSubview:self.menuTableView];
    self.menuTableView.delegate = self;
    self.menuTableView.dataSource = self;
    UINib *nib = [UINib nibWithNibName:@"MenuCell" bundle: nil];
    [self.menuTableView registerNib: nib forCellReuseIdentifier:@"CELL"];

    
    
    // Make container view
    self.containerView = [[[UIView alloc] init] autorelease];
    self.containerView.translatesAutoresizingMaskIntoConstraints = NO;
    self.containerView.frame = CGRectMake(2500, 0, self.menuTableView.frame.size.width, self.menuTableView.frame.size.height);

    self.containerView.alpha = 0;
    [self.view addSubview:self.containerView];

  
    
    
    
    // Create menu button
    self.menuButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.menuButton.translatesAutoresizingMaskIntoConstraints = NO;
    self.menuButton.alpha = 0;
    self.menuButton.enabled = NO;
    self.menuButton.backgroundColor = [UIColor blueColor];
    self.menuButton.layer.cornerRadius = 15;
    [self.menuButton setTitle:@"BACK TO MENU" forState:UIControlStateNormal];
    [self.menuButton.titleLabel setFont:[UIFont boldSystemFontOfSize:20]];
    [self.menuButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.menuButton.layer setBorderColor:[[UIColor blackColor] CGColor]];
    [self.menuButton.layer setBorderWidth:4];
    [self.menuButton addTarget:self action:@selector(didPressMenuButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview: self.menuButton];

    
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem: self.menuButton
                                                          attribute: NSLayoutAttributeCenterX
                                                          relatedBy: NSLayoutRelationEqual
                                                             toItem: self.view
                                                          attribute: NSLayoutAttributeCenterX
                                                         multiplier: 1
                                                           constant: 0]
     ];
    
    

    
    
    NSDictionary *viewsDictionary = @{@"menuButton":self.menuButton,
                                      @"containerView":self.containerView,
                                      @"tableView":self.menuTableView};

    [self.view addConstraints:[NSLayoutConstraint
                               constraintsWithVisualFormat:@"H:[menuButton(170)]"
                               options:NSLayoutFormatDirectionLeadingToTrailing
                               metrics:nil
                               views:viewsDictionary]];

    [self.view addConstraints:[NSLayoutConstraint
                               constraintsWithVisualFormat:@"V:[menuButton(50)]"
                               options:NSLayoutFormatDirectionLeadingToTrailing
                               metrics:nil
                               views:viewsDictionary]];

    [self.view addConstraints:[NSLayoutConstraint
                               constraintsWithVisualFormat:@"V:[menuButton]-10-|"
                               options:NSLayoutFormatDirectionLeadingToTrailing
                               metrics:nil
                               views:viewsDictionary]];


    // Tableview constraints
    [self.view addConstraints:[NSLayoutConstraint
                               constraintsWithVisualFormat:@"V:|-0-[tableView]-0-|"
                               options:NSLayoutFormatDirectionLeadingToTrailing
                               metrics:nil
                               views:viewsDictionary]];
    
    [self.view addConstraints:[NSLayoutConstraint
                               constraintsWithVisualFormat:@"H:|-0-[tableView]-0-|"
                               options:NSLayoutFormatDirectionLeadingToTrailing
                               metrics:nil
                               views:viewsDictionary]];
    
    
    
    
    // Container constraints
    [self.view addConstraints:[NSLayoutConstraint
                               constraintsWithVisualFormat:@"V:|-0-[containerView]-0-|"
                               options:NSLayoutFormatDirectionLeadingToTrailing
                               metrics:nil
                               views:viewsDictionary]];
    
    [self.view addConstraints:[NSLayoutConstraint
                               constraintsWithVisualFormat:@"H:|-0-[containerView]-0-|"
                               options:NSLayoutFormatDirectionLeadingToTrailing
                               metrics:nil
                               views:viewsDictionary]];
    
    
    
    
    
    
    
    
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

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return nil;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MenuCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL"];
    cell.contentView.backgroundColor = self.colors[indexPath.row];
    cell.clipsToBounds = NO;
    cell.menuCellImage.image = self.menuImages[indexPath.row];
    cell.menuLabel.text = self.menuSections[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%lu", indexPath.row);
    if (indexPath.row == 0) {
        self.state = meat;
        self.view.backgroundColor = self.colors[0];
        self.menuButton.backgroundColor = self.colors[0];
    } else if (indexPath.row == 1) {
        self.state = toppings;
        self.view.backgroundColor = self.colors[1];
        self.menuButton.backgroundColor = self.colors[1];
    } else {
        self.state = sides;
        self.view.backgroundColor = self.colors[2];
        self.menuButton.backgroundColor = self.colors[2];
    }

    [self animateToDetailLayout];
}




// MARK: ANIMATIONS

-(void)animateToMenuLayout {
    
    self.isMenuShown = YES;
    self.menuButton.enabled = NO;
    
    [UIView animateWithDuration:1.5 animations:^{
        // Slide off menu button
        self.menuButton.frame = CGRectMake(2500, self.menuButton.frame.origin.y, self.menuButton.frame.size.width, self.menuButton.frame.size.height);
        
        // Slide over container view
        self.containerView.frame = CGRectMake(2500, 0, self.view.frame.size.width, self.view.frame.size.height);
        
    } completion:^(BOOL finished) {
        
        self.menuButton.alpha = 0;
        self.containerView.alpha = 0;
    }];
}




-(void)animateToDetailLayout {
    
    
    self.isMenuShown = NO;
    self.menuButton.frame = CGRectMake(2500, self.menuButton.frame.origin.y, self.menuButton.frame.size.width, self.menuButton.frame.size.height);
    self.menuButton.alpha = 1;
    self.menuButton.enabled = YES;
    self.containerView.frame = CGRectMake(2500, 0, self.view.frame.size.width, self.view.frame.size.height);
    self.containerView.alpha = 1;

    
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

    

    [UIView animateWithDuration:1.0 delay:0.0 options:0 animations:^{

        self.containerView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
        self.menuButton.frame = CGRectMake((self.view.frame.size.width / 2) - (self.menuButton.frame.size.width / 2), self.menuButton.frame.origin.y, self.menuButton.frame.size.width, self.menuButton.frame.size.height);
    } completion:nil];

    
    
}



// This detects when rotating device
-(void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {

        if (self.isMenuShown) {
            
//            [self animateToMenuLayout];
        } else {

//            [self animateToDetailLayout];
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
