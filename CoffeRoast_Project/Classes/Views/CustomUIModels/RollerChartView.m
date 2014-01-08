//
//  RollerChartView.m
//  CoffeRoast_Project
//
//  Created by Bai-Kai-Ren on 2013/12/24.
//  Copyright (c) 2013年 Bai-Kai-Ren. All rights reserved.
//

#import "RollerChartView.h"

@interface RollerChartView ()

@property(nonatomic, strong) NSMutableArray *windViews;
@end

@implementation RollerChartView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

#pragma mark - Draw Two Value Label
-(void) drawTwoYLabelWithMaxValue:(NSInteger)maxValue
{
    CGFloat lineViewHeight = CGRectGetHeight(self.frame) - self.edgeInsets.top - self.edgeInsets.bottom;
    NSInteger  _maximumValue = maxValue;
    
    if(self.yLabels == nil) {
        self.yLabels = [NSMutableArray array];
        
        CGFloat avePoint = lineViewHeight / _maximumValue;
        for(int y = 0 ; y <= 5 ; y++) {
            KRLineLabel *label = [[KRLineLabel alloc]initWithFrame:CGRectMake(CGRectGetWidth(self.frame) - self.edgeInsets.right,self.edgeInsets.top + (lineViewHeight - (avePoint * ((_maximumValue / 5) * y))) - 7.5 , 25, 15) text:[NSString stringWithFormat:@"%d",(int)((_maximumValue / 5) * y)] textColor:[UIColor blackColor]];
            [self addSubview:label];
            [self.yLabels addObject:label];
        }
    }
}

-(void) setWindDatas:(NSArray *)windDatas
{
    _windDatas = windDatas;
    
    CGFloat _drawingWidth , _drawingHeight;
    
    _drawingWidth = CGRectGetWidth(self.frame) - self.edgeInsets.left - self.edgeInsets.right;
    _drawingHeight = CGRectGetHeight(self.frame) - self.edgeInsets.top - self.edgeInsets.bottom;
    
    if(self.windViews == nil) {
        self.windViews = [NSMutableArray array];
       
        for(int i = 0 ; i < self.windDatas.count -1; i ++) {
            CGFloat windPoint =  CGRectGetMidX([(UILabel*)[self.krDashLine.xLabels objectAtIndex:i] frame]);
            CGFloat height = (_drawingHeight / 10) * [[self.windDatas objectAtIndex:i] intValue];
            UIView *windView = [[UIView alloc]initWithFrame:CGRectMake(windPoint ,30 + (_drawingHeight - height), _drawingWidth / 26, height)];
            windView.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.5];
            
            [self addSubview:windView];
            [self.windViews addObject:windView];
            [self bringSubviewToFront:self.krChartLine];
        }
    } else {
        for(int i = 0 ; i < self.windDatas.count -1; i ++) {
            CGFloat windPoint =  CGRectGetMidX([(UILabel*)[self.krDashLine.xLabels objectAtIndex:i] frame]);
            CGFloat height = (_drawingHeight / 10) * [[self.windDatas objectAtIndex:i] intValue];
            UIView *windView = [self.windViews objectAtIndex:i];
            windView.frame = CGRectMake(windPoint ,30 + (_drawingHeight - height), _drawingWidth / 26, height);
            windView.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.5];
        }

    }
}

@end
