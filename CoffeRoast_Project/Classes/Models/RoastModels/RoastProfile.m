//
//  RoastProfileModel.m
//  CafeRoast
//
//  Created by Bai-Kai-Ren on 13/11/13.
//  Copyright (c) 2013年 Bai-Kai-Ren. All rights reserved.
//

#import "RoastProfile.h"

@implementation RoastProfile

+(id) roastProfileWithDict:(NSDictionary *)dict
{
    return [[self alloc]initWithDict:dict];
}

-(id) initWithDict:(NSDictionary*)dict
{
    self = [super init];
    if(self) {
        _roastProfileChars = [dict objectForKey:JSONRoastProfileCharNameKey];
       _fileName = [dict objectForKey:JSONRoastFileNameKey];
    }
    return self;
}




@end
