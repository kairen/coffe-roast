//
//  ProfileController.h
//  CoffeRoast_Project
//
//  Created by Bai-Kai-Ren on 2013/12/24.
//  Copyright (c) 2013年 Bai-Kai-Ren. All rights reserved.
//

#import "BaseController.h"

@class RoastJSONModel;
@class ProfileListEvent;
@class ProfileProtocolHandler;
@class ProfileAllEvent;
@class ProfileView;
@class RoastProfile;
@class BeanProfile;
@class PopInfoView;

@interface ProfileController : BaseController 

@property(nonatomic, strong) RoastJSONModel *roastJson;
@property(nonatomic, strong) ProfileView *profileView;
@property(nonatomic, strong) ProfileListEvent *profileListEvent;
@property(nonatomic, strong) RoastProfile *roastProfiles;
@property(nonatomic, strong) BeanProfile *beanProfiles;
@property(nonatomic, strong) ProfileProtocolHandler *handler;
@property(nonatomic, strong) ProfileAllEvent *profileAllEvent;

@property(nonatomic, strong) PopInfoView *infoView;
@property(nonatomic) BOOL isRoasted;

-(void) reloadRoastData;
-(void) checkSaveRepeatFileName:(NSString*)fileName duplicate:(BOOL)dup;
-(void) readRoastStatus;
@end
