//
//  RoastProfileModel.h
//  CafeRoast
//
//  Created by Bai-Kai-Ren on 13/11/13.
//  Copyright (c) 2013年 Bai-Kai-Ren. All rights reserved.
//

#import <Foundation/Foundation.h>


#pragma mark - RoastProfileKey
static NSString *const JSONRoastProfileCharNameKey = @"RoastProfileChar";
static NSString *const JSONRoastFileNameKey = @"fileName";

#pragma mark - RoastProfileCharKey
static NSString *const JSONRoastStageNoKey = @"stageNo";
static NSString *const JSONRoastControlItemKey = @"controlItem";
static NSString *const JSONRoastControlParameterKey = @"controlParameter";
static NSString *const JSONRoastWindSpeedKey = @"windSpeed";
static NSString *const JSONRoastAliasKey = @"alias_";
static NSString *const JSONRoastTimeKey = @"time";
static NSString *const JSONRoastRollerSpeedKey = @"rollerSpeed";
static NSString *const JSONRoastTemperatureKey = @"temperature";

typedef NS_ENUM(NSInteger, ControlItems) {
    ControlInputBean = 1,
    ControlOutputBean = 2,
    ControlStopBean = 4
};

@interface RoastProfile : NSObject;

+(id) roastProfileWithDict:(NSDictionary *)dict;


@property(nonatomic, strong) NSMutableArray *roastProfileChars;
@property(nonatomic, strong) NSString *fileName;

-(NSInteger) inPutBeanIndex;
-(NSInteger) outPutBeanIndex;

-(NSArray*) temperatureVaules;
-(NSArray*) rollerSpeedVaules;
-(NSArray*) windSpeedVaules;
-(NSArray*) controlItemValues;


@end
