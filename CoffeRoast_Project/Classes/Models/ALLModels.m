//
//  ALLModels.m
//  CoffeRoast_Project
//
//  Created by Bai-Kai-Ren on 2013/12/23.
//  Copyright (c) 2013年 Bai-Kai-Ren. All rights reserved.
//

#import "ALLModels.h"


static NSString *const DefaultIPAddress = @"192.168.1.180";
static NSString *const DefaultIPPort = @"4660";

static NSString const *editorTitles[12]  =
{
    @"Profile Name",@"Editor",@"Grading List",@"Date",
    @"Bean Name",@"Bean Type",@"Bean Varieties",
    @"Country",@"Crop Year",@"Processing",@"Level",
    @"Note",
};

static NSString const *HistoryTitles[5] =
{
    @"Date",@"Editor",@"Bean Name",
    @"Bean Type",@"Country",
};

static NSString const *SettingTitles[6] =
{
    @"IP Address",@"IP Port",@"Model Name",@"Device Serial No",
    @"Firmware Version ",@"PCB info",
};

@implementation ALLModels

+(NSArray*) editorTitles
{
     return [NSArray arrayWithObjects:editorTitles count:(sizeof(editorTitles) / sizeof(int))];
}

+(NSArray*) editorTitleVauleKeys
{
    return @[JSONProfileNameKey,JSONEditorKey,JSONGradingListKey,JSONDateKey,JSONBeanNameKey,
             JSONBeanTypeKey,JSONBeanVarietiesKey,JSONBeanCountryKey,
             JSONBeanCropYearKey,JSONBeanProcessingKey,JSONBeanLevelKey,JSONNoteKey];
}

+(NSArray*) historyTitles
{
    return [NSArray arrayWithObjects:HistoryTitles count:(sizeof(HistoryTitles) / sizeof(int))];
}

+(NSArray*) settingTitles
{
     return [NSArray arrayWithObjects:SettingTitles count:(sizeof(SettingTitles) / sizeof(int))];
}

+(NSString*) ipAddress
{
    if(![[NSUserDefaults standardUserDefaults] objectForKey:IPAddressKey]) {
        [[NSUserDefaults standardUserDefaults] setObject:DefaultIPAddress forKey:IPAddressKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
        return DefaultIPAddress;
    }
    else {
         return [[NSUserDefaults standardUserDefaults]objectForKey:IPAddressKey];
    }
}

+(NSString*) ipPort
{
    if(![[NSUserDefaults standardUserDefaults] objectForKey:IPPortKey]) {
        [[NSUserDefaults standardUserDefaults] setObject:DefaultIPPort forKey:IPPortKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
        return DefaultIPPort;
    }
    else {
        return [[NSUserDefaults standardUserDefaults]objectForKey:IPPortKey];
    }
}

+(void) saveIPAddress:(NSString *)address port:(NSString *)port
{
    [[NSUserDefaults standardUserDefaults] setObject:address forKey:IPAddressKey];
    [[NSUserDefaults standardUserDefaults] setObject:port forKey:IPPortKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+(void) saveLasySyncConnectStatus:(BOOL)status
{
    [[NSUserDefaults standardUserDefaults] setBool:status forKey:SyncConnectKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+(void) saveDeviceInfo:(NSString *)info
{
    [[NSUserDefaults standardUserDefaults] setObject:info forKey:DeviceInfoKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+(BOOL) syncConnected
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:SyncConnectKey];
}

+(void) saveLasyRoastStatus:(RoastStatus)status
{
    [[NSUserDefaults standardUserDefaults] setInteger:status forKey:RoastStatusKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+(RoastStatus) roastRunedStatus
{
    return [[NSUserDefaults standardUserDefaults] integerForKey:RoastStatusKey];
}

+(NSArray*) deviceInfos
{
    return [[[NSUserDefaults standardUserDefaults] stringForKey:DeviceInfoKey] componentsSeparatedByString:@","];
}

+(NSString*) getNowDate:(NSString *)format
{
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    return [formatter stringFromDate:date];
}

@end
