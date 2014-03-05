//
//  UIColor+Category.m
//  ProPhetStor_Net
//
//  Created by Bai-Kai-Ren on 2014/2/13.
//  Copyright (c) 2014年 Bai-Kai-Ren. All rights reserved.
//

#import "UIColor+Category.h"

@implementation UIColor (Category)

+(UIColor*) colorWithIntegerRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue 
{
    return [UIColor colorWithRed:red / 255 green:green / 255 blue:blue / 255 alpha:1.0];
}

@end
