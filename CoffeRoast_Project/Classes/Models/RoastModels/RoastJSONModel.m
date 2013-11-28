//
//  BakingCurveModel.m
//  CafeRoast
//
//  Created by Bai-Kai-Ren on 13/11/13.
//  Copyright (c) 2013年 Bai-Kai-Ren. All rights reserved.
//

#import "RoastJSONModel.h"


@implementation RoastJSONModel

+(id) roastJSONDataWithDict:(NSDictionary*)dict
{
    return [[self alloc]initWithDict:dict];
}

-(id) initWithDict:(NSDictionary*)dict
{
    self = [super init];
    if(self) {
        _gradingList = [[dict objectForKey:JSONGradingListKey] integerValue];
        _multiProfile = [[dict objectForKey:JSONMultiProfileKey] integerValue];
        
        _bLoaderInfo = [dict objectForKey:JSONBLoaderInfoKey];
        _uLoaderInfo = [dict objectForKey:JSONULoaderInfoKey];
        _path = [dict objectForKey:JSONPathKey];
        _roastProfileName = [dict objectForKey:JSONRoastProfileNameKey];
        _profileName = [dict objectForKey:JSONProfileNameKey];
        _editor = [dict objectForKey:JSONEditorKey];
        _beanProfileName = [dict objectForKey:JSONBeanProfileName];
        _date = [dict objectForKey:JSONDateKey];
        
        _roastProfile = [dict objectForKey:JSONRoastProfileKey];
        _beanProfile = [dict objectForKey:JSONBeanProfileKey];
    }
    return self;
}


@end
