//
//  UIImage+LoadFileImage.m
//  CoffeRoast_Project
//
//  Created by Bai-Kai-Ren on 2014/2/26.
//  Copyright (c) 2014年 Bai-Kai-Ren. All rights reserved.
//

#import "UIImage+LoadFileImage.h"

@implementation UIImage (LoadFileImage)

+(UIImage*)loadFileImageName:(NSString*)name
{
    return [UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:name ofType:nil]];
}

@end
