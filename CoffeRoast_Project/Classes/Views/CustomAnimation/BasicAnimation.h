//
//  BasicAnimation.h
//  CafeRoast
//
//  Created by Bai-Kai-Ren on 2013/11/22.
//  Copyright (c) 2013年 Bai-Kai-Ren. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString * const kShakeAnimation = @"ShakeAnimation";

@interface BasicAnimation : NSObject


+(void) shakeAnimationFor:(UIView*)view;

+(void) popAnimationFor:(UIView*)view complete:(void(^)(void))complete;
+(void) hiddenPopAnimationFor:(UIView*)view complete:(void(^)(void))complete;

+(void) alphaAnimationFor:(UIView*) view hidden:(BOOL)hide;
@end
