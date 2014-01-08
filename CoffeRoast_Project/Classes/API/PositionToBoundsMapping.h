//
//  PositionToBoundsMapping.h
//  CafeRoast
//
//  Created by Bai-Kai-Ren on 13/10/28.
//  Copyright (c) 2013年 Bai-Kai-Ren. All rights reserved.
//

@import UIKit;

@protocol ResizableDynamicItem <UIDynamicItem>
@property (nonatomic, readwrite) CGRect bounds;
@end

@interface PositionToBoundsMapping : NSObject <UIDynamicItem>

- (instancetype)initWithTarget:(id<ResizableDynamicItem>)target;

@end
