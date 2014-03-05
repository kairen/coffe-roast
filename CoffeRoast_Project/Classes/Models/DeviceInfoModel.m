//
//  DeviceInfoModel.m
//  CoffeRoast_Project
//
//  Created by Bai-Kai-Ren on 2014/2/21.
//  Copyright (c) 2014年 Bai-Kai-Ren. All rights reserved.
//

#import "DeviceInfoModel.h"

@implementation DeviceInfoModel

+(NSString*) deviceModelAtData:(NSData *)data
{
    NSString *deviceInfoOne = [[NSString alloc]initWithData:[data subdataWithRange:NSMakeRange(0, 8)] encoding:NSUTF8StringEncoding];
    NSString *deviceInfoTwo = [[NSString alloc]initWithData:[data subdataWithRange:NSMakeRange(8, 8)] encoding:NSUTF8StringEncoding];
    return [NSString stringWithFormat:@"%@,%@",deviceInfoOne,deviceInfoTwo];
}

+(NSString*) deviceUseStatusAtData:(NSData *)data
{
    NSString *use = [[NSString alloc]initWithData:[data subdataWithRange:NSMakeRange(0, 2)] encoding:NSUTF8StringEncoding];
    NSString *heaterUser = [[NSString alloc]initWithData:[data subdataWithRange:NSMakeRange(2, 4)] encoding:NSUTF8StringEncoding];
    NSString *totalUse = [[NSString alloc]initWithData:[data subdataWithRange:NSMakeRange(6, 4)] encoding:NSUTF8StringEncoding];
    return [NSString stringWithFormat:@"Total Used : %@ ,Heater use Time: %@ ,Total Use Time : %@",use,heaterUser,totalUse];
}

@end
