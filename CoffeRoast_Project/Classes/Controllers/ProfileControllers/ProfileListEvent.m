//
//  ProfileListEvent.m
//  CoffeRoast_Project
//
//  Created by Bai-Kai-Ren on 2014/1/5.
//  Copyright (c) 2014年 Bai-Kai-Ren. All rights reserved.
//

#import "ProfileListEvent.h"
#import "EditorListCell.h"
#import "RoastJSONModel.h"
#import "ALLModels.h"

@interface ProfileListEvent () <UITextViewDelegate,UITextFieldDelegate>

@property(nonatomic, weak) UITableView *listView;
@property(nonatomic, weak) RoastJSONModel *roastJson;
@end

@implementation ProfileListEvent


+(id) setListEventView:(UITableView *)tableView data:(RoastJSONModel*)roastData;
{
    return [[self alloc] initWithEventView:tableView data:roastData];
}

-(id) initWithEventView:(UITableView*)talbeView data:(RoastJSONModel*)roastData;
{
    self = [super init];
    if(self) {
        self.listView = talbeView;
        self.roastJson = roastData;
        self.listView.delegate = self;
        self.listView.dataSource = self;
    }
    return self;
}

#pragma mark - UITableView Datasource Method
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [ALLModels editorTitles].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * CellIdentifier = @"CellIdentifier";
    
    EditorListCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[EditorListCell alloc]initWithStyle:UITableViewCellStyleDefault  reuseIdentifier:CellIdentifier];
        cell.canEdit = YES;
        if(indexPath.row == [ALLModels editorTitles].count - 1) {
            [cell addTextViewWithTag:indexPath.row bgImage:[UIImage imageNamed:@"Profile_input_big.png"]];
            cell.textView.text = [self.roastJson.roastJsonDict objectForKey:[[ALLModels editorTitleVauleKeys] objectAtIndex:indexPath.row]];
            cell.textView.delegate = self;
        } else {
            [cell addTextFieldWithTag:indexPath.row bgImage:[UIImage imageNamed:@"Profile_input.png"]];
            if(indexPath.row <= 4) {
                if(indexPath.row == 2) {
                    cell.textField.text = [NSString stringWithFormat:@"%d",[[self.roastJson.roastJsonDict objectForKey:[[ALLModels editorTitleVauleKeys] objectAtIndex:indexPath.row]] intValue]];
                } else {
                    cell.textField.text = [self.roastJson.roastJsonDict objectForKey:[[ALLModels editorTitleVauleKeys] objectAtIndex:indexPath.row]];
                }
                cell.textField.delegate = self;
            } else {
                if(indexPath.row == 5 || indexPath.row == 9 || indexPath.row == 10) {
                    cell.textField.text = [NSString stringWithFormat:@"%d",[[self.roastJson.beanProfiles objectForKey:[[ALLModels editorTitleVauleKeys] objectAtIndex:indexPath.row]] intValue]];
                } else {
                    cell.textField.text = [self.roastJson.beanProfiles objectForKey:[[ALLModels editorTitleVauleKeys] objectAtIndex:indexPath.row]];
                }
                cell.textField.delegate = self;
                cell.tag = indexPath.row;
            }
        }
        cell.titleLabel.text = [[ALLModels editorTitles] objectAtIndex:indexPath.row];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == [ALLModels editorTitles].count -1) {
        return [UIImage imageNamed:@"Profile_input_big.png"].size.height;
    }
    return [UIImage imageNamed:@"Profile_input.png"].size.height;
}

-(void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.alpha = 0.0;
    dispatch_async(dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.4 delay:0.2 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            cell.alpha = 1.0;
        }completion:NULL];
    });
}

-(BOOL) textFieldShouldBeginEditing:(UITextField *)textField
{
    if(textField.tag == 0 || textField.tag == 1 || textField.tag == 4) {
        return YES;
    } else {
        [self.delegate profileTextField:textField];
        return NO;
    }
}

-(BOOL) textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSUInteger newLength = [textField.text length] + [string length] - range.length;
    return (newLength > 15) ? NO : YES;
}


-(void) textViewDidBeginEditing:(UITextView *)textView
{
    __weak typeof(self.listView) weakList = self.listView;
    CGRect frame = weakList.frame;
    frame.origin.y -= 250;
    [UIView animateWithDuration:0.4 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:0.8 options:UIViewAnimationOptionCurveEaseIn animations:^{
        weakList.frame = frame;
    }completion:nil];
}

-(void) textViewDidEndEditing:(UITextView *)textView
{
    __weak typeof(self.listView) weakList = self.listView;
    CGRect frame = weakList.frame;
    frame.origin.y += 250;
    [UIView animateWithDuration:0.4 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:0.8 options:UIViewAnimationOptionCurveEaseIn animations:^{
        weakList.frame = frame;
    }completion:nil];

}

@end
