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
        ;
        self.layer.contents = (id)[UIImage imageNamed:@"background.png"].CGImage;
        self.opaque = YES;
        self.titleBar = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 60)];
        [self.titleBar setImage:[UIImage loadFileImageName:@"TitleBar.png"]];
        [self addSubview:self.titleBar];
        
        self.bottomBar = [[UIImageView alloc]initWithFrame:CGRectMake(0, self.frame.size.height - 60, self.frame.size.width, 60)];
        self.bottomBar.userInteractionEnabled = YES;
        [self.bottomBar setImage:[UIImage loadFileImageName:@"Footer.png"]];
        [self addSubview:self.bottomBar];
    }
    return self;
}

-(void) setListView:(UITableView *)listView
{
    _listView = listView;
    _listView.backgroundColor = [UIColor clearColor];
    _listView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _listView.showsHorizontalScrollIndicator = NO;
    _listView.showsVerticalScrollIndicator = NO;
    _listView.opaque = YES;
    _listView.alpha = 1.0;
    [self addSubview:_listView];
}

#pragma mark - TitleBar Image Setting Method
-(void) setTitle:(NSString*)title logoImage:(NSString*)imageName
{
    if(self.titleLabel == nil) {
        self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake((CGRectGetWidth(self.titleBar.frame) / 2) - (LabelWidth / 2) + LogoWidth, (CGRectGetHeight(self.titleBar.frame) / 2) - (LabelHeight / 2), LabelWidth, LabelHeight)];
        self.titleLabel.text = title;
        self.titleLabel.backgroundColor = [UIColor clearColor];
        self.titleLabel.textColor = [UIColor whiteColor];
        self.titleLabel.textAlignment = NSTextAlignmentLeft;
        self.titleLabel.font = [UIFont boldSystemFontOfSize:30];
        self.titleLabel.adjustsFontSizeToFitWidth = YES;
        [self.titleBar addSubview:self.titleLabel];
        
        self.logoImage = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.titleLabel.frame) - LogoWidth , (CGRectGetHeight(self.titleBar.frame) / 2) - (LogoHeight / 2), LogoWidth, LogoHeight)];
        self.logoImage.image = [UIImage imageNamed:imageName];
        [self.titleBar addSubview:self.logoImage];
    }
}

-(void) showSeparationView
{
    self.controlView = [[UIImageView alloc]initWithImage:[UIImage loadFileImageName:@"information_bg.png"]];
    self.controlView.frame = CGRectMake(0, CGRectGetHeight(self.titleBar.frame),self.controlView.image.size.width, self.controlView.image.size.height);
    self.controlView.userInteractionEnabled = YES;
    
    [self addSubview:self.controlView];
    
    self.plittingHRView = [[UIImageView alloc]initWithImage:[UIImage loadFileImageName:@"Plotting_hr.png"]];
    self.plittingHRView.frame = CGRectMake(CGRectGetWidth(self.controlView.frame) + 100 , (self.frame.size.height / 2) - 1, self.plittingHRView.image.size.width, self.plittingHRView.image.size.height);
    
    [self addSubview:self.plittingHRView];
}

#pragma mark - Navigation Left BarItem Image Setting Method
-(void) setLeftBarItemImage:(NSString*)image
{
    if(self.leftButton == nil) {
        self.leftButton = [[UIButton alloc]init];
    }
    [self addButton:self.leftButton imageName:image direction:LeftDirection];
}

-(void) setMiddleBarItemImage:(NSString*)image
{
    if(self.midButton == nil) {
        self.midButton = [[UIButton alloc]init];
    }
    [self addButton:self.midButton imageName:image direction:MiddleDirection];
}

-(void) setRightBarItemImage:(NSString*)image
{
    if(self.rightButton == nil) {
        self.rightButton = [[UIButton alloc]init];
    }
    [self addButton:self.rightButton imageName:image direction:RightDirection];
}

-(void) addButton:(UIButton*)btn  imageName:(NSString*)iName direction:(BottomDirection)direction
{
    UIImage *image = [UIImage loadFileImageName:[NSString stringWithFormat:@"%@.png",iName]];
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
    [btn setBackgroundImage:[UIImage loadFileImageName:[NSString stringWithFormat:@"%@_s2.png",iName]] forState:UIControlStateHighlighted];
    [self.bottomBar addSubview:btn];
    btn.alpha = 0.0;
    [UIView animateWithDuration:0.5 animations:^{
        btn.alpha = 1.0;
    }];
    image = nil;
}

#pragma mark - addTempLineView
-(void) addTempLineView
{
    if(!self.tempView) {
        self.temperaturBgView = [[UIImageView alloc]initWithImage:[UIImage loadFileImageName:@"Temperature_bg.png"]];
        self.temperaturBgView.frame = CGRectMake(CGRectGetMaxX(self.controlView.frame) + 30, CGRectGetMaxY(self.titleBar.frame) + 10, 569, 300);
        self.temperaturBgView.userInteractionEnabled = YES;
        self. temperaturBgView.alpha = 0.0;
        self.tempView = [[TempChartView alloc] initWithFrame:CGRectMake(0,0, 569, 284)];
        self.tempView.lineColor = [UIColor colorWithRed:1.0 green:51/255.0 blue:51/255.0 alpha:1.0];
        [self.tempView setMaximumValue:255 MinimumValue:0];
        
        [self.temperaturBgView addSubview:self.tempView];
        [self addSubview:self.temperaturBgView];
    }
}

#pragma mark - addRollerLineView
-(void) addRollerLineView
{
    if(!self.rollerView) {
        self.rollerBgView = [[UIImageView alloc]initWithImage:[UIImage loadFileImageName:@"Roller&Wind_bg.png"]];
        self.rollerBgView.frame = CGRectMake(CGRectGetMaxX(self.controlView.frame) + 30, CGRectGetMaxY(self.plittingHRView.frame) + 10, 569, 300);
        self.rollerBgView.userInteractionEnabled = YES;
        self.rollerBgView.alpha = 0.0;
        
        self.rollerView = [[RollerChartView alloc] initWithFrame:CGRectMake(0,0, 569, 284)];
        self.rollerView.lineColor = [UIColor colorWithRed:0.91764706 green:0.75686275 blue:0 alpha:1.0];
        [self.rollerView setMaximumValue:200 MinimumValue:0];
        [self.rollerView drawTwoYLabelWithMaxValue:10];
        
        [self.rollerBgView addSubview:self.rollerView];
        [self addSubview:self.rollerBgView];
    }
}

#pragma mark - Start Animation
-(void) StartListViewAnimation
{
    __weak typeof(self) weakSelf = self;
    [BasicAnimation popAnimationFor:weakSelf.listView complete:nil];
}

-(void) StartChartViewAnimation
{
     __weak typeof(self) weakSelf = self;
    [BasicAnimation popAnimationFor:weakSelf.temperaturBgView complete:^{
        [BasicAnimation popAnimationFor:weakSelf.rollerBgView complete:nil];
    }];
}

@end

@implementation UITextField (other)
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-protocol-method-implementation"

- (CGRect) textRectForBounds:(CGRect)bounds
{
    return CGRectInset(bounds, 12, -2);
}

- (CGRect) editingRectForBounds:(CGRect)bounds
{
    return CGRectInset(bounds, 12, -2);
}

#pragma clang diagnostic pop

@end
