//
//  ALLModels.h
//  CoffeRoast_Project
//
//  Created by Bai-Kai-Ren on 2013/12/23.
//  Copyright (c) 2013年 Bai-Kai-Ren. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RoastJSONModel.h"

static NSString *const IPAddressKey = @"AddressKey";
static NSString *const IPPortKey = @"PortKey";
static NSString *const SyncConnectKey = @"SyncConnectKey";
static NSString *const RoastStatusKey = @"RoastStatusKey";

static NSString *const DeviceInfoKey = @"DeviceInfoKey";

typedef NS_ENUM(NSUInteger, RoastStatus) {
    RoastStopStatus = 0,
    RoastRunStatus = 1,
    RoastCoolingStatus = 2,
};

@interface ALLModels : NSObject

+(NSArray*) editorTitles;
+(NSArray*) editorTitleVauleKeys;
+(NSArray*) historyTitles;

+(NSArray*) settingTitles;
+(NSString*) ipAddress;
+(NSString*) ipPort;
+(NSArray*) deviceInfos;

+(NSString*) getNowDate:(NSString*)format;

+(void) saveIPAddress:(NSString*)address port:(NSString*)port;
+(void) saveDeviceInfo:(NSString*)info;

+(void) saveLasySyncConnectStatus:(BOOL)status;
+(BOOL) syncConnected;

+(void) saveLasyRoastStatus:(RoastStatus)status;
+(RoastStatus) roastRunedStatus;
@end
