//
//  ProfileView.m
//  CoffeRoast_Project
//
//  Created by Bai-Kai-Ren on 2013/12/24.
//  Copyright (c) 2013年 Bai-Kai-Ren. All rights reserved.
//

#import "ProfileView.h"
#import "UIColor+Category.h"

@interface ProfileView()
{
    UIView *viewR;
    UIView *viewT;
}
@end

@implementation ProfileView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setTitle:@"Profile" logoImage:@"profile_logo.png"];
        [self setLeftBarItemImage:@"Back"];
        [self setMiddleBarItemImage:@"Profile_Save"];
        [self setRightBarItemImage:@"btn_Run"];
        [self showSeparationView];
        
        self.listView = [[UITableView alloc] initWithFrame: CGRectMake(0, 0, CGRectGetWidth(self.controlView.frame), CGRectGetHeight(self.controlView.frame)) style:UITableViewStylePlain];
        self.listView.alpha = 0.0;
        
        [self.controlView addSubview:self.listView];
        
        [self addTempLineView];
        [self addRollerLineView];
        
        viewT = [[UIView alloc]init];
        self.tempChBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.tempChBtn.frame = CGRectMake(5,10, 30, 20);
        [self.tempChBtn setImage:[UIImage loadFileImageName:@"change_user-256.png"] forState:UIControlStateNormal];
        viewT.frame = CGRectMake(CGRectGetMaxX(self.temperaturBgView.frame) - 25,CGRectGetMinY(self.temperaturBgView.frame) - 20, 40, 40);
        viewT.backgroundColor = [UIColor colorWithIntegerRed:215 green:215 blue:219];
        viewT.layer.cornerRadius = 20;
        [viewT addSubview:self.tempChBtn];
        [self addSubview:viewT];
        
        viewR = [[UIView alloc]init];
        
        self.rollerChBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.rollerChBtn.frame = CGRectMake(5,10, 30, 20);
        [self.rollerChBtn setImage:[UIImage loadFileImageName:@"change_user-256.png"] forState:UIControlStateNormal];
        viewR.frame = CGRectMake(CGRectGetMaxX(self.rollerBgView.frame) - 25,CGRectGetMinY(self.rollerBgView.frame) - 20, 40, 40);
        viewR.backgroundColor = [UIColor colorWithIntegerRed:215 green:215 blue:219];
        viewR.layer.cornerRadius = 20;
        [viewR addSubview:self.rollerChBtn];
        [self addSubview:viewR];
        viewR.alpha = 0.0;
        viewT.alpha = 0.0;
        
        self.tempView.canEdit = 0;
        self.rollerView.canEdit = 0;
        
        [self.tempChBtn addTarget:self action:@selector(tempChangeButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.rollerChBtn addTarget:self action:@selector(rollerChangeButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [self performSelector:@selector(StartListViewAnimation) withObject:nil afterDelay:0.8];
        [self performSelector:@selector(StartChartViewAnimation) withObject:nil afterDelay:1.2];
        [self performSelector:@selector(animationDidStart) withObject:nil afterDelay:1.4];
      
        self.tempChange  = 0;
        self.rollerChanged = 0;
    }
    return self;
}

-(void) animationDidStart
{
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.3 initialSpringVelocity:0.5 options:UIViewAnimationOptionCurveLinear animations:^{
        viewR.alpha = 1.0;
        viewT.alpha = 1.0;
    }completion:nil];
}

#pragma mark Temp Change and Roller Change  Button Action
-(void) tempChangeButtonAction:(id)sender
{
    CATransition *transition = [CATransition animation];
    transition.type = kCATransitionFade;
    transition.duration = 0.4;
    [self.tempView.layer addAnimation:transition forKey:nil];
    if(self.tempChange == 0) {
        [self.tempView sendSubviewToBack:self.tempView.krChartLine];
        [self.tempView sendSubviewToBack:self.tempView.stopView];
        [self.tempView sendSubviewToBack:self.tempView.krDashLine];
        self.tempChange = 1;
    } else if(self.tempChange == 1) {
        [self.tempView sendSubviewToBack:self.tempView.krChartLine];
        [self.tempView sendSubviewToBack:self.tempView.startView];
        [self.tempView sendSubviewToBack:self.tempView.krDashLine];
        self.tempChange = 2;
    }  else if(self.tempChange == 2){
        [self.tempView bringSubviewToFront:self.tempView.krChartLine];
        self.tempChange = 0;
    }
    self.tempView.canEdit = self.tempChange;
}

-(void) rollerChangeButtonAction:(id)sender
{
    CATransition *transition = [CATransition animation];
    transition.type = kCATransitionFade;
    transition.duration = 0.4;
    [self.rollerView.layer addAnimation:transition forKey:nil];
    if(self.rollerChanged == 0) {
        [self.rollerView sendSubviewToBack:self.rollerView.krChartLine];
        [self.rollerView sendSubviewToBack:self.rollerView.krDashLine];
        self.rollerChanged = 1;
    } else {
        [self.rollerView bringSubviewToFront:self.rollerView.krChartLine];
        self.rollerChanged = 0;
    }
    self.rollerView.canEdit = self.rollerChanged;
}
@end
