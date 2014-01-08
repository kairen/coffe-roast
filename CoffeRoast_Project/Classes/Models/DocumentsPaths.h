//
//  DocumentsPaths.h
//  CoffeRoast_Project
//
//  Created by Bai-Kai-Ren on 2013/12/2.
//  Copyright (c) 2013年 Bai-Kai-Ren. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DocumentsPaths : NSObject

+(NSString*) getDocumentByAppendingPathFile:(NSString*)file;

+(NSString*) getDocumentAutoJsonPath;
+(NSString*) getDocumentProfileJsonPath;
+(NSString*) getDocumentHistoryJsonPath;

@end
