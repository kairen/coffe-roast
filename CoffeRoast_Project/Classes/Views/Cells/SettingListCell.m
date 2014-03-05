//
//  SettingListCell.m
//  CoffeRoast_Project
//
//  Created by Bai-Kai-Ren on 2014/2/24.
//  Copyright (c) 2014年 Bai-Kai-Ren. All rights reserved.
//

#import "SettingListCell.h"
#import "BaseView.h"

static CGFloat const TableViewHeight = 100;

@implementation SettingListCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(150, (TableViewHeight / 2) - 25, 300,50)];
        self.titleLabel.textColor = [UIColor whiteColor];
        self.titleLabel.textAlignment = NSTextAlignmentLeft;
        self.titleLabel.font = [UIFont boldSystemFontOfSize:34];
        
        [self addSubview:self.titleLabel];
        
        self.titleField = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.titleLabel.frame) + 20, CGRectGetMinY(self.titleLabel.frame), 200 , CGRectGetHeight(self.titleLabel.frame))];
        self.titleField.textColor = [UIColor whiteColor];
        self.titleField.font = [UIFont boldSystemFontOfSize:20];
        self.titleField.background = [UIImage imageNamed:@"Setting_input.png"];
        [self addSubview:self.titleField];
        
        self.separatorView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Plotting_hr.png"]];
        self.separatorView.frame = CGRectMake(0, TableViewHeight - self.separatorView.image.size.height , 1024, self.separatorView.image.size.height);
        
        [self addSubview:self.separatorView];
    }
    return self;
}

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if(self.touchBeganAction) {
        self.touchBeganAction();
    }
}


@end
