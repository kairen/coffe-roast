//
//  SettingController.m
//  CoffeRoast_Project
//
//  Created by Bai-Kai-Ren on 2013/12/30.
//  Copyright (c) 2013年 Bai-Kai-Ren. All rights reserved.
//

#import "SettingController.h"
#import "KeyBoardView.h"
#import "SettingListCell.h"
#import "BaseView.h"

@interface SettingController ()
@property(nonatomic, strong) NSMutableArray *fields;
@end

@implementation SettingController

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.settingView = [[BaseView alloc]initWithFrame:self.frame];
    [self.settingView setTitle:@"Setting" logoImage:@"setting_logo.png"];
    [self.settingView setLeftBarItemImage:@"Back"];
    self.settingView.listView = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.settingView.titleBar.frame), CGRectGetWidth(self.settingView.frame), CGRectGetHeight(self.settingView.frame) - CGRectGetHeight(self.settingView.titleBar.frame) - CGRectGetHeight(self.settingView.bottomBar.frame)) style:UITableViewStylePlain];
    self.settingView.listView.rowHeight = 100;
    
    self.fields = [NSMutableArray array];
    
    self.settingView.listView.dataSource = self;
    self.settingView.listView.delegate = self;
    
    [self.settingView.leftButton addTarget:self action:@selector(dismissViewController) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.settingView];
}

-(void) dismissViewController
{
    [ALLModels saveIPAddress:[(UITextField*)self.fields[0] text] port:[(UITextField*)self.fields[1] text]];
    [super dismissViewController];
}

#pragma mark - keyboard Aciton
-(void) keyBoardViewButtonAction:(UIButton*)btn
{
    switch (btn.tag) {
        case 0 ... 9: {
            self.editFieldView.text = [self.editFieldView.text stringByAppendingFormat:@"%d",(int)btn.tag];
            break;
        } case 10: {
            self.editFieldView.text = [self.editFieldView.text stringByAppendingFormat:@"."];
            break;
        } case 11: {
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

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}

-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * CellIdentifier = @"CellIdentifier";
    
    SettingListCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(cell == nil) {
        cell = [[SettingListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        if(indexPath.row == 0) {
            cell.titleField.text = [ALLModels ipAddress];
            [self.fields addObject:cell.titleField];
        } else if(indexPath.row == 1) {
            cell.titleField.text = [ALLModels ipPort];
            [self.fields addObject:cell.titleField];
            if(!self.keyBoardView) {
                self.keyBoardView = [[KeyBoardView alloc]initWithNumberButtonTarget:self action:@selector(keyBoardViewButtonAction:) inputFields:self.fields];
            }
        } else {
            cell.titleField.text = [ALLModels deviceInfos][indexPath.row - 2];
            cell.titleField.userInteractionEnabled = NO;
        }
        cell.titleLabel.text = [ALLModels settingTitles][indexPath.row];
        cell.titleField.delegate = self;
        
        __weak typeof(self) weakSelf = self;
        cell.touchBeganAction = ^{
            [(UITextField*)weakSelf.fields[0] resignFirstResponder];
            [(UITextField*)weakSelf.fields[1] resignFirstResponder];
        };
    }
   
    return cell;
}

@end
