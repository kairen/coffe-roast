//
//  PopInfoView.m
//  CoffeRoast_Project
//
//  Created by Bai-Kai-Ren on 2014/2/26.
//  Copyright (c) 2014年 Bai-Kai-Ren. All rights reserved.
//

#import "PopInfoView.h"

@interface PopInfoView ()

@property(nonatomic, strong) UILabel *messageLabel;
@end

@implementation PopInfoView

+(instancetype) popInfoViewWitFrame:(CGRect)frame;
{
    return [[self alloc]initWithPopInfoViewWitFrame:frame];
}

- (id)initWithPopInfoViewWitFrame:(CGRect)frame
{
    self = [super initWithFrame:CGRectMake(0 , - CGRectGetHeight(frame),CGRectGetWidth(frame),CGRectGetHeight(frame))];
    if (self) {
        self.backgroundColor = [UIColor blackColor];
        self.alpha = 0.9;
        
        self.messageLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(frame), CGRectGetHeight(frame))];
        self.messageLabel.textAlignment = NSTextAlignmentCenter;
        self.messageLabel.backgroundColor = [UIColor clearColor];
        self.messageLabel.textColor = [UIColor whiteColor];
        self.messageLabel.font = [UIFont boldSystemFontOfSize:34];
        self.messageLabel.adjustsFontSizeToFitWidth = YES;
        
        [self addSubview:self.messageLabel];
    }
    return self;
}

-(void) setMessage:(NSString *)message
{
    self.messageLabel.text = message;
}

-(void) showInView:(UIView*)view
{
    [view addSubview:self];
    __weak typeof(self) weakSelf = self;
    CGRect frame = self.frame;
    frame.origin.y = 0;
    [UIView animateWithDuration:0.5 delay:0.3 usingSpringWithDamping:0.3 initialSpringVelocity:0.6 options:UIViewAnimationOptionCurveLinear animations:^{
        weakSelf.frame = frame;
    }completion:nil];
}

-(void) removePopView
{
    __weak typeof(self) weakSelf = self;
    CGRect frame = self.frame;
    frame.origin.y = -CGRectGetHeight(frame);
    [UIView animateWithDuration:0.5 delay:0.3 usingSpringWithDamping:0.3 initialSpringVelocity:0.6 options:UIViewAnimationOptionCurveLinear animations:^{
        weakSelf.frame = frame;
    }completion:^(BOOL f){
        [self removeFromSuperview];
    }];
}

@end
