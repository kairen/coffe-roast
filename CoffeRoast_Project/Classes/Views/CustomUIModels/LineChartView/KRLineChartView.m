//
//  KRLineChartView.m
//  CafeRoast
//
//  Created by Bai-Kai-Ren on 13/10/29.
//  Copyright (c) 2013年 Bai-Kai-Ren. All rights reserved.
//

#import "KRLineChartView.h"


@interface KRLineChartView ()
{
    BOOL isFirst;
}
@property(nonatomic, readonly) NSInteger minimumValue;
@property(nonatomic, readonly) NSInteger maximumValue;
@end

@implementation KRLineChartView

+(id) createLineChartViewWithFrame:(CGRect)frame
{
    return [[self alloc] initWithFrame:frame];
}

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self) {
        self.opaque = YES;
        self.edgeInsets = UIEdgeInsetsMake(30, 30, 30, 30);
        self.krDashLine = [[KRLineDash_Label alloc]initWithFrame:self.frame];
        self.krDashLine.edgeInsets = self.edgeInsets;
        [self addSubview:self.krDashLine];
        
        self.krChartLine = [[KRChartLine_Dot alloc]initWithFrame:self.frame];
        self.krChartLine.edgeInsets = self.edgeInsets;
        isFirst = NO;
        
        [self addSubview:self.krChartLine];
    }
    return self;
}

#pragma mark - setMini and Max limit Value
-(void) setMaximumValue:(NSInteger)maximumValue MinimumValue:(NSInteger)minimumValue
{
    _maximumValue = maximumValue;
    _minimumValue = minimumValue;
    [self.krDashLine drawYLabelDashWithMaxValue:self.maximumValue miniValue:self.minimumValue];
    [self.krChartLine setMaxValue:self.maximumValue miniValue:self.minimumValue];
}

#pragma mark - setLineDatas
-(void) setLineDatas:(NSArray *)lineDatas
{
    _lineDatas = lineDatas;
    if(!isFirst) {
        [self.krDashLine drawXLabelDashWithLineDatas:self.lineDatas];
        isFirst = YES;
    }
    [self.krChartLine drawLineWithLineDatas:self.lineDatas];
}

#pragma mark - set Line Color
-(void) setLineColor:(UIColor *)lineColor
{
    _lineColor = lineColor;
    self.krChartLine.lineColor = self.lineColor;
}

@end
