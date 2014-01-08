//
//  HistoryListViewEvent.m
//  CoffeRoast_Project
//
//  Created by Bai-Kai-Ren on 2014/1/5.
//  Copyright (c) 2014年 Bai-Kai-Ren. All rights reserved.
//

#import "HistoryListEvent.h"
#import "HistoryListCell.h"
#import "DocumentsPaths.h"
#import "ALLModels.h"
#import "RoastJSONModel.h"
#import "CurveFiles.h"

@interface HistoryListEvent ()

@property(nonatomic, weak) UITableView *historyListView;
@property(nonatomic, strong) CurveFiles *curveFiles;
@property(nonatomic) NSInteger expansionIndex;

@end

@implementation HistoryListEvent

+(id) setListEventView:(UITableView *)tableView
{
    return [[self alloc] initWithEventView:tableView];
}

-(id) initWithEventView:(UITableView*)talbeView
{
    self = [super init];
    if(self) {
        self.historyListView = talbeView;
        self.historyListView.delegate = self;
        self.historyListView.dataSource = self;
        
        self.curveFiles = [CurveFiles curveWithDirectory:[DocumentsPaths getDocumentHistoryJsonPath]];
        self.expansionIndex = -1;
        
    }
    return self;
}

#pragma mark - TableView Delegate Method
-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    HistoryListCell *cell = (HistoryListCell*)[tableView cellForRowAtIndexPath:indexPath];
    
    NSIndexPath *path = [NSIndexPath indexPathForRow:indexPath.row + 1 inSection:0];
    
    if(cell.isExpansion) {
        self.expansionIndex = -1;
        cell.isExpansion = NO;
        [tableView deleteRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationFade];
    } else {
        if(self.expansionIndex == -1) {
            NSData *jsonData = [NSData dataWithContentsOfFile:[self.curveFiles getFileFullPathAtIndex:indexPath.row ]];
            RoastJSONModel *roastModel = [RoastJSONModel roastJSONDataWithDict:[NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:NULL]];
            [self.delegate historyEventDidSelectRoastProfile:[RoastProfile roastProfileWithDict:roastModel.roastProfile]];
            
            cell.isExpansion = YES;
            self.expansionIndex = path.row;
            [tableView insertRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationFade];
        }
    }
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return (self.expansionIndex != -1) ? self.curveFiles.jsonFiles.count + 1 : self.curveFiles.jsonFiles.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return (self.expansionIndex == indexPath.row) ? 200 : 70;
}

-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * CellIdentifier = @"CellIdentifier";
    
    HistoryListCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(cell == nil) {
        if(indexPath.row == self.expansionIndex) {
             cell = [[HistoryListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier cellType:kCellPushType];
            [cell setCellLabelWithTitles:[ALLModels historyTitles]];
        } else {
             cell = [[HistoryListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier cellType:kCellDefaultType];
        }
    }
    if(indexPath.row != self.expansionIndex) {
         cell.textLabel.text = [self.curveFiles getFileNameAtIndex:indexPath.row];
    } else {
        NSData *jsonData = [NSData dataWithContentsOfFile:[self.curveFiles getFileFullPathAtIndex:indexPath.row - 1]];
        RoastJSONModel *roastModel = [RoastJSONModel roastJSONDataWithDict:[NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:NULL]];
        BeanProfile *beanPorifle = [BeanProfile beanProfileWithDict:roastModel.beanProfile];
        NSArray *titles = @[roastModel.date,roastModel.editor,beanPorifle.beanName,[NSString stringWithFormat:@"%d",beanPorifle.beanType],beanPorifle.country];
        [cell setTitleValue:titles];
    }
    return cell;
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
