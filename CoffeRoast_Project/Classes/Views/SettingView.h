//
//  SettingView.h
//  CoffeRoast_Project
//
//  Created by Bai-Kai-Ren on 2013/12/30.
//  Copyright (c) 2013年 Bai-Kai-Ren. All rights reserved.
//

#import "BaseView.h"

@interface SettingView : BaseView

@property(nonatomic, strong) UIImageView *ipAddressView;
@property(nonatomic, strong) UIImageView *ipPortView;

@property(nonatomic, strong) UITextField *ipAddressField;
@property(nonatomic, strong) UITextField *ipPortField;

@end
