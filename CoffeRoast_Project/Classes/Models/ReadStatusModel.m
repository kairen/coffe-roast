//
//  ManualModel.m
//  CoffeRoast_Project
//
//  Created by Bai-Kai-Ren on 2014/2/20.
//  Copyright (c) 2014年 Bai-Kai-Ren. All rights reserved.
//

#import "ReadStatusModel.h"

@implementation ReadStatusModel


+(NSArray*) readAllStatusWithData:(NSData *)hexData
{
    Byte *byte = (Byte *)[hexData bytes];
    NSMutableArray *hexValues = [NSMutableArray array];
    for(int i = 0 ; i < hexData.length ; i += 2) {
        Byte data[] = {byte[i+1],byte[i]};
        int value = 0;
        [[NSData dataWithBytes:data length:sizeof(data)] getBytes:&value length:sizeof(value)];
        [hexValues addObject:[NSNumber numberWithInt:value]];
    }
    return hexValues;
}

+(NSInteger) readValueAtType:(ReadRoastType)type withDatas:(NSArray *)datas
{
    return [datas[type] integerValue];
}

+(NSString*) readRoastTimeAtDatas:(NSArray *)datas
{
    return [NSString stringWithFormat:@"%02ld : %02d",[datas[ReadRoastTime] integerValue] / 60,[datas[ReadRoastTime] integerValue] % 60];
}

+(NSInteger) readRoastWindAtDatas:(NSArray *)datas
{
    return [datas[ReadFanSpeed] integerValue];
}

+(CGFloat) readRoastTempAtDatas:(NSArray *)datas
{
    return [datas[ReadITemperature] floatValue] * 0.1;
}

+(NSInteger) readRoastRollerAtDatas:(NSArray *)datas
{
    return [datas[ReadRollerSpeed]integerValue];
}

+(NSInteger) readRoastStageAtDatas:(NSArray*)datas
{
    return [datas[ReadRoastStage] integerValue];
}

+(NSInteger) readRoastStatusAtDatas:(NSArray*)datas
{
    return [datas[ReadRoastStatus] integerValue];
}

@end
