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


@property (assign, nonatomic) BOOL isOpeningDisplay;
@property (nonatomic, assign) MenuSection state;
@property (strong, nonatomic) NSArray *menuSections;
@property (nonatomic, strong) NSArray *colors;
@property (strong, nonatomic) NSArray *menuImages;
@property (strong, nonatomic) NSDictionary *viewsDictionary;
@property (strong, nonatomic) UIButton *menuButton;
@property (strong, nonatomic) UITableView *menuTableView;





@end

@implementation MenuVC



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.mealOrder = [[[MealOrder alloc] init] autorelease];
    self.view.backgroundColor = self.colors[0];
    self.isOpeningDisplay = YES;

    
    // TODO: What is the difference here?
//    self.menuSections = [[[NSArray alloc] initWithObjects:@"BURGER", @"TOPPINGS", @"SIDES", nil] autorelease];
    self.menuSections = @[@"MEAL", @"TOPPINGS", @"SIDES"];
    
    self.colors = [[[NSArray alloc] initWithObjects: UIColorFromRGB(0x2162a6), UIColorFromRGB(0x57a515), UIColorFromRGB(0xd0661e), nil] autorelease];
    
    self.menuImages = [[[NSArray alloc] initWithObjects: [UIImage imageNamed:@"burger"], [UIImage imageNamed:@"toppings"], [UIImage imageNamed:@"sides"], nil] autorelease];
    
    
    // TODO: Can I fix this so each item is initialized in its setup func and not here? How best to add to the viewsDictionary?
    self.menuButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.menuTableView = [[[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain] autorelease];
    self.containerView = [[[UIView alloc] init] autorelease];
    self.viewsDictionary = @{@"menuButton":self.menuButton,
                             @"containerView":self.containerView,
                             @"tableView":self.menuTableView};

    // Set up views
    [self setupTableView];
    [self setupContainerView];
    [self setupMenuButton];
    
    
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(mealChoiceUpdated:) name:@"NEW_MEAL_CHOICE" object:nil];
}

     
-(void) mealChoiceUpdated:(NSNotification*) notification {
    
    int check = [[notification.userInfo objectForKey:@"meal"] intValue];
    self.mealOrder.state = check;
 }




// MARK: SETUP

-(void) setupMenuButton {
    // Create menu button
//    self.menuButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.menuButton.translatesAutoresizingMaskIntoConstraints = NO;
    self.menuButton.alpha = 0;
//    self.menuButton.enabled = NO;
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
    
    [self.view addConstraints:[NSLayoutConstraint
                               constraintsWithVisualFormat:@"H:[menuButton(170)]"
                               options:NSLayoutFormatDirectionLeadingToTrailing
                               metrics:nil
                               views:self.viewsDictionary]];
    
    [self.view addConstraints:[NSLayoutConstraint
                               constraintsWithVisualFormat:@"V:[menuButton(50)]"
                               options:NSLayoutFormatDirectionLeadingToTrailing
                               metrics:nil
                               views:self.viewsDictionary]];
    
    [self.view addConstraints:[NSLayoutConstraint
                               constraintsWithVisualFormat:@"V:[menuButton]-10-|"
                               options:NSLayoutFormatDirectionLeadingToTrailing
                               metrics:nil
                               views:self.viewsDictionary]];

    
}





-(void) setupTableView {
    // Table view set up
//    self.menuTableView = [[[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain] autorelease];
    self.menuTableView.translatesAutoresizingMaskIntoConstraints = NO;
    self.menuTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.menuTableView];
    self.menuTableView.delegate = self;
    self.menuTableView.scrollEnabled = NO;
    self.menuTableView.dataSource = self;
    UINib *nib = [UINib nibWithNibName:@"MenuCell" bundle: nil];
    [self.menuTableView registerNib: nib forCellReuseIdentifier:@"CELL"];
    
    // Tableview constraints
    [self.view addConstraints:[NSLayoutConstraint
                               constraintsWithVisualFormat:@"V:|-0-[tableView]-0-|"
                               options:NSLayoutFormatDirectionLeadingToTrailing
                               metrics:nil
                               views:self.viewsDictionary]];
    
    [self.view addConstraints:[NSLayoutConstraint
                               constraintsWithVisualFormat:@"H:|-0-[tableView]-0-|"
                               options:NSLayoutFormatDirectionLeadingToTrailing
                               metrics:nil
                               views:self.viewsDictionary]];
    
    
    
}


-(void) setupContainerView {
    // Make container view
//    self.containerView = [[[UIView alloc] init] autorelease];
    self.containerView.translatesAutoresizingMaskIntoConstraints = NO;
    self.containerView.alpha = 0;
    self.containerView.frame = CGRectMake(self.view.frame.size.width, 0, self.menuTableView.frame.size.width, self.menuTableView.frame.size.height);
    [self.view addSubview:self.containerView];
    
    
    // Container constraints
    [self.view addConstraints:[NSLayoutConstraint
                               constraintsWithVisualFormat:@"V:|-0-[containerView]-0-|"
                               options:NSLayoutFormatDirectionLeadingToTrailing
                               metrics:nil
                               views:self.viewsDictionary]];
    
    [self.view addConstraints:[NSLayoutConstraint
                               constraintsWithVisualFormat:@"H:|-0-[containerView]-0-|"
                               options:NSLayoutFormatDirectionLeadingToTrailing
                               metrics:nil
                               views:self.viewsDictionary]];
    
    
    // Initialize three detail VCs
    self.mealChoiceVC = [[[MealChoiceVC alloc] init] autorelease];
    self.mealChoiceVC.view.backgroundColor = self.colors[0];
    self.toppingsVC = [[[ToppingsVC alloc] init] autorelease];
    self.toppingsVC.view.backgroundColor = self.colors[1];
    self.sidesVC = [[[SidesVC alloc] initWithNibName:@"SidesVC" bundle:nil] autorelease];
    self.sidesVC.view.backgroundColor = self.colors[2];

    // Add as child View Controllers
    [self addChildViewController: self.mealChoiceVC];
    [self addChildViewController: self.toppingsVC];
    [self addChildViewController: self.sidesVC];
    
    // Add three detail VCs to the containerview
    [self.containerView addSubview:self.mealChoiceVC.view];
    self.mealChoiceVC.view.frame = self.containerView.bounds;
    [self.containerView addSubview:self.toppingsVC.view];
    self.toppingsVC.view.frame = self.containerView.bounds;
    [self.containerView addSubview:self.sidesVC.view];
    self.sidesVC.view.frame = self.containerView.bounds;
    
    [self.mealChoiceVC didMoveToParentViewController: self];
    [self.toppingsVC didMoveToParentViewController: self];
    [self.sidesVC didMoveToParentViewController: self];
    

}









// MARK: TABLEVIEW METHODS
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.view.frame.size.height / 3;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
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
    
    
    if (indexPath.row == self.state && !self.isOpeningDisplay) {
        NSLog(@"Selection is already loaded so just slide back in");


        [UIView animateWithDuration:0.7 animations:^{
            
            self.containerView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
            self.menuButton.frame = CGRectMake((self.view.frame.size.width / 2) - (self.menuButton.frame.size.width / 2), self.menuButton.frame.origin.y, self.menuButton.frame.size.width, self.menuButton.frame.size.height);
        }];
        self.mealChoiceVC.singleTapGestureRecognizer.enabled = YES;
        return;
    }

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
    self.isOpeningDisplay = NO;
    
}



// MARK: ANIMATIONS
- (IBAction)didPressMenuButton:(id)sender {
    
    self.mealChoiceVC.singleTapGestureRecognizer.enabled = NO;
    [UIView animateWithDuration:0.7 animations:^{
        // Slide off menu button
        self.menuButton.frame = CGRectMake(self.view.frame.size.width, self.menuButton.frame.origin.y, self.menuButton.frame.size.width, self.menuButton.frame.size.height);
        
        // Slide over container view
        self.containerView.frame = CGRectMake(self.view.frame.size.width * 0.4, 0, self.view.frame.size.width, self.view.frame.size.height);
        
    }];
}






-(void)animateToDetailLayout {

    [UIView animateWithDuration:0.6 delay:0.0 options:0 animations:^{

        // Move both off screen
        self.menuButton.frame = CGRectMake(self.view.frame.size.width, self.menuButton.frame.origin.y, self.menuButton.frame.size.width, self.menuButton.frame.size.height);
        
        self.containerView.frame = CGRectMake(self.view.frame.size.width, 0, self.view.frame.size.width, self.view.frame.size.height);
    
    } completion:^(BOOL finished) {

        // Switch out the view
        [self.containerView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        switch (self.state) {
            case meat:
                [self.containerView addSubview:self.mealChoiceVC.view];
                self.mealChoiceVC.view.frame = self.containerView.bounds;
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
        
        // this only makes a difference the first time they are being shown
        self.menuButton.alpha = 1;
        self.containerView.alpha = 1;

        
        self.mealChoiceVC.singleTapGestureRecognizer.enabled = YES;

        
        
        [UIView animateWithDuration:0.7 animations:^{

            self.containerView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
            self.menuButton.frame = CGRectMake((self.view.frame.size.width / 2) - (self.menuButton.frame.size.width / 2), self.menuButton.frame.origin.y, self.menuButton.frame.size.width, self.menuButton.frame.size.height);
        }];
    }];
    
}







// Limit app to portrait only
-(BOOL)shouldAutorotate {
    return NO;
}

- (NSUInteger)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}


- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [_mealChoiceVC release];
    [_colors release];
    [_toppingsVC release];
    [_sidesVC release];
    [_containerView release];
    [super dealloc];
}




@end
