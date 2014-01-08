//
//  SelectFIleCell.m
//  CoffeRoast_Project
//
//  Created by Bai-Kai-Ren on 2013/12/19.
//  Copyright (c) 2013年 Bai-Kai-Ren. All rights reserved.
//

#import "SelectFileCell.h"

@implementation SelectFileCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.opaque = YES;
        self.isLoading = NO;
        
        self.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"SelectBox.png"]];
        self.textLabel.textColor = [UIColor colorWithRed:0.4 green:0.14901961 blue:0.16470588 alpha:1];
        self.textLabel.font = [UIFont boldSystemFontOfSize:36];
        self.imageView.image = [UIImage imageNamed:@"FileSign.png"];
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    return self;
}
@end
