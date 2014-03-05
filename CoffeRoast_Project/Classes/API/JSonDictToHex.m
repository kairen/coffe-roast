//
//  JSonDictToHex.m
//  CoffeRoast_Project
//
//  Created by Bai-Kai-Ren on 2014/2/24.
//  Copyright (c) 2014年 Bai-Kai-Ren. All rights reserved.
//

#import "JSonDictToHex.h"
#import "RoastJSONModel.h"


@implementation JSonDictToHex

+(NSData*) roastJsonDictToHexData:(NSDictionary*) dict
{
    NSArray *infoKeys = @[JSONProfileNameKey,JSONEditorKey,JSONDateKey,JSONMultiProfileKey,JSONGradingListKey,JSONNextProfileNameKey];
    int infoLegth[] = {16,16,9,1,1,16};
    int infoOffset[] = {0,16,32,41,42,91};
    
    NSMutableData *data = [NSMutableData dataWithLength:768];
    
    int i = 0;
    for(NSString *key in infoKeys) {
        NSData *keyData;
        if([dict[key] isKindOfClass:[NSNumber class]]) {
            int value = [dict[key] intValue];
            keyData = [NSData dataWithBytes:&value length:1];
        } else if([key isEqualToString:JSONDateKey]){
            keyData = [self stringToHexData:dict[key]];
        } else   {
            keyData = [dict[key] dataUsingEncoding:NSASCIIStringEncoding];
        }
        if(keyData) {
            [data replaceBytesInRange:NSMakeRange(infoOffset[i], infoLegth[i]) withBytes:[keyData bytes]];
        }
        i++;
    }
    
    NSDictionary *beanDict = [dict objectForKey:JSONBeanProfileKey];
    i = 0;
    NSArray *bInfoKey = @[JSONBeanNameKey,JSONBeanTypeKey,JSONBeanVarietiesKey,JSONBeanCountryKey,JSONBeanAreasKey,JSONBeanProcessingKey,JSONBeanCropYearKey,JSONBeanLevelKey];
    int bInfoLegth[] = {16,1,16,16,16,1,7,1};
    int bInfoOffset[] = {16,32,33,49,65,81,82,89};
    
    for(NSString *key in bInfoKey) {
        NSData *keyData;
        if([beanDict[key] isKindOfClass:[NSNumber class]]) {
            int value = [beanDict[key] intValue];
            keyData = [NSData dataWithBytes:&value length:1];
        } else if([key isEqualToString:JSONBeanCropYearKey]){
            keyData = [self stringToHexData:beanDict[key]];
        } else   {
            keyData = [beanDict[key] dataUsingEncoding:NSASCIIStringEncoding];
        }
        if(keyData) {
             [data replaceBytesInRange:NSMakeRange(128 + bInfoOffset[i], bInfoLegth[i]) withBytes:[keyData bytes]];
        }
        i++;
    }
    
    NSArray *cChartInfos = [dict[JSONRoastProfileKey] objectForKey:JSONRoastProfileCharKey];
    NSArray *cInfoKey = @[JSONRoastAliasKey,JSONRoastStageNoKey,JSONRoastTemperatureKey,JSONRoastTimeKey,JSONRoastRollerSpeedKey,JSONRoastWindSpeedKey,JSONRoastControlParameterKey,JSONRoastControlItemKey];
    i = 0;
    for(NSDictionary *cDict in cChartInfos) {
        NSMutableData *keyData = [NSMutableData data];
        for(NSString *key in cInfoKey) {
            if([cDict[key] isKindOfClass:[NSNumber class]]) {
                int value = [cDict[key] intValue];
                [keyData appendBytes:&value length:1];
            }
        }
        if(keyData) {
           [data replaceBytesInRange:NSMakeRange(320 + (i * 16), 16) withBytes:[keyData bytes]];
        }
        i++;
    }
    
    return data;
}

+(NSData*) stringToHexData:(NSString*)string
{
    NSMutableData *data = [NSMutableData data];
    for(int idx = 0; idx <= string.length - 2; idx+=2) {
        unsigned int intValue = [[string substringWithRange:NSMakeRange(idx, 2)] intValue];
        [data appendBytes:&intValue length:1];
    }
    return data;
}

+(NSString*) stringToHexString:(NSString*)string
{
    NSMutableString *hex = [NSMutableString string];
    for(int idx = 0; idx <= string.length - 2; idx+=2) {
        unsigned int intValue = [[string substringWithRange:NSMakeRange(idx, 2)] intValue];
        [hex appendFormat:@"%02x",intValue];
    }
    return hex;
}

+(NSString*) dataToHexString:(NSData *)data
{
    NSUInteger capacity = [data length] * 2;
    NSMutableString *stringBuffer = [NSMutableString stringWithCapacity:capacity];
    const unsigned char *dataBuffer = [data bytes];
    NSInteger i;
    for (i = 0; i < [data length]; ++i) {
        [stringBuffer appendFormat:@"%02lX", (unsigned long)dataBuffer[i]];
    }
    return stringBuffer;
}

@end
