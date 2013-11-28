//
//  RoastProfileModel.h
//  CafeRoast
//
//  Created by Bai-Kai-Ren on 13/11/13.
//  Copyright (c) 2013年 Bai-Kai-Ren. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RoastProfileChar.h"

static NSString *const JSONRoastProfileCharNameKey = @"RoastProfileChar";
static NSString *const JSONRoastFileNameKey = @"fileName";

typedef NS_ENUM(NSInteger, ControlItems) {
    ControlInputBean = 1,
    ControlOutputBean = 2,
    ControlStopBean = 4
};

@interface RoastProfile : NSObject;

+(id) roastProfileWithDict:(NSDictionary *)dict;


@property(nonatomic, strong) NSMutableArray *roastProfileChars;
@property(nonatomic, strong) NSString *fileName;


@end
