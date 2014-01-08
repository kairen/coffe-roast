//
//  CurveFiles.m
//  CoffeRoast_Project
//
//  Created by Bai-Kai-Ren on 2013/12/2.
//  Copyright (c) 2013年 Bai-Kai-Ren. All rights reserved.
//

#import "CurveFiles.h"

@interface CurveFiles ()

@property(nonatomic, readonly) NSString *fullPath;

@end

@implementation CurveFiles

+(id) curveWithDirectory:(NSString *)path
{
    return [[self alloc]initWithDirectory:path];
}

-(id)initWithDirectory:(NSString *)path
{
    self = [super init];
    if(self) {
            if([[NSFileManager defaultManager] fileExistsAtPath:path]) {
                _jsonFiles = [NSMutableArray arrayWithArray:[[NSFileManager defaultManager] contentsOfDirectoryAtPath:path error:nil]];
                _fullPath = path;
        }
    }
    return self;
}

-(NSString*) getFileFullPathAtIndex:(NSInteger)index
{
    return [self.fullPath stringByAppendingPathComponent:[self.jsonFiles objectAtIndex:index]];
}

-(NSString*) getFileNameAtIndex:(NSInteger)index
{
    return [self.jsonFiles objectAtIndex:index];
}



@end
