//
//  BaseController.h
//  CoffeRoast_Project
//
//  Created by Bai-Kai-Ren on 2013/11/28.
//  Copyright (c) 2013年 Bai-Kai-Ren. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>
#import "DocumentsPaths.h"
#import "RoastJSONModel.h"
#import "ALLModels.h"

@class BaseController;


@interface BaseController : UIViewController 

@property(nonatomic,readonly) CGRect frame;

-(void) dismissViewController;
-(void) playAudioWithFile:(NSString*)file;
-(void) dynamicAnimatorAction:(id)sender;
    
@end

