//
//  BeanProfileModel.m
//  CafeRoast
//
//  Created by Bai-Kai-Ren on 13/11/13.
//  Copyright (c) 2013年 Bai-Kai-Ren. All rights reserved.
//

#import "BeanProfile.h"


@implementation BeanProfile

+(id) beanProfileWithDict:(NSDictionary *)dict
{
    return [[self alloc]initWithDict:dict];
}

-(id) initWithDict:(NSDictionary*)dict
{
    self = [super init];
    if(self) {
        _beanProfileName = [dict objectForKey:JSONBeanProfileNameKey];
        _level = [[dict objectForKey:JSONBeanLevelKey] integerValue];
        _beanVarieties = [dict objectForKey:JSONBeanVarietiesKey];
        _beanName = [dict objectForKey:JSONBeanNameKey];
        _areas = [dict objectForKey:JSONBeanAreasKey];
        _cropYear = [dict objectForKey:JSONBeanCropYearKey];
        _country = [dict objectForKey:JSONBeanCountryKey];
        _processing = [[dict objectForKey:JSONBeanProcessingKey] integerValue];
        _beanType = [[dict objectForKey:JSONBeanTypeKey] integerValue];
    }
    return self;
}


@end
