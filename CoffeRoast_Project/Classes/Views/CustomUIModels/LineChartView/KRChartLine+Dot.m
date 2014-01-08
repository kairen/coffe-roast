//
//  KRChartLine+Dot.m
//  CoffeRoast_Project
//
//  Created by Bai-Kai-Ren on 2013/12/24.
//  Copyright (c) 2013年 Bai-Kai-Ren. All rights reserved.
//

#import "KRChartLine+Dot.h"

@interface KRChartLine_Dot ()
{
    CGFloat dotSize;
}
@end

@implementation KRChartLine_Dot

- (id) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.opaque = YES;
        _maximumValue = -1;
        _minimumValue = -1;
        dotSize = CGRectGetWidth(self.frame) * 0.015302285;
        
    }
    return self;
}

#pragma mark - setMini and Max limit Value
-(void) setMaxValue:(NSInteger)maxValue miniValue:(NSInteger)miniValue
{
    _maximumValue = maxValue;
    _minimumValue = miniValue;
    [self setNeedsDisplay];
}

#pragma mark - draw Chart Line
-(void) drawLineWithLineDatas:(NSArray *)linedatas
{
    self.lineDatas = linedatas;
    [self setNeedsDisplay];
}

#pragma mark - ReDraw
- (void) drawRect:(CGRect)rect
{
    if(self.maximumValue != -1 && self.minimumValue != -1 && self.lineDatas) {
        [self drawChartLineRect:rect];
    }
}

#pragma mark - Draw Chart Line
-(void) drawChartLineRect:(CGRect)rect
{
    NSInteger count = self.lineDatas.count;
    CGPoint graphPoints[count];
    CGFloat _drawingWidth , _drawingHeight;

    _drawingWidth = CGRectGetWidth(self.frame) - self.edgeInsets.left - self.edgeInsets.right;
    _drawingHeight = CGRectGetHeight(self.frame) - self.edgeInsets.top - self.edgeInsets.bottom;
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    CGContextSetMiterLimit(context, 0.1);
 
    CGContextSetLineWidth(context, 2);
    
    if(count > 1) {
        for(int i = 0 ; i < count ; i++) {
            CGFloat x, y, dataPointValue;
            
            dataPointValue = ((NSNumber *)self.lineDatas[i]).floatValue;
            
            if(dataPointValue > self.maximumValue){
                dataPointValue = self.maximumValue;
            }
            
            x = self.edgeInsets.left + (_drawingWidth / (count - 1)) * i;
            if (self.maximumValue != self.minimumValue) {
                y = CGRectGetHeight(self.frame) - ( self.edgeInsets.bottom + _drawingHeight * ((dataPointValue - self.minimumValue) / (self.maximumValue - self.minimumValue) ) );
            }
            else {
                y = CGRectGetHeight(self.frame) / 2;
            }
            graphPoints[i] = CGPointMake(x, y);
        }
    }
    else if (self.lineDatas.count == 1) {
        graphPoints[0].x = _drawingWidth / 2;
        graphPoints[0].y = _drawingHeight / 2;
    }
    [self.lineColor setStroke];
    CGContextAddLines(context, graphPoints, count);
    CGContextStrokePath(context);
    
    for(int i = 0 ; i < count ; i++) {
        CGRect ellipseRect ;
        
        ellipseRect = CGRectMake(graphPoints[i].x - (dotSize / 2), graphPoints[i].y - (dotSize / 2),dotSize,dotSize);
        CGContextSetLineWidth(context, (dotSize / 2));
        CGContextAddEllipseInRect(context, ellipseRect);
        [self.lineColor setStroke];
        [self.lineColor setFill];
        CGContextFillEllipseInRect(context, ellipseRect);
        CGContextStrokeEllipseInRect(context, ellipseRect);
    }
    CGContextRestoreGState(context);
}
@end
