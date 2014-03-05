//
//  TempChartView.h
//  CoffeRoast_Project
//
//  Created by Bai-Kai-Ren on 2013/12/24.
//  Copyright (c) 2013年 Bai-Kai-Ren. All rights reserved.
//

#import "KRLineChartView.h"


@interface TempChartView : KRLineChartView

@property(nonatomic, strong) UIView *startView;
@property(nonatomic, strong) UIView *stopView;
@property(nonatomic) NSInteger startPoint;
@property(nonatomic) NSInteger stopPoint;

@property(nonatomic, strong) UIView *moveView;
@property(nonatomic, strong) UILabel *moveLabel;

@property(nonatomic) NSInteger canEdit;

-(void) displayTargetStageNO:(NSInteger)stageIndex;
-(void) stopDisplayTarget;
@end

