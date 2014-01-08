//
//  AutoListCell.m
//  CoffeRoast_Project
//
//  Created by Bai-Kai-Ren on 2013/12/23.
//  Copyright (c) 2013年 Bai-Kai-Ren. All rights reserved.
//

#import "EditorListCell.h"

@implementation EditorListCell

- (id)initWithStyle:(UITableViewCellStyle)style  reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0,150, 30)];
        self.titleLabel.font = [UIFont fontWithName:@"Futura-Medium" size:26];
        self.titleLabel.adjustsFontSizeToFitWidth = YES;
        self.titleLabel.textColor = [UIColor colorWithRed:0.11764706 green:0.18823529 blue:0.25882353 alpha:1];
        self.titleLabel.backgroundColor = [UIColor clearColor];
        
        [self addSubview:self.titleLabel];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

-(void) addTextFieldWithTag:(NSInteger)tag bgImage:(UIImage *)image
{
    self.textField = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.titleLabel.frame) + 10  , 0, image.size.width, image.size.height)];
    self.textField.textColor = [UIColor whiteColor];
    self.textField.tag = tag;
    self.textField.adjustsFontSizeToFitWidth = YES;
    self.textField.font = [UIFont fontWithName:@"Futura-Medium" size:22];
    self.textField.background = image;
    self.textField.delegate = self;
    
    [self addSubview:self.textField];
}

-(void) addTextViewWithTag:(NSInteger)tag bgImage:(UIImage *)image
{
    UIImageView *background = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.titleLabel.frame) + 10, 0, image.size.width, image.size.height)];
    background.userInteractionEnabled = YES;
    background.image = image;
    self.textView = [[UITextView alloc]initWithFrame:CGRectMake(5, 5, 170, 90)];
    self.textView.textColor = [UIColor whiteColor];
    self.textView.backgroundColor = [UIColor clearColor];
    self.textView.tag = tag;
    self.textView.delegate = self;
    self.textView.font = [UIFont fontWithName:@"Futura-Medium" size:16];
    [background addSubview:self.textView];
    [self addSubview:background];
}

#pragma mark - textField Delegate
-(BOOL) textFieldShouldBeginEditing:(UITextField *)textField
{
    return self.canEdit;
}

#pragma mark - textView Delegate
-(BOOL) textViewShouldBeginEditing:(UITextView *)textView
{
    return self.canEdit;
}

@end
