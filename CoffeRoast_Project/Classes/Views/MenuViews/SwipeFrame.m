//
//  SwipeFrame.m
//  CoffeRoast_Project
//
//  Created by Bai-Kai-Ren on 2013/11/28.
//  Copyright (c) 2013年 Bai-Kai-Ren. All rights reserved.
//

#import "SwipeFrame.h"

@implementation SwipeFrame

+(SwipeFrame*) getSwipeFrame:(CGRect)frame
{
    SwipeFrame *swipeFrame = [[self alloc]initWithSwipeFrame:frame];
    return swipeFrame;
    swipeFrame = nil;
}

-(id) initWithSwipeFrame:(CGRect)frame
{
    self = [super init];
    if(self) {
        self.isUse = NO;
        self.frame = frame;
    }
    return self;
}

@end
