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

static NSString *const JSONProfileNameKey = @"profileName";
static NSString *const JSONEditorKey = @"Editor";
static NSString *const JSONDateKey = @"Date_";
static NSString *const JSONMultiProfileKey = @"multiProfile";
static NSString *const JSONGradingListKey = @"gradingList";
static NSString *const JSONNextProfileNameKey = @"next_profileName";
static NSString *const JSONNoteKey = @"Note";
static NSString *const JSONRoastProfileKey = @"RoastProfile";
static NSString *const JSONBeanProfileKey = @"BeanProfile";


@interface RoastJSONModel : NSObject

+(id) roastJSONDataWithDict:(NSDictionary*)dict;
-(void) reloadRoastJSonData;

@property(nonatomic, strong) NSMutableDictionary *roastJsonDict;

@property(nonatomic) NSInteger gradingList;
@property(nonatomic) NSInteger multiProfile;

@property(nonatomic, strong) NSString *nextProfileName;
@property(nonatomic, strong) NSString *profileName;
@property(nonatomic, strong) NSString *editor;
@property(nonatomic, strong) NSString *date;

@property(nonatomic, strong) NSDictionary *roastProfiles;

@property(nonatomic, strong) NSDictionary *beanProfiles;

@end
