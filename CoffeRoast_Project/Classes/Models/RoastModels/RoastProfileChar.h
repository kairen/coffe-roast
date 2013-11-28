//
//  RoastProfileCharModel.h
//  CafeRoast
//
//  Created by Bai-Kai-Ren on 13/11/14.
//  Copyright (c) 2013年 Bai-Kai-Ren. All rights reserved.
//

#import <Foundation/Foundation.h>


#pragma mark - RoastProfileChars Items
static NSString *const JSONRoastStageNoKey = @"stageNo";
static NSString *const JSONRoastControlItemKey = @"controlItem";
static NSString *const JSONRoastControlParameterKey = @"controlParameter";
static NSString *const JSONRoastWindSpeedKey = @"windSpeed";
static NSString *const JSONRoastAliasKey = @"alias_";
static NSString *const JSONRoastTimeKey = @"time";
static NSString *const JSONRoastRollerSpeedKey = @"rollerSpeed";
static NSString *const JSONRoastTemperatureKey = @"temperature";

@interface RoastProfileChar : NSObject

+(id) roastProfileCharWithDict:(NSDictionary*)dict;


@property(nonatomic) NSInteger stageNo;
@property(nonatomic) NSInteger controlItem;
@property(nonatomic) NSInteger controlParameter;
@property(nonatomic) NSInteger windSpeed;
@property(nonatomic) NSInteger alias;

@property(nonatomic) NSInteger time;
@property(nonatomic) NSInteger rollerSpeed;
@property(nonatomic) NSInteger temperature;
@end
