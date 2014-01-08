//
//  AutoListEvent.m
//  CoffeRoast_Project
//
//  Created by Bai-Kai-Ren on 2014/1/5.
//  Copyright (c) 2014年 Bai-Kai-Ren. All rights reserved.
//

#import "AutoListEvent.h"
#import "EditorListCell.h"
#import "RoastJSONModel.h"
#import "ALLModels.h"

@interface AutoListEvent ()

@property(nonatomic, weak) UITableView *listView;
@property(nonatomic, weak) RoastJSONModel *roastJson;
@end

@implementation AutoListEvent

+(id) setListEventView:(UITableView *)tableView data:(RoastJSONModel*)roastData
{
    return [[self alloc] initWithEventView:tableView data:roastData];
}

-(id) initWithEventView:(UITableView*)talbeView data:(RoastJSONModel*)roastData
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
        if(indexPath.row == [ALLModels editorTitles].count - 1) {
            [cell addTextViewWithTag:indexPath.row bgImage:[UIImage imageNamed:@"Auto_input_big.png"]];
            cell.textView.text = [self.roastJson.roastJsonDict objectForKey:[[ALLModels editorTitleVauleKeys] objectAtIndex:indexPath.row]];
        } else {
            [cell addTextFieldWithTag:indexPath.row bgImage:[UIImage imageNamed:@"input.png"]];
            if(indexPath.row < 4) {
                if(indexPath.row == 2) {
                    cell.textField.text = [NSString stringWithFormat:@"%d",[[self.roastJson.roastJsonDict objectForKey:[[ALLModels editorTitleVauleKeys] objectAtIndex:indexPath.row]] intValue]];
                } else {
                    cell.textField.text = [self.roastJson.roastJsonDict objectForKey:[[ALLModels editorTitleVauleKeys] objectAtIndex:indexPath.row]];
                }
            } else {
                if(indexPath.row == 5 || indexPath.row == 10 || indexPath.row == 11) {
                    cell.textField.text = [NSString stringWithFormat:@"%d",[[self.roastJson.beanProfile objectForKey:[[ALLModels editorTitleVauleKeys] objectAtIndex:indexPath.row]] intValue]];
                } else {
                    cell.textField.text = [self.roastJson.beanProfile objectForKey:[[ALLModels editorTitleVauleKeys] objectAtIndex:indexPath.row]];
                }
            }
        }
        cell.titleLabel.text = [[ALLModels editorTitles] objectAtIndex:indexPath.row];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == [ALLModels editorTitles].count -1) {
        return [UIImage imageNamed:@"Auto_input_big.png"].size.height;
    }
    return [UIImage imageNamed:@"input.png"].size.height;
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

@end
