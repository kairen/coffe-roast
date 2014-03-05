//
//  SelectFileController.h
//  CoffeRoast_Project
//
//  Created by Bai-Kai-Ren on 2013/11/29.
//  Copyright (c) 2013年 Bai-Kai-Ren. All rights reserved.
//

#import "BaseController.h"

@class CurveFiles;
@class SelectFileView;

@interface SelectFileController : BaseController

@property(nonatomic, readonly) CurveFiles *curveFiles;
@property(nonatomic, strong) SelectFileView *selectView;
@end
