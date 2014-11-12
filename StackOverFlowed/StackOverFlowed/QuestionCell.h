//
//  QuestionCell.h
//  StackOverFlowed
//
//  Created by Parker Lewis on 11/12/14.
//  Copyright (c) 2014 CodeFellows. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QuestionCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
@property (weak, nonatomic) IBOutlet UILabel *questionLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *viewsLabel;
@property (weak, nonatomic) IBOutlet UILabel *answersLabel;


@end
