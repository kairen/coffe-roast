//
//  BasicAnimation.m
//  CafeRoast
//
//  Created by Bai-Kai-Ren on 2013/11/22.
//  Copyright (c) 2013年 Bai-Kai-Ren. All rights reserved.
//

#import "BasicAnimation.h"

@implementation BasicAnimation

#pragma mark - Shake Animation
+(void) shakeAnimationFor:(UIView*)view
{
    if ([view.layer animationForKey:kShakeAnimation] == nil)
    {
        CAKeyframeAnimation * anim = [ CAKeyframeAnimation animationWithKeyPath:@"transform" ] ;
        anim.values = @[ [ NSValue valueWithCATransform3D:CATransform3DMakeTranslation(-7.0f, 0.0f, 0.0f) ], [ NSValue valueWithCATransform3D:CATransform3DMakeTranslation(7.0f, 0.0f, 0.0f) ] ] ;
        anim.autoreverses = YES ;
        anim.repeatCount = MAXFLOAT;
        anim.duration = 0.1f ;
        [view.layer addAnimation:anim forKey:kShakeAnimation] ;
    }
}

#pragma mark - Pop Animation
+(void) popAnimationFor:(UIView*)view complete:(void (^)(void))complete
{
    CAKeyframeAnimation *popAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    popAnimation.duration = 0.4;
    popAnimation.values = @[[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.01f, 0.01f, 1.0f)],
                            [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.1f, 1.1f, 1.0f)],
                            [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9f, 0.9f, 1.0f)],
                            [NSValue valueWithCATransform3D:CATransform3DIdentity]];
    popAnimation.keyTimes = @[@0.2f, @0.5f, @0.75f, @1.0f];
    popAnimation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    view.alpha = 0.0;
    [UIView animateWithDuration:0.4 animations:^{
        view.alpha = 1.0;
    } completion:^(BOOL finish) {
        if(complete != nil) {
            complete();
        }
    }];
    [view.layer addAnimation:popAnimation forKey:nil];
}

#pragma mark - Hidden Pop Animation
+(void) hiddenPopAnimationFor:(UIView*)view complete:(void(^)(void))complete
{
    CAKeyframeAnimation *hideAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    hideAnimation.duration = 0.4 ;
    hideAnimation.values = @[[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.1f, 1.1f, 1.1f)],
                             [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0f, 1.0f, 1.0f)],
                             [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.5f, 0.5f, 1.0f)],
                             [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.0f, 0.0f, 1.0f)]];
    hideAnimation.keyTimes = @[@0.2f, @0.5f, @0.75f, @1.0f];
    hideAnimation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    hideAnimation.delegate = view;
    [UIView animateWithDuration:0.4 animations:^{
        view.alpha = 0.0;
    }completion:^(BOOL finished) {
        if(complete != nil) {
            complete();
        }
    }];
    [view.layer addAnimation:hideAnimation forKey:nil];
}

+(void) alphaAnimationFor:(UIView *)view hidden:(BOOL)hide
{
    if(hide) {
        [UIView animateWithDuration:0.3 animations:^{
            view.alpha = 0.0;
        }];
    } else {
        [UIView animateWithDuration:0.3 animations:^{
            view.alpha = 1.0;
        }];
    }
}

@end
