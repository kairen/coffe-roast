//
//  PressGestureEvent.h
//  CafeRoast
//
//  Created by Bai-Kai-Ren on 13/9/23.
//  Copyright (c) 2013年 Bai-Kai-Ren. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MenuView;

@interface SwipeObjectEvent : NSObject

+(id) swipeObjectEventEventInView:(MenuView*)menuView ;

-(void) startReceiveEvent;

@end
