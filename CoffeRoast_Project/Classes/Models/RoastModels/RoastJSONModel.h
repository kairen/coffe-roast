//
//  BakingCurveModel.h
//  CafeRoast
//
//  Created by Bai-Kai-Ren on 13/11/13.
//  Copyright (c) 2013年 Bai-Kai-Ren. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BeanProfile.h"
#import "RoastProfile.h"

static NSString *const JSONGradingListKey = @"gradingList";
static NSString *const JSONBLoaderInfoKey = @"bLoaderInfo";
static NSString *const JSONULoaderInfoKey = @"uLoaderInfo";
static NSString *const JSONPathKey = @"path";
static NSString *const JSONRoastProfileNameKey = @"roastProfileName";
static NSString *const JSONProfileNameKey = @"profileName";
static NSString *const JSONMultiProfileKey = @"multiProfile";
static NSString *const JSONEditorKey = @"Editor";
static NSString *const JSONDateKey = @"Date_";
static NSString *const JSONNoteKey = @"Note";
static NSString *const JSONBeanProfileName = @"BeanProfileName";

static NSString *const JSONRoastProfileKey = @"RoastProfile";
static NSString *const JSONBeanProfileKey = @"BeanProfile";


@interface RoastJSONModel : NSObject

+(id) roastJSONDataWithDict:(NSDictionary*)dict;

@property(nonatomic, strong) NSDictionary *roastJsonDict;

@property(nonatomic) NSInteger gradingList;
@property(nonatomic) NSInteger multiProfile;

@property(nonatomic, strong) NSString *bLoaderInfo;
@property(nonatomic, strong) NSString *uLoaderInfo;
@property(nonatomic, strong) NSString *path;
@property(nonatomic, strong) NSString *roastProfileName;
@property(nonatomic, strong) NSString *profileName;
@property(nonatomic, strong) NSString *editor;
@property(nonatomic, strong) NSString *beanProfileName;
@property(nonatomic, strong) NSString *date;

@property(nonatomic, strong) NSDictionary *roastProfile;

@property(nonatomic, strong) NSDictionary *beanProfile;

@end
