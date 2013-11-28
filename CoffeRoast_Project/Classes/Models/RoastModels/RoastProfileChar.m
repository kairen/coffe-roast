//
//  RoastProfileCharModel.m
//  CafeRoast
//
//  Created by Bai-Kai-Ren on 13/11/14.
//  Copyright (c) 2013年 Bai-Kai-Ren. All rights reserved.
//

#import "RoastProfileChar.h"


@implementation RoastProfileChar

+(id) roastProfileCharWithDict:(NSDictionary*)dict

{
    return [[self alloc]initWithDict:dict];
}

-(id) initWithDict:(NSDictionary*)dict
{
    self = [super init];
    if(self) {
        _stageNo = [[dict objectForKey:JSONRoastStageNoKey] integerValue];
        _controlItem = [[dict objectForKey:JSONRoastControlItemKey] integerValue];
        _controlParameter = [[dict objectForKey:JSONRoastControlParameterKey] integerValue];
        _windSpeed = [[dict objectForKey:JSONRoastWindSpeedKey] integerValue];
        _alias = [[dict objectForKey:JSONRoastAliasKey] integerValue];
        _time = [[dict objectForKey:JSONRoastTimeKey] integerValue];
        _rollerSpeed = [[dict objectForKey:JSONRoastRollerSpeedKey] integerValue];
        _temperature = [[dict objectForKey:JSONRoastTemperatureKey] integerValue];

    }
    return self;
}

@end
