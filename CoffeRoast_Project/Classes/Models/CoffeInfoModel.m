//
//  CoffeInfoModel.m
//  CoffeRoast_Project
//
//  Created by Bai-Kai-Ren on 2014/2/27.
//  Copyright (c) 2014年 Bai-Kai-Ren. All rights reserved.
//

#import "CoffeInfoModel.h"

static NSString *keys[] = {
  @"Country",@"Variety",@"GradingList",@"Processing",@"BeanType"
};

typedef NS_ENUM(NSUInteger, CoffeInfoType) {
    CoffeInfoCountry = 0,
    CoffeInfoVariety,
    CoffeInfoGradingList,
    CoffeinfoProcessing,
    CoffeinfoBeanType,
};

@implementation CoffeInfoModel

+(NSDictionary*) getCountryWithDict:(NSDictionary *)dict
{
    return dict[keys[CoffeInfoCountry]];
}

+(NSArray*) getVarietyWithDict:(NSDictionary *)dict
{
    return dict[keys[CoffeInfoVariety]];
}

+(NSDictionary*) getGradingListWithDict:(NSDictionary *)dict
{
    return dict[keys[CoffeInfoGradingList]];
}

+(NSDictionary*) getProcessingWithDict:(NSDictionary *)dict
{
    return dict[keys[CoffeinfoProcessing]];
}

+(NSDictionary*) getBeanTypeWithDict:(NSDictionary *)dict
{
    return dict[keys[CoffeinfoBeanType]];
}


@end

