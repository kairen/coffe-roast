//
//  CurveFiles.h
//  CoffeRoast_Project
//
//  Created by Bai-Kai-Ren on 2013/12/2.
//  Copyright (c) 2013年 Bai-Kai-Ren. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CurveFiles : NSObject

+(id) curveWithDirectory:(NSString *)path;

-(NSString*) getFileNameAtIndex:(NSInteger)index;
-(NSString*) getFileFullPathAtIndex:(NSInteger)index;

@property(nonatomic, readonly) NSMutableArray *jsonFiles;

@end
