//
//  ALLModels.m
//  CoffeRoast_Project
//
//  Created by Bai-Kai-Ren on 2013/12/23.
//  Copyright (c) 2013年 Bai-Kai-Ren. All rights reserved.
//

#import "ALLModels.h"

static NSString *const IPAddressKey = @"AddressKey";
static NSString *const IPPortKey = @"PortKey";
static NSString *const DefaultIPAddress = @"192.168.1.180";
static NSString *const DefaultIPPort = @"4660";

static NSString const *editorTitles[13]  =
{
    @"Profile Name",@"Editor",@"Grading List",@"Date",
    @"Bean Name",@"Bean Type",@"Bean Varieties",@"Arean",
    @"Country",@"Crop Year",@"Processing",@"Level",
    @"Note",
};

static NSString const *HistoryTitles[5] =
{
    @"Date",@"Editor",@"Bean Name",
    @"Bean Type",@"Country",
};

@implementation ALLModels

+(NSArray*) editorTitles
{
     return [NSArray arrayWithObjects:editorTitles count:(sizeof(editorTitles) / sizeof(int))];
}

+(NSArray*) editorTitleVauleKeys
{
    return @[JSONProfileNameKey,JSONEditorKey,JSONGradingListKey,JSONDateKey,JSONBeanNameKey,
             JSONBeanTypeKey,JSONBeanVarietiesKey,JSONBeanAreasKey,JSONBeanCountryKey,
             JSONBeanCropYearKey,JSONBeanProcessingKey,JSONBeanLevelKey,JSONNoteKey];
}

+(NSArray*) historyTitles
{
    return [NSArray arrayWithObjects:HistoryTitles count:(sizeof(HistoryTitles) / sizeof(int))];
}

+(NSString*) ipAddress
{
    if(![[NSUserDefaults standardUserDefaults]objectForKey:IPAddressKey]) {
        NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
        [userDefault setObject:DefaultIPAddress forKey:IPAddressKey];
        [userDefault synchronize];
        return DefaultIPAddress;
    }
    else {
         return [[NSUserDefaults standardUserDefaults]objectForKey:IPAddressKey];
    }
}

+(NSString*) ipPort
{
    if(![[NSUserDefaults standardUserDefaults]objectForKey:IPPortKey]) {
        NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
        [userDefault setObject:DefaultIPPort forKey:IPPortKey];
        [userDefault synchronize];
        return DefaultIPPort;
    }
    else {
        return [[NSUserDefaults standardUserDefaults]objectForKey:IPPortKey];
    }
}

+(void) saveIPAddress:(NSString *)address port:(NSString *)port
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setObject:address forKey:IPAddressKey];
    [userDefault setObject:port forKey:IPPortKey];
    [userDefault synchronize];
}

@end
