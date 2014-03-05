//
//  BaseController.h
//  CoffeRoast_Project
//
//  Created by Bai-Kai-Ren on 2013/11/28.
//  Copyright (c) 2013年 Bai-Kai-Ren. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "DocumentsPaths.h"
#import "RoastJSONModel.h"
#import "SocketHadler.h"
#import "ALLModels.h"
#import "ReadStatusModel.h"
#import "DeviceInfoModel.h"
#import "JSonDictToHex.h"
#import "CoffeInfoModel.h"

@class BaseController;


@interface BaseController : UIViewController 

@property(nonatomic,readonly) CGRect frame;

-(void) dismissViewController;
-(void) playAudioWithFile:(NSString*)file;
@end

