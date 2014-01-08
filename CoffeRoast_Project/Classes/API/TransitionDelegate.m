//
//  TransitionDelegate.m
//  CoffeRoast_Project
//
//  Created by Bai-Kai-Ren on 2013/12/18.
//  Copyright (c) 2013年 Bai-Kai-Ren. All rights reserved.
//

#import "TransitionDelegate.h"
#import "TransitionAnimation.h"


@implementation TransitionDelegate

#pragma mark - 
-(id<UIViewControllerAnimatedTransitioning>) animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    TransitionAnimation *transition = [TransitionAnimation new];
    return transition;
}

#pragma mark - DismissedController Animation
-(id<UIViewControllerAnimatedTransitioning>) animationControllerForDismissedController:(UIViewController *)dismissed
{
    TransitionAnimation *transition = [TransitionAnimation new];
    transition.reverse = YES;
    return transition;
}

@end
