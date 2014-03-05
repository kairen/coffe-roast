//
//  KRLineDash+Label.h
//  CoffeRoast_Project
//
//  Created by Bai-Kai-Ren on 2013/12/24.
//  Copyright (c) 2013年 Bai-Kai-Ren. All rights reserved.
//

#import <UIKit/UIKit.h>

@class KRLineLabel;

@interface KRLineDash_Label : UIView

@property(nonatomic) NSInteger minimumValue;
@property(nonatomic) NSInteger maximumValue;
@property(nonatomic, strong) NSMutableArray *xLabels;
@property(nonatomic, strong) NSMutableArray *yLabels;
@property(nonatomic, weak) NSArray *lineDatas;


@property(nonatomic) UIEdgeInsets edgeInsets;

-(void) drawYLabelDashWithMaxValue:(NSInteger)maxValue miniValue:(NSInteger)miniValue;
-(void) drawXLabelDashWithLineDatas:(NSArray*)linedatas;
@end

#pragma mark
#pragma mark - @interface KRLineLabel
@interface KRLineLabel : UILabel

- (id)initWithFrame:(CGRect)frame text:(NSString *)text textColor:(UIColor*)textColor;
@end