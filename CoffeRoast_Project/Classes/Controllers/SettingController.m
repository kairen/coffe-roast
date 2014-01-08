//
//  SettingController.m
//  CoffeRoast_Project
//
//  Created by Bai-Kai-Ren on 2013/12/30.
//  Copyright (c) 2013年 Bai-Kai-Ren. All rights reserved.
//

#import "SettingController.h"
#import "KeyBoardView.h"
#import "SettingView.h"

@interface SettingController ()<UITextFieldDelegate>


@property(nonatomic, strong) SettingView *settingView;
@property(nonatomic, strong) KeyBoardView *keyBoardView;
@property(nonatomic, weak) UITextField *editFieldView;
@end

@implementation SettingController


- (void)viewDidLoad
{
    [super viewDidLoad];
	self.settingView = [[SettingView alloc]initWithFrame:self.frame];
    
    [self.settingView.leftButton addTarget:self action:@selector(dismissViewController) forControlEvents:UIControlEventTouchUpInside];
    
    self.settingView.ipAddressField.text = [ALLModels ipAddress];
    self.settingView.ipPortField.text = [ALLModels ipPort];
    
    self.settingView.ipAddressField.delegate = self;
    self.settingView.ipPortField.delegate = self;
    
    self.keyBoardView = [[KeyBoardView alloc]initWithNumberButtonTarget:self action:@selector(keyBoardViewButtonAction:) inputFields:@[self.settingView.ipAddressField,self.settingView.ipPortField]];
    

    [self.view addSubview:self.settingView];
}

-(void) dismissViewController
{
    [ALLModels saveIPAddress:self.settingView.ipAddressField.text port:self.settingView.ipPortField.text];
    [super dismissViewController];
}

#pragma mark - keyboard Aciton
-(void) keyBoardViewButtonAction:(UIButton*)btn
{
    switch (btn.tag) {
        case 0 ... 9:
        {
            self.editFieldView.text = [self.editFieldView.text stringByAppendingFormat:@"%d",(int)btn.tag];
            break;
        }
        case 10:
        {
            self.editFieldView.text = [self.editFieldView.text stringByAppendingFormat:@"."];
            break;
        }
        case 11:
        {
            if(self.editFieldView.text.length > 0) {
                self.editFieldView.text = [self.editFieldView.text substringToIndex:self.editFieldView.text.length - 1];
            }
            break;
        }
    }
    [self playAudioWithFile:@"click_24.wav"];
}

-(void) textFieldDidBeginEditing:(UITextField *)textField
{
    [self.keyBoardView showAnimation];
    self.editFieldView = textField;
}

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.settingView.ipAddressField resignFirstResponder];
    [self.settingView.ipPortField resignFirstResponder];
}



@end
