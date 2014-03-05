//
//  ManualModel.h
//  CoffeRoast_Project
//
//  Created by Bai-Kai-Ren on 2014/2/20.
//  Copyright (c) 2014年 Bai-Kai-Ren. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, ReadRoastType) {
    ReadRoastMode = 0,
    ReadRoastStage ,
    ReadRoastTime ,
    ReadITemperature,
    ReadRollerSpeed,
    ReadFanSpeed,
    ReadRoastStatus,
    ReadComponentStatus,
    ReadPopSoundQuantity,
    ReadHeaterPowerLevel,
    ReadRoastLevel,
    ReadPredictTemperature,
};

@interface ReadStatusModel : NSObject

+(NSArray*) readAllStatusWithData:(NSData*)hexData;
+(NSInteger) readValueAtType:(ReadRoastType)type withDatas:(NSArray*)datas;

+(NSString*) readRoastTimeAtDatas:(NSArray*)datas;
+(NSInteger) readRoastWindAtDatas:(NSArray*)datas;
+(NSInteger) readRoastRollerAtDatas:(NSArray*)datas;
+(CGFloat) readRoastTempAtDatas:(NSArray*)datas;
+(NSInteger) readRoastStageAtDatas:(NSArray*)datas;
+(NSInteger) readRoastStatusAtDatas:(NSArray*)datas;
@end
