//
//  TempChartView.m
//  CoffeRoast_Project
//
//  Created by Bai-Kai-Ren on 2013/12/24.
//  Copyright (c) 2013年 Bai-Kai-Ren. All rights reserved.
//

#import "TempChartView.h"

@interface TempChartView ()

@property(nonatomic, strong) UIView *startView;
@property(nonatomic, strong) UIView *stopView;
@end

@implementation TempChartView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        CGFloat drawingWidth = CGRectGetWidth(self.frame) - self.edgeInsets.left - self.edgeInsets.right;
        CGFloat drawingHeight = CGRectGetHeight(self.frame) - self.edgeInsets.top - self.edgeInsets.bottom;
        
        self.startView = [[UIView alloc]initWithFrame:CGRectMake(30, 30, drawingWidth / 26, drawingHeight)];
        self.startView.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.5];
        self.startView.alpha = 0.0;
        [self addSubview:self.startView];
        
        self.stopView = [[UIView alloc]initWithFrame:CGRectMake(60, 30, drawingWidth / 26, drawingHeight)];
        self.stopView.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.5];
        self.stopView.alpha = 0.0;
        [self addSubview:self.stopView];
         [self bringSubviewToFront:self.krChartLine];
    }
    return self;
}

-(void) setStartPoint:(NSInteger)startPoint
{
    if(self.krDashLine.xLabels > 0 && startPoint <= self.krDashLine.xLabels.count && startPoint > 0) {
        CGFloat start = CGRectGetMidX([(UILabel*)[self.krDashLine.xLabels objectAtIndex:startPoint] frame]);
        CGRect frame = self.startView.frame;
        frame.origin.x = start - (CGRectGetWidth(frame) / 2);
        self.startView.alpha = 0.0;
        [UIView animateWithDuration:0.4 animations:^{
            self.startView.alpha = 1.0;
            self.startView.frame = frame;
        }];
        _startPoint = startPoint;
    }
}

-(void)setStopPoint:(NSInteger)stopPoint
{
    if(self.krDashLine.xLabels > 0 && stopPoint <= self.krDashLine.xLabels.count && stopPoint > self.startPoint) {
        CGFloat stop = CGRectGetMidX([(UILabel*)[self.krDashLine.xLabels objectAtIndex:stopPoint] frame]);
        CGRect frame = self.stopView.frame;
        frame.origin.x = stop - (CGRectGetWidth(frame) / 2);
        self.stopView.alpha = 0.0;
        [UIView animateWithDuration:0.4 animations:^{
            self.stopView.alpha = 1.0;
            self.stopView.frame = frame;
        }];
        _stopPoint = stopPoint;
    }
}

@end
