//
//  JSonDictToHex.h
//  CoffeRoast_Project
//
//  Created by Bai-Kai-Ren on 2014/2/24.
//  Copyright (c) 2014年 Bai-Kai-Ren. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JSonDictToHex : NSObject

+(NSData*) stringToHexData:(NSString*)string;
+(NSString*) stringToHexString:(NSString*)string;
+(NSData*) roastJsonDictToHexData:(NSDictionary*) dict;
+(NSString*) dataToHexString:(NSData*)data;

@end
