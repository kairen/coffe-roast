//
//  DocumentsPaths.m
//  CoffeRoast_Project
//
//  Created by Bai-Kai-Ren on 2013/12/2.
//  Copyright (c) 2013年 Bai-Kai-Ren. All rights reserved.
//

#import "DocumentsPaths.h"

@implementation DocumentsPaths

+(NSString*) getDocumentByAppendingPathFile:(NSString *)file
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return [documentsDirectory stringByAppendingPathComponent:file];
}

+(NSString*) getDocumentAutoJsonPath
{
    return [DocumentsPaths getDocumentByAppendingPathFile:@"json_auto"];
}

+(NSString*) getDocumentProfileJsonPath
{
    return [DocumentsPaths getDocumentByAppendingPathFile:@"json_profile"];
}

+(NSString*) getDocumentHistoryJsonPath
{
    return [DocumentsPaths getDocumentByAppendingPathFile:@"json_history"];
}
@end
