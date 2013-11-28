//
//  BeanProfileModel.h
//  CafeRoast
//
//  Created by Bai-Kai-Ren on 13/11/13.
//  Copyright (c) 2013年 Bai-Kai-Ren. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString *const JSONBeanProfileNameKey = @"beanProfileName";
static NSString *const JSONBeanLevelKey = @"level";
static NSString *const JSONBeanVarietiesKey = @"beanVarieties";
static NSString *const JSONBeanNameKey = @"beanName";
static NSString *const JSONBeanAreasKey = @"Areas";
static NSString *const JSONBeanCropYearKey = @"cropYear";
static NSString *const JSONBeanCountryKey = @"country";
static NSString *const JSONBeanProcessingKey = @"processing";
static NSString *const JSONBeanTypeKey = @"beanType";

@interface BeanProfile : NSObject

+(id) beanProfileWithDict:(NSDictionary *)dict;

@property(nonatomic) NSInteger level;
@property(nonatomic) NSInteger processing;
@property(nonatomic) NSInteger beanType;

@property(nonatomic, strong) NSString *beanProfileName;
@property(nonatomic, strong) NSString *beanVarieties;
@property(nonatomic, strong) NSString *beanName;
@property(nonatomic, strong) NSString *areas;
@property(nonatomic, strong) NSString *cropYear;
@property(nonatomic, strong) NSString *country;


@end
