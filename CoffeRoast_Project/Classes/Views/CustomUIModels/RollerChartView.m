//
//  RollerChartView.m
//  CoffeRoast_Project
//
//  Created by Bai-Kai-Ren on 2013/12/24.
//  Copyright (c) 2013年 Bai-Kai-Ren. All rights reserved.
//

#import "RollerChartView.h"
#import "UIColor+Category.h"

@interface RollerChartView ()

@property(nonatomic, strong) NSMutableArray *windViews;
@end

@implementation RollerChartView

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
    self.canEdit = YES;
    self.moveView = [[UIView alloc]initWithFrame:CGRectMake(-100, 0, 120, 40)];
    self.moveView.backgroundColor = [UIColor colorWithIntegerRed:215 green:215 blue:219];
    self.moveView.alpha = 0.0;
    [self addSubview:self.moveView];
    
    self.moveLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 120, 40)];
    self.moveLabel.font = [UIFont boldSystemFontOfSize:20];
    self.moveLabel.adjustsFontSizeToFitWidth = YES;
    self.moveLabel.textColor = [UIColor colorWithIntegerRed:148 green:114 blue:91];
    [self.moveView addSubview:self.moveLabel];
    self.canEdit = -1;
}

-(void) displayTargetStageNO:(NSInteger)stageIndex
{
    CGRect frame = self.moveView.frame;
    self.userInteractionEnabled = NO;
    KRLineLabel *label = self.krDashLine.xLabels[stageIndex];
    
    frame.origin.x = CGRectGetMidX(label.frame) - CGRectGetWidth(frame);
    self.moveView.alpha = 1.0;
    self.moveView.frame = frame;
    self.moveLabel.text = [NSString stringWithFormat:@"No: %ld Value: %ld",(long)stageIndex,(long)[self.lineDatas[stageIndex] integerValue]];
}

-(void) stopDisplayTarget
{
    self.userInteractionEnabled = YES;
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.4 animations:^{
        weakSelf.moveView.alpha = 0.0;
    }];
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

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if(self.canEdit  == 0) {
        CGFloat x = [[touches anyObject]locationInView:self].x;
        CGRect frame = self.moveView.frame;
        for(KRLineLabel *label in self.krDashLine.xLabels) {
            if(x > CGRectGetMinX(label.frame) && x < CGRectGetMidX(label.frame)) {
                frame.origin.x = CGRectGetMidX(label.frame) - CGRectGetWidth(frame);
                self.moveView.alpha = 1.0;
                self.moveView.frame = frame;
                NSInteger index = [label.text integerValue];
                self.moveLabel.text = [NSString stringWithFormat:@"No: %@ Value: %ld",label.text,(long)[self.lineDatas[index] integerValue]];
            }
        }
    } else if(self.canEdit == 1) {
        CGFloat x = [[touches anyObject]locationInView:self].x;
        CGRect frame = self.moveView.frame;
        for(KRLineLabel *label in self.krDashLine.xLabels) {
            if(x > CGRectGetMinX(label.frame) && x < CGRectGetMidX(label.frame)) {
                NSInteger index = [label.text integerValue];
                if(index < 27) {
                    frame.origin.x = CGRectGetMidX(label.frame) - CGRectGetWidth(frame);
                    self.moveView.alpha = 1.0;
                    self.moveView.frame = frame;
                    NSInteger index = [label.text integerValue];
                    self.moveLabel.text = [NSString stringWithFormat:@"No: %@ Value: %ld",label.text,(long)[self.windDatas[index] integerValue]];
                }
            }
        }
    }
}

-(void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    if(self.canEdit == 0 ) {
        CGFloat x = [[touches anyObject]locationInView:self].x;
        CGFloat y = [[touches anyObject]locationInView:self].y;
        CGRect frame = self.moveView.frame;
        for(KRLineLabel *label in self.krDashLine.xLabels) {
            if(x > CGRectGetMinX(label.frame) && x < CGRectGetMidX(label.frame)) {
                frame.origin.x = CGRectGetMidX(label.frame) - CGRectGetWidth(frame);
                self.moveView.alpha = 1.0;
                self.moveView.frame = frame;
                NSInteger index = [label.text integerValue];
                NSMutableArray *array = nil;
                if(y > self.edgeInsets.top && y <  CGRectGetHeight(self.frame) - self.edgeInsets.bottom ) {
                    array = [NSMutableArray arrayWithArray:self.lineDatas];
                    CGFloat avg =  self.krChartLine.maximumValue / (CGRectGetHeight(self.frame) - self.edgeInsets.bottom - self.edgeInsets.top) ;
                    CGFloat value =  self.krChartLine.maximumValue - (avg * (y - 30));
                    [array replaceObjectAtIndex:index withObject:[NSNumber numberWithFloat:value]];
                    self.lineDatas = array;
                }
                self.moveLabel.text = [NSString stringWithFormat:@"No: %@ Value: %ld",label.text,(long)[self.lineDatas[index] integerValue]];
            }
        }
    } else if(self.canEdit == 1) {
        CGFloat x = [[touches anyObject]locationInView:self].x;
        CGFloat y = [[touches anyObject]locationInView:self].y;
        CGRect frame = self.moveView.frame;
        for(KRLineLabel *label in self.krDashLine.xLabels) {
            if(x > CGRectGetMinX(label.frame) && x < CGRectGetMidX(label.frame)) {
                NSInteger index = [label.text integerValue];
                if(index < 27) {
                    frame.origin.x = CGRectGetMidX(label.frame) - CGRectGetWidth(frame);
                    self.moveView.alpha = 1.0;
                    self.moveView.frame = frame;
                    NSInteger index = [label.text integerValue];
                    NSMutableArray *array = nil;
                    if(y > self.edgeInsets.top && y <  CGRectGetHeight(self.frame) - self.edgeInsets.bottom ) {
                        array = [NSMutableArray arrayWithArray:self.windDatas];
                        CGFloat avg =  11 / (CGRectGetHeight(self.frame) - self.edgeInsets.bottom - self.edgeInsets.top) ;
                        CGFloat value =  11 - (avg * (y - 30));
                        if(value > 10) {
                            value = 10;
                        } else if(value < 3) {
                            value = 3;
                        }
                        [array replaceObjectAtIndex:index withObject:[NSNumber numberWithFloat:value]];
                        self.windDatas = array;
                    }
                    self.moveLabel.text = [NSString stringWithFormat:@"No: %@ Value: %ld",label.text,(long)[self.windDatas[index] integerValue]];
                }
            }
        }
    }
}

-(void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if(self.canEdit == 0 || self.canEdit == 1) {
        __weak typeof(self) weakSelf = self;
        [UIView animateWithDuration:0.4 animations:^{
            weakSelf.moveView.alpha = 0.0;
        }];
    }
}

@end
