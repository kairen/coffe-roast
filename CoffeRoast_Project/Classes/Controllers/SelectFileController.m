//
//  SelectFileController.m
//  CoffeRoast_Project
//
//  Created by Bai-Kai-Ren on 2013/11/29.
//  Copyright (c) 2013年 Bai-Kai-Ren. All rights reserved.
//

#import "SelectFileController.h"
#import "AutoController.h"
#import "ProfileController.h"
#import "SelectFileCell.h"
#import "SelectFileView.h"
#import "CurveFiles.h"
#import "RoastJSONModel.h"

@interface SelectFileController () <UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *originFrames;
}
@property(nonatomic, readonly) CurveFiles *curveFiles;
@property(nonatomic, strong) SelectFileView *selectView;
@end

@implementation SelectFileController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.selectView = [[SelectFileView alloc]initWithFrame:self.frame];
    self.selectView.listView.delegate = self;
    self.selectView.listView.dataSource = self;
    
    if([self.title isEqualToString:@"Auto"]) {
        [self.selectView setTitle:self.title logoImage:@"auto_logo.png"];
        _curveFiles = [CurveFiles curveWithDirectory:[DocumentsPaths getDocumentAutoJsonPath]];
    } else {
        [self.selectView setTitle:self.title logoImage:@"profile_logo.png"];
        _curveFiles = [CurveFiles curveWithDirectory:[DocumentsPaths getDocumentProfileJsonPath]];
    }
    
    [self.selectView.leftButton addTarget:self action:@selector(dismissViewController) forControlEvents:UIControlEventTouchUpInside];
    
    originFrames = [NSMutableArray array];
    
    [self.view addSubview:self.selectView];
}

#pragma mark - ScrollView Delegate method
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if( scrollView.contentOffset.y < 0 ) {
        int i = 0;
        for(SelectFileCell *cell in  self.selectView.listView.visibleCells) {
            CGRect frame = cell.frame;
            frame.origin.y = [[originFrames objectAtIndex:i] floatValue] + (i * fabs(scrollView.contentOffset.y) / 2);
            cell.frame = frame;
            i++;
        }
    }
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    int i = 0;
    for(SelectFileCell *cell in  self.selectView.listView.visibleCells) {
        CGRect frame = cell.frame;
        frame.origin.y = [[originFrames objectAtIndex:i] floatValue];
        cell.frame = frame;
        i++;
    }
}

#pragma mark - UITableView Datasource Method
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.curveFiles.jsonFiles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * CellIdentifier = @"CellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[SelectFileCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.textLabel.text = [self.curveFiles getFileNameAtIndex:indexPath.row];
    return cell;
}

#pragma mark - UITableView Delegate Method
-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSData *jsonData = [NSData dataWithContentsOfFile:[self.curveFiles getFileFullPathAtIndex:indexPath.row]];

    if([self.title isEqualToString:@"Auto"]) {
        AutoController *autoController = [[AutoController alloc]init];
        autoController.roastJson = [RoastJSONModel roastJSONDataWithDict:[NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:NULL]];
        autoController.transitioningDelegate = self.transitioningDelegate;
        [self presentViewController:autoController animated:YES completion:NULL];
    } else {
        ProfileController *profileController = [[ProfileController alloc]init];
        profileController.roastJson = [RoastJSONModel roastJSONDataWithDict:[NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:NULL]];
        profileController.transitioningDelegate = self.transitioningDelegate;
        [self presentViewController:profileController animated:YES completion:NULL];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

-(void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.alpha = 0.0;
    dispatch_async(dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.4 delay:0.2 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            cell.alpha = 1.0;
        }completion:NULL];
    });
    SelectFileCell *sCell = (SelectFileCell*)cell;
    if(!sCell.isLoading) {
        [originFrames addObject:[NSNumber numberWithFloat:CGRectGetMinY(cell.frame)]];
        sCell.isLoading = YES;
    }
}
@end
