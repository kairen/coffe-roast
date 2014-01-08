//
//  ALLModels.h
//  CoffeRoast_Project
//
//  Created by Bai-Kai-Ren on 2013/12/23.
//  Copyright (c) 2013年 Bai-Kai-Ren. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RoastJSONModel.h"

@interface ALLModels : NSObject

+(NSArray*) editorTitles;
+(NSArray*) editorTitleVauleKeys;
+(NSArray*) historyTitles;


+(NSString*) ipAddress;
+(NSString*) ipPort;

+(void) saveIPAddress:(NSString*)address port:(NSString*)port;

@end
