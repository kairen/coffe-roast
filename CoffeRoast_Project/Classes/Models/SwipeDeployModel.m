//
//  UIConfigurationModel.m
//  CafeRoast
//
//  Created by Bai-Kai-Ren on 13/9/30.
//  Copyright (c) 2013年 Bai-Kai-Ren. All rights reserved.
//

#import "SwipeDeployModel.h"

//UserDefualt Objects Keys
static  NSString *DefaultButtonInfos = @"ButtonInfos";
static  NSString *DefaultNotFirstLaunch = @"NotFirstLaunch";

// Range 0 ~ 11 and no repeat
static const NSString *DefaultEnterFrams[6]  =
{
    @"0",@"1",@"2",@"3",@"4",@"5"
};

@interface SwipeDeployModel ()

@property(nonatomic,readonly) NSArray *arrayOfFrameTag;
@end

@implementation SwipeDeployModel


+(id) defaultConfiguration
{
    return [[self alloc]init];
}

-(id) init
{
    self = [super init];
    if(self) {
       if([[NSUserDefaults standardUserDefaults] boolForKey:DefaultNotFirstLaunch]) {
           _arrayOfFrameTag = [self readDefaultButtonFrame];
       }
       else {
           _arrayOfFrameTag = [self saveDefaultButtonFrame];
       }
    }
    return self;
}

-(void) setArrayOfFrameTag:(NSArray *)arrayOfFrameTag
{
    if(_arrayOfFrameTag == nil) {
        _arrayOfFrameTag = arrayOfFrameTag;
    }
}

#pragma mark - Return Button Frame Tags
-(NSArray*) configurationButtonFrameTags
{
    return self.arrayOfFrameTag;
}

#pragma mark - Save Default Button Frames
-(NSArray*) saveDefaultButtonFrame
{
    NSArray *frames = [NSArray arrayWithObjects:DefaultEnterFrams count:(sizeof(DefaultEnterFrams) / sizeof(int))];
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setObject:frames forKey:DefaultButtonInfos];
    [userDefault setBool:YES forKey:DefaultNotFirstLaunch];
    [userDefault synchronize];
    return frames;
}

-(NSArray*) readDefaultButtonFrame
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:DefaultButtonInfos];
}

+ (void) saveConfigurationWithFrames:(NSArray*)frames
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setObject:frames forKey:DefaultButtonInfos];
    [userDefault synchronize];
}

@end
