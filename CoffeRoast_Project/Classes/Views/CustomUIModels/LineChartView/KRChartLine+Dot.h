//
//  KRChartLine+Dot.h
//  CoffeRoast_Project
//
//  Created by Bai-Kai-Ren on 2013/12/24.
//  Copyright (c) 2013年 Bai-Kai-Ren. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KRChartLine_Dot : UIView

@property(nonatomic) NSInteger minimumValue;
@property(nonatomic) NSInteger maximumValue;

@property(nonatomic, weak) NSArray *lineDatas;
@property(nonatomic, weak) UIColor *lineColor;

@property(nonatomic) UIEdgeInsets edgeInsets;

-(void) setMaxValue:(NSInteger)maxValue miniValue:(NSInteger)miniValue;
-(void) drawLineWithLineDatas:(NSArray*)linedatas;
@end
