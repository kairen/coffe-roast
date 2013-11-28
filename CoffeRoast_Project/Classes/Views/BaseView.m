//
//  BaseView.m
//  CoffeRoast_Project
//
//  Created by Bai-Kai-Ren on 2013/11/28.
//  Copyright (c) 2013年 Bai-Kai-Ren. All rights reserved.
//

#import "BaseView.h"

static CGFloat const LabelWidth = 200;
static CGFloat const LabelHeight = 50;

static CGFloat const LogoWidth = 50;
static CGFloat const LogoHeight = 50;

@implementation BaseView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.contents = (id)[UIImage imageNamed:@"background.png"].CGImage;
        
        self.titleBar = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.height, 60)];
        [self.titleBar setImage:[UIImage imageNamed:@"TitleBar.png"]];
        [self addSubview:self.titleBar];
        
        self.bottomBar = [[UIImageView alloc]initWithFrame:CGRectMake(0, self.frame.size.width - 60, self.frame.size.height, 60)];
        self.bottomBar.userInteractionEnabled = YES;
        [self.bottomBar setImage:[UIImage imageNamed:@"Footer.png"]];
        [self addSubview:self.bottomBar];
    }
    return self;
}

#pragma mark - TitleBar Image Setting Method
-(void) setTitle:(NSString*)title logoImage:(NSString*)imageName
{
    if(self.titleLabel == nil) {
        self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake((CGRectGetWidth(self.titleBar.frame) / 2) - (LabelWidth / 2), (CGRectGetHeight(self.titleBar.frame) / 2) - (LabelHeight / 2), LabelWidth, LabelHeight)];
        self.titleLabel.text = title;
        self.titleLabel.backgroundColor = [UIColor clearColor];
        self.titleLabel.textColor = [UIColor whiteColor];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont boldSystemFontOfSize:40];
        self.titleLabel.adjustsFontSizeToFitWidth = YES;
        [self.titleBar addSubview:self.titleLabel];
        
        self.logoImage = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.titleLabel.frame) - LogoWidth , (CGRectGetHeight(self.titleBar.frame) / 2) - (LogoHeight / 2), LogoWidth, LogoHeight)];
        self.logoImage.image = [UIImage imageNamed:imageName];
        [self.titleBar addSubview:self.logoImage];
    }
}

#pragma mark - Navigation Left BarItem Image Setting Method
-(void) setLeftBarItemImage:(NSString*)image
{
    if(self.leftBtn == nil) {
        self.leftBtn = [[UIButton alloc]init];
    }
    [self addButton:self.leftBtn imageName:image direction:LeftDirection];
}

-(void) setMiddleBarItemImage:(NSString*)image
{
    if(self.midBtn == nil) {
        self.midBtn = [[UIButton alloc]init];
    }
    [self addButton:self.midBtn imageName:image direction:MiddleDirection];
}

-(void) setRightBarItemImage:(NSString*)image
{
    if(self.rightBtn == nil) {
        self.rightBtn = [[UIButton alloc]init];
    }
    [self addButton:self.rightBtn imageName:image direction:RightDirection];
}

-(void) addButton:(UIButton*)btn  imageName:(NSString*)iName direction:(BottomDirection)direction
{
    UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png",iName]];
    CGFloat x;
    switch (direction) {
        case LeftDirection:
            x = 20;
            break;
        case MiddleDirection:
            x = (self.bottomBar.frame.size.width / 2 ) - (image.size.width / 2);
            break;
        case RightDirection:
            x = self.bottomBar.frame.size.width - 20 - image.size.width;
            break;
    }
    btn.frame = CGRectMake(x, (self.bottomBar.frame.size.height / 2) - (image.size.height / 2), image.size.width, image.size.height);
    [btn setBackgroundImage:image forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@_s2.png",iName]] forState:UIControlStateHighlighted];
    [self.bottomBar addSubview:btn];
    image = nil;
}

-(void) dealloc
{
    self.rightBtn = nil;
    self.leftBtn = nil;
    self.midBtn = nil;
    self.bottomBar = nil;
    self.titleBar = nil;
    self.titleLabel = nil;
    self.logoImage = nil;
}

@end
