//
//  ProfileView.h
//  CoffeRoast_Project
//
//  Created by Bai-Kai-Ren on 2013/12/24.
//  Copyright (c) 2013年 Bai-Kai-Ren. All rights reserved.
//

#import "BaseView.h"

@interface ProfileView : BaseView
@property(nonatomic, strong) UIButton *tempChBtn;
@property(nonatomic, strong) UIButton *rollerChBtn;
@property(nonatomic) NSInteger tempChange;
@property(nonatomic) NSInteger rollerChanged;
@end
