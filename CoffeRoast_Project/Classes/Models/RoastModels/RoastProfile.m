//
//  RoastProfileModel.m
//  CafeRoast
//
//  Created by Bai-Kai-Ren on 13/11/13.
//  Copyright (c) 2013年 Bai-Kai-Ren. All rights reserved.
//

#import "RoastProfile.h"

@implementation RoastProfile

+(id) roastProfileWithDict:(NSDictionary *)dict
{
    return [[self alloc]initWithDict:dict];
}

-(id) initWithDict:(NSDictionary*)dict
{
    self = [super init];
    if(self) {
        _roastProfileChars = [dict objectForKey:JSONRoastProfileCharNameKey];
       _fileName = [dict objectForKey:JSONRoastFileNameKey];
    }
    return self;
}

#pragma mark - Temperature Values
-(NSArray*) temperatureVaules
{
    NSMutableArray *tempreatures = [NSMutableArray array];
    for(NSDictionary* dict in self.roastProfileChars) {
        [tempreatures addObject:[NSNumber numberWithInt:[[dict objectForKey:JSONRoastTemperatureKey] intValue]]];
    }
    return tempreatures;
}

#pragma mark - Roller Speed Vaules
-(NSArray*) rollerSpeedVaules
{
    NSMutableArray *rollerSpeeds = [NSMutableArray array];
    for(NSDictionary* dict in self.roastProfileChars) {
        [rollerSpeeds addObject:[NSNumber numberWithInt:[[dict objectForKey:JSONRoastRollerSpeedKey] intValue]]];
    }
    return rollerSpeeds;
}

#pragma mark - Wind Speed Vaules
-(NSArray*) windSpeedVaules
{
    NSMutableArray *windSpeeds = [NSMutableArray array];
    for(NSDictionary* dict in self.roastProfileChars) {
        [windSpeeds addObject:[NSNumber numberWithInt:[[dict objectForKey:JSONRoastWindSpeedKey] intValue]]];
    }
    return windSpeeds;
}

#pragma mark - Wind Speed Vaules
-(NSArray*) controlItemValues
{
    NSMutableArray *controlItems = [NSMutableArray array];
    for(NSDictionary* dict in self.roastProfileChars) {
        [controlItems addObject:[NSNumber numberWithInt:[[dict objectForKey:JSONRoastControlItemKey] intValue]]];
    }
    return controlItems;
}

#pragma mark - Input Bean
-(NSInteger) inPutBeanIndex
{
    for(int i = 0 ; i < self.controlItemValues.count ; i ++) {
        if([[self.controlItemValues objectAtIndex:i] intValue] == ControlInputBean) {
            return i;
        }
    }
    return 1;
}

#pragma mark - Output Bean
-(NSInteger) outPutBeanIndex
{
    for(int i = 0 ; i < self.controlItemValues.count ; i ++) {
        if([[self.controlItemValues objectAtIndex:i] intValue] == ControlOutputBean) {
            return i;
        }
    }
    return 10;
}

@end
