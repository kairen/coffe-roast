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
        self.roastProfile = [NSMutableDictionary dictionaryWithDictionary:dict];
        _roastProfileChars = [NSMutableArray arrayWithArray:[dict objectForKey:JSONRoastProfileCharKey]];
       _fileName = [dict objectForKey:JSONRoastFileNameKey];
    }
    return self;
}

-(void) setRoastPorfileVaules:(NSArray *)values withKey:(NSString *)key
{
    for(int i = 0 ; i < values.count ; i ++) {
        NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:self.roastProfileChars[i]];
       
        dict[key] = [key isEqualToString:JSONRoastTemperatureKey]  ? [NSNumber numberWithFloat:[values[i] floatValue]]:[NSNumber numberWithInt:[values[i] integerValue]];
        [self.roastProfileChars replaceObjectAtIndex:i withObject:dict];
    }
}

-(void) setLoadGreenBean:(NSInteger)greenBean loadRoastedBean:(NSInteger)roasted stop:(NSInteger)stop
{
    for(int i = 0 ; i < self.controlItemValues.count ; i ++) {
        NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:self.roastProfileChars[i]];
        
        dict[JSONRoastControlItemKey] = [NSNumber numberWithInt:0];
        dict[JSONRoastControlParameterKey] = [NSNumber numberWithInt:2];
        if(i == 0) {
            dict[JSONRoastControlParameterKey] = [NSNumber numberWithInt:4];
        } if(i == greenBean) {
            dict[JSONRoastControlItemKey] = [NSNumber numberWithInt:LoadGreenBeanItem];
            dict[JSONRoastControlParameterKey] = [NSNumber numberWithInt:4];
        } else if(i == roasted) {
            dict[JSONRoastControlItemKey] = [NSNumber numberWithInt:LoadRoastedBeanItem];
            dict[JSONRoastControlParameterKey] = [NSNumber numberWithInt:4];
        } else if(i == stop) {
             dict[JSONRoastControlItemKey] = [NSNumber numberWithInt:StopRoastItem];
        }
        [self.roastProfileChars replaceObjectAtIndex:i withObject:dict];
    }
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
        if([[self.controlItemValues objectAtIndex:i] intValue] == LoadGreenBeanItem) {
            return i;
        }
    }
    return 2;
}

#pragma mark - Output Bean
-(NSInteger) outPutBeanIndex
{
    for(int i = 0 ; i < self.controlItemValues.count ; i ++) {
        if([[self.controlItemValues objectAtIndex:i] intValue] == LoadRoastedBeanItem) {
            return i;
        }
    }
    return 10;
}

@end
