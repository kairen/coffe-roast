//
//  KRLineChartView.h
//  CafeRoast
//
//  Created by Bai-Kai-Ren on 13/10/29.
//  Copyright (c) 2013年 Bai-Kai-Ren. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KRLineDash+Label.h"
#import "KRChartLine+Dot.h"


@interface KRLineChartView : UIView

-(void) setMaximumValue:(NSInteger)maximumValue MinimumValue:(NSInteger)minimumValue;


@property(nonatomic, strong) NSArray *lineDatas;
@property(nonatomic, strong) UIColor *lineColor;

@property(nonatomic) UIEdgeInsets edgeInsets;

@property(nonatomic, strong) KRLineDash_Label *krDashLine;
@property(nonatomic, strong) KRChartLine_Dot *krChartLine;
@end
