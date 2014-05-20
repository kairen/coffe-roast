//
//  TempChartView.m
//  CoffeRoast_Project
//
//  Created by Bai-Kai-Ren on 2013/12/24.
//  Copyright (c) 2013年 Bai-Kai-Ren. All rights reserved.
//

#import "TempChartView.h"
#import "UIColor+Category.h"


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
    return self;
}

-(void) setStartPoint:(NSInteger)startPoint
{
    if(self.krDashLine.xLabels > 0 && startPoint <= self.krDashLine.xLabels.count && startPoint > 0) {
        CGFloat start = CGRectGetMidX([(UILabel*)[self.krDashLine.xLabels objectAtIndex:startPoint] frame]);
        CGRect frame = self.startView.frame;
        frame.origin.x = start - (CGRectGetWidth(frame) / 2);
        self.startView.alpha = 0.5;
        [UIView animateWithDuration:0.1 animations:^{
            _startView.alpha = 1.0;
            _startView.frame = frame;
        }];
        _startPoint = startPoint;
    } else {
        [UIView animateWithDuration:0.3 animations:^{
            _startView.alpha = 0.0;
        }];
    }
}

-(void)setStopPoint:(NSInteger)stopPoint
{
    if(self.krDashLine.xLabels > 0 && stopPoint <= self.krDashLine.xLabels.count && stopPoint > self.startPoint) {
        CGFloat stop = CGRectGetMidX([(UILabel*)[self.krDashLine.xLabels objectAtIndex:stopPoint] frame]);
        CGRect frame = self.stopView.frame;
        frame.origin.x = stop - (CGRectGetWidth(frame) / 2);
        self.stopView.alpha = 0.5;
        [UIView animateWithDuration:0.1 animations:^{
            _stopView.alpha = 1.0;
            _stopView.frame = frame;
        }];
          _stopPoint = stopPoint;
    } else {
        [UIView animateWithDuration:0.3 animations:^{
         _stopView.alpha = 0.0;
        }];
    }
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


-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if(self.canEdit == 0) {
        CGFloat x = [[touches anyObject]locationInView:self].x;
        CGRect frame = self.moveView.frame;
        for(KRLineLabel *label in self.krDashLine.xLabels) {
            if(x > CGRectGetMinX(label.frame) && x < CGRectGetMidX(label.frame)) {
                frame.origin.x = CGRectGetMidX(label.frame) - CGRectGetWidth(frame);
                self.moveView.alpha = 1.0;
                self.moveView.frame = frame;
                NSInteger index = [label.text integerValue];
                self.moveLabel.text = [NSString stringWithFormat:@"No: %@ Value: %d",label.text,(int)[self.lineDatas[index] integerValue]];
            }
        }
    } else if(self.canEdit == 1) {
        CGFloat x = [[touches anyObject]locationInView:self].x;
        for(KRLineLabel *label in self.krDashLine.xLabels) {
            if(x > CGRectGetMinX(label.frame) && x < CGRectGetMidX(label.frame)) {
                NSInteger index = [label.text integerValue];
                if(index > 1 && index < self.stopPoint) {
                    self.startPoint = index;
                }
            }
        }
    } else if(self.canEdit == 2) {
        CGFloat x = [[touches anyObject]locationInView:self].x;
        for(KRLineLabel *label in self.krDashLine.xLabels) {
            if(x > CGRectGetMinX(label.frame) && x < CGRectGetMidX(label.frame)) {
                NSInteger index = [label.text integerValue];
                if(index > self.startPoint && index < 26) {
                    self.stopPoint = index;
                }
            }
        }
    }
}

-(void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    if(self.canEdit == 0) {
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
        for(KRLineLabel *label in self.krDashLine.xLabels) {
            if(x > CGRectGetMinX(label.frame) && x < CGRectGetMidX(label.frame)) {
                NSInteger index = [label.text integerValue];
                if(index > 1 && index < self.stopPoint) {
                    self.startPoint = index;
                }
            }
        }
    } else if(self.canEdit == 2) {
        CGFloat x = [[touches anyObject]locationInView:self].x;
        for(KRLineLabel *label in self.krDashLine.xLabels) {
            if(x > CGRectGetMinX(label.frame) && x < CGRectGetMidX(label.frame)) {
                NSInteger index = [label.text integerValue];
                if(index > self.startPoint && index < 26) {
                    self.stopPoint = index;
                }
            }
        }
    }
}

-(void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if(self.canEdit == 0) {
        __weak typeof(self) weakSelf = self;
        [UIView animateWithDuration:0.4 animations:^{
            weakSelf.moveView.alpha = 0.0;
        }];
    }
}

@end
