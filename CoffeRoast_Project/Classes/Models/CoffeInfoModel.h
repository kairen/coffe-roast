//
//  CoffeInfoModel.h
//  CoffeRoast_Project
//
//  Created by Bai-Kai-Ren on 2014/2/27.
//  Copyright (c) 2014年 Bai-Kai-Ren. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface CoffeInfoModel : NSObject

+(NSDictionary*) getCountryWithDict:(NSDictionary*)dict;
+(NSArray*) getVarietyWithDict:(NSDictionary*)dict;
+(NSDictionary*) getGradingListWithDict:(NSDictionary*)dict;
+(NSDictionary*) getProcessingWithDict:(NSDictionary*)dict;
+(NSDictionary*) getBeanTypeWithDict:(NSDictionary*)dict;
@end
