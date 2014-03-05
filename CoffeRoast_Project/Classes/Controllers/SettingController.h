//
//  SettingController.h
//  CoffeRoast_Project
//
//  Created by Bai-Kai-Ren on 2013/12/30.
//  Copyright (c) 2013年 Bai-Kai-Ren. All rights reserved.
//

#import "BaseController.h"

@class BaseView;
@class KeyBoardView;

@interface SettingController : BaseController <UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate>

@property(nonatomic, strong) BaseView *settingView;
@property(nonatomic, strong) KeyBoardView *keyBoardView;
@property(nonatomic, weak) UITextField *editFieldView;
@end
