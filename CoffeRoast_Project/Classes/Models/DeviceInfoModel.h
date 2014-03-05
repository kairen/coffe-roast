//
//  DeviceInfoModel.h
//  CoffeRoast_Project
//
//  Created by Bai-Kai-Ren on 2014/2/21.
//  Copyright (c) 2014年 Bai-Kai-Ren. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DeviceInfoModel : NSObject


+(NSString*) deviceModelAtData:(NSData*)data;
+(NSString*) deviceUseStatusAtData:(NSData *)data;
@end
