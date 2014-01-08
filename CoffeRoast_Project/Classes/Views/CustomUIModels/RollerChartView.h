//
//  RollerChartView.h
//  CoffeRoast_Project
//
//  Created by Bai-Kai-Ren on 2013/12/24.
//  Copyright (c) 2013年 Bai-Kai-Ren. All rights reserved.
//

#import "KRLineChartView.h"

@interface RollerChartView : KRLineChartView

@property(nonatomic, strong) NSMutableArray *yLabels;

@property(nonatomic, strong) NSArray *windDatas;
-(void) drawTwoYLabelWithMaxValue:(NSInteger)maxValue ;
@end
