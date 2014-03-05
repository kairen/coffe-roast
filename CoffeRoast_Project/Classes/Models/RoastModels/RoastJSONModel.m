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
        _roastJsonDict = [NSMutableDictionary dictionaryWithDictionary:dict];

        _gradingList = [[_roastJsonDict objectForKey:JSONGradingListKey] integerValue];
        _multiProfile = [[_roastJsonDict objectForKey:JSONMultiProfileKey] integerValue];
        
        _nextProfileName = [_roastJsonDict objectForKey:JSONNextProfileNameKey];
        _profileName = [_roastJsonDict objectForKey:JSONProfileNameKey];
        _editor = [_roastJsonDict objectForKey:JSONEditorKey];
        _date = [_roastJsonDict objectForKey:JSONDateKey];
        
        _roastProfiles = [_roastJsonDict objectForKey:JSONRoastProfileKey];
        _beanProfiles = [_roastJsonDict objectForKey:JSONBeanProfileKey];
        
    }
    return self;
}

-(void) reloadRoastJSonData
{
    
    _gradingList = [[_roastJsonDict objectForKey:JSONGradingListKey] integerValue];
    _multiProfile = [[_roastJsonDict objectForKey:JSONMultiProfileKey] integerValue];
    
    _nextProfileName = [_roastJsonDict objectForKey:JSONNextProfileNameKey];
    _profileName = [_roastJsonDict objectForKey:JSONProfileNameKey];
    _editor = [_roastJsonDict objectForKey:JSONEditorKey];
    _date = [_roastJsonDict objectForKey:JSONDateKey];
    
    _roastProfiles = [_roastJsonDict objectForKey:JSONRoastProfileKey];
    _beanProfiles = [_roastJsonDict objectForKey:JSONBeanProfileKey];
}

@end
