//
//  SettingView.m
//  CoffeRoast_Project
//
//  Created by Bai-Kai-Ren on 2013/12/30.
//  Copyright (c) 2013年 Bai-Kai-Ren. All rights reserved.
//

#import "SettingView.h"

@implementation SettingView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setTitle:@"Setting" logoImage:@"setting_logo.png"];
        [self setLeftBarItemImage:@"Back"];
        
        self.ipAddressView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"IPAdress.png"]];
        self.ipAddressView.frame = CGRectMake(150, CGRectGetMaxY(self.titleBar.frame) + 30, 200,50);
        [self addSubview:self.ipAddressView];
        
        self.ipAddressField = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.ipAddressView.frame) + 20, CGRectGetMinY(self.ipAddressView.frame), CGRectGetWidth(self.ipAddressView.frame), CGRectGetHeight(self.ipAddressView.frame))];
        self.ipAddressField.textColor = [UIColor whiteColor];
        self.ipAddressField.font = [UIFont boldSystemFontOfSize:20];
        self.ipAddressField.background = [UIImage imageNamed:@"Setting_input.png"];
        [self addSubview:self.ipAddressField];
        
        [self addSeparationLineBottomIn:self.ipAddressView];
        
        self.ipPortView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"IPPort.png"]];
        self.ipPortView.frame = CGRectMake(150, CGRectGetMaxY(self.ipAddressView.frame) + 63, 200, 50);
        [self addSubview:self.ipPortView];
        
        self.ipPortField = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.ipPortView.frame) + 20, CGRectGetMinY(self.ipPortView.frame), CGRectGetWidth(self.ipPortView.frame), CGRectGetHeight(self.ipPortView.frame))];
        self.ipPortField.textColor = [UIColor whiteColor];
        self.ipPortField.font = [UIFont boldSystemFontOfSize:20];
        self.ipPortField.background = [UIImage imageNamed:@"Setting_input.png"];
        [self addSubview:self.ipPortField];
        
        [self addSeparationLineBottomIn:self.ipPortField];
    }
    return self;
}

-(void) addSeparationLineBottomIn:(UIView*)view
{
    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Plotting_hr.png"]];
    imageView.frame = CGRectMake(0, CGRectGetMaxY(view.frame) + 30, CGRectGetWidth(self.frame), imageView.image.size.height);
    [self addSubview:imageView];
}


@end
