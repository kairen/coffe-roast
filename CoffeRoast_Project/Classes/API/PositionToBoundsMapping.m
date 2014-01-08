//
//  PositionToBoundsMapping.m
//  CafeRoast
//
//  Created by Bai-Kai-Ren on 13/10/28.
//  Copyright (c) 2013年 Bai-Kai-Ren. All rights reserved.
//

#import "PositionToBoundsMapping.h"

@interface PositionToBoundsMapping ()
@property (nonatomic, strong) id<ResizableDynamicItem> target;

@end

@implementation PositionToBoundsMapping

- (instancetype)initWithTarget:(id<ResizableDynamicItem>)target
{
    self = [super init];
    if (self)
    {
        _target = target;
    }
    return self;
}

#pragma mark -
#pragma mark UIDynamicItem

- (CGRect)bounds
{
    return self.target.bounds;
}

- (CGPoint)center
{
    return CGPointMake(self.target.bounds.size.width, self.target.bounds.size.height);
}

- (void)setCenter:(CGPoint)center
{
    self.target.bounds = CGRectMake(0, 0, center.x, center.y);
}

- (CGAffineTransform)transform
{
    
    return self.target.transform;
}

- (void)setTransform:(CGAffineTransform)transform
{
    self.target.transform = transform;
}

@end
