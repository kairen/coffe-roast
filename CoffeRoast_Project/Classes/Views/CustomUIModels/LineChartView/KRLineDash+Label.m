//
//  KRLineDash+Label.m
//  CoffeRoast_Project
//
//  Created by Bai-Kai-Ren on 2013/12/24.
//  Copyright (c) 2013年 Bai-Kai-Ren. All rights reserved.
//

#import "KRLineDash+Label.h"

#define KRColorDefault  [UIColor blackColor]

@implementation KRLineDash_Label

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.opaque = YES;
        _maximumValue = -1;
        _minimumValue = -1;
    }
    return self;
}

#pragma mark - Draw Y Label Dash
-(void) drawYLabelDashWithMaxValue:(NSInteger)maxValue miniValue:(NSInteger)miniValue
{
     CGFloat lineViewHeight = CGRectGetHeight(self.frame) - self.edgeInsets.top - self.edgeInsets.bottom;
    _minimumValue = miniValue;
    _maximumValue = maxValue;
    
    if(self.yLabels == nil) {
        self.yLabels = [NSMutableArray array];
        
        CGFloat avePoint = lineViewHeight / self.maximumValue;
        for(int y = 0 ; y <= 5 ; y++) {
            KRLineLabel *label = [[KRLineLabel alloc]initWithFrame:CGRectMake(0,self.edgeInsets.top + (lineViewHeight - (avePoint * ((self.maximumValue / 5) * y))) - 7.5 , 25, 15) text:[NSString stringWithFormat:@"%d",(int)((self.maximumValue / 5) * y)] textColor:KRColorDefault];
            [self addSubview:label];
            [self.yLabels addObject:label];
        }
    }
}

#pragma mark - Draw Y Label Dash
-(void) drawXLabelDashWithLineDatas:(NSArray *)linedatas
{
    self.lineDatas = linedatas;
    
    if(self.xLabels == nil) {
        self.xLabels = [NSMutableArray array];
            CGFloat lineViewWidth = CGRectGetWidth(self.frame) - self.edgeInsets.right - self.edgeInsets.left;
            CGFloat avePoint = lineViewWidth / (self.lineDatas.count - 1);
            for(int x = 0 ; x < self.lineDatas.count ; x++) {
                KRLineLabel *label = [[KRLineLabel alloc]initWithFrame:CGRectMake(self.edgeInsets.top + (avePoint * x) - 12.5,CGRectGetHeight(self.frame) - 15, 25, 15) text:[NSString stringWithFormat:@"%d",x] textColor:KRColorDefault];
                [self addSubview:label];
                [self.xLabels addObject:label];
        }
    }
}
#pragma mark - ReDraw
- (void)drawRect:(CGRect)rect
{
    if(self.maximumValue != -1 && self.minimumValue != -1) {
        [self drawDashLineRect:rect];
    }
}

#pragma mark - Draw Dash Line
-(void) drawDashLineRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
  
    CGContextSetLineWidth(context, 1);
    CGContextSetRGBStrokeColor(context, 0, 0, 0, 1);
    
    //Y Dash Line
    for(KRLineLabel *label in self.yLabels) {
        CGContextMoveToPoint(context, self.edgeInsets.left, CGRectGetMidY(label.frame));
        CGContextAddLineToPoint(context, CGRectGetWidth(self.frame) - self.edgeInsets.right, CGRectGetMidY(label.frame));
        CGContextDrawPath(context, kCGPathStroke);
    }
    
    //X Dash Line
    for(KRLineLabel *label in self.xLabels) {
        CGContextMoveToPoint(context, CGRectGetMidX(label.frame),CGRectGetHeight(self.frame) - self.edgeInsets.bottom);
        CGContextAddLineToPoint(context, CGRectGetMidX(label.frame), self.edgeInsets.top);
        CGContextDrawPath(context, kCGPathStroke);
    }
    CGContextRestoreGState(context);
}

@end

#pragma mark
#pragma mark - @implementation KRLineLabel
@implementation KRLineLabel

-(id) initWithFrame:(CGRect)frame text:(NSString *)text textColor:(UIColor *)textColor
{
    self = [super initWithFrame:frame];
    if(self) {
        self.backgroundColor = [UIColor clearColor];
        self.text = text;
        self.font = [UIFont boldSystemFontOfSize:12.0f];
        self.textAlignment = NSTextAlignmentCenter;
        self.textColor = textColor;
        self.adjustsFontSizeToFitWidth = YES;
    }
    return self;
}
@end
