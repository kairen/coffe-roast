//
//  ManualEvents.h
//  CoffeRoast_Project
//
//  Created by Bai-Kai-Ren on 2014/2/23.
//  Copyright (c) 2014年 Bai-Kai-Ren. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ManualController;

@interface ManualEvents : NSObject

-(id) initWithManualController:(ManualController*)controller;

@property(nonatomic, weak) ManualController *manualController;

@end
