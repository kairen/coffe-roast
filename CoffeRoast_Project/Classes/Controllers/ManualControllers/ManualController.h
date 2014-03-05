//
//  ManualController.h
//  CoffeRoast_Project
//
//  Created by Bai-Kai-Ren on 2013/12/31.
//  Copyright (c) 2013年 Bai-Kai-Ren. All rights reserved.
//

#import "BaseController.h"

@class ManualView;
@class ManualEvents;
@class RoastJSONModel;
@class RoastProfile;
@class PopInfoView;

@interface ManualController : BaseController

@property(nonatomic, strong) ManualView *manualView;
@property(nonatomic, strong) RoastJSONModel *roastJson;
@property(nonatomic, strong) RoastProfile *roastPorfiles;
@property(nonatomic, strong) ManualEvents *manualEvents;
@property(nonatomic, strong) PopInfoView *infoView;

@property(nonatomic, strong) NSTimer *timer;
@property(nonatomic) NSInteger stageIndex;
@property(nonatomic) int stageSec;
@property(nonatomic) BOOL isLoadRoasted;
@property(nonatomic) NSInteger stageControl;
-(void) readRoastStatus;
-(void) defaultValueSet;
-(void) checkStatusComplete:(void(^)(void)) complete;
-(void) endRoastSaveProfile;
@end
