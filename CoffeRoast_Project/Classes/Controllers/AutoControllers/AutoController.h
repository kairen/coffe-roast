//
//  AutonController.h
//  CoffeRoast_Project
//
//  Created by Bai-Kai-Ren on 2013/11/28.
//  Copyright (c) 2013年 Bai-Kai-Ren. All rights reserved.
//

#import "BaseController.h"

@class RoastJSONModel;
@class AutoAllEvent;
@class AutoListEvent;
@class AutoView;
@class RoastProfile;
@class BeanProfile;
@class PopInfoView;
@class RoastJSONModel;

@interface AutoController : BaseController

@property(nonatomic, strong) AutoView *autoView;
@property(nonatomic, strong) AutoListEvent *autoListEvent;
@property(nonatomic, strong) AutoAllEvent *autoAllEvent;

@property(nonatomic, strong) RoastJSONModel *roastJson;
@property(nonatomic, strong) RoastProfile *roastProfiles;
@property(nonatomic, strong) BeanProfile *beanProfiles;

@property(nonatomic, strong) PopInfoView *infoView;

@property(nonatomic) BOOL isRoasted;

-(void) readRoastStatus;
@end
