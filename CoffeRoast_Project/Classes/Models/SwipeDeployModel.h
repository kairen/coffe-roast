//
//  UIConfigurationModel.h
//  CafeRoast
//
//  Created by Bai-Kai-Ren on 13/9/30.
//  Copyright (c) 2013年 Bai-Kai-Ren. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SwipeDeployModel : NSObject

+(id) defaultConfiguration;

-(NSArray*) configurationButtonFrameTags;

+ (void) saveConfigurationWithFrames:(NSArray*)frames;

@end
