//
//  SettingListCell.h
//  CoffeRoast_Project
//
//  Created by Bai-Kai-Ren on 2014/2/24.
//  Copyright (c) 2014年 Bai-Kai-Ren. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^TouchBeganAction)(void);

@interface SettingListCell : UITableViewCell

@property(nonatomic, strong) UILabel *titleLabel;
@property(nonatomic, strong) UITextField *titleField;
@property(nonatomic, strong) UIImageView *separatorView;

@property(nonatomic,copy) TouchBeganAction touchBeganAction;
@end
