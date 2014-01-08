//
//  AutoListCell.h
//  CoffeRoast_Project
//
//  Created by Bai-Kai-Ren on 2013/12/23.
//  Copyright (c) 2013年 Bai-Kai-Ren. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditorListCell : UITableViewCell <UITextFieldDelegate,UITextViewDelegate>

@property(nonatomic, strong) UILabel *titleLabel;
@property(nonatomic, strong) UITextField *textField;
@property(nonatomic, strong) UITextView *textView;

@property(nonatomic) BOOL canEdit;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
-(void) addTextFieldWithTag:(NSInteger)tag bgImage:(UIImage*)image;
-(void) addTextViewWithTag:(NSInteger)tag bgImage:(UIImage*)image;
@end
