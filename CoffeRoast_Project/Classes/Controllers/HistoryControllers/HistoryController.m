//
//  HistoryController.m
//  CoffeRoast_Project
//
//  Created by Bai-Kai-Ren on 2013/12/31.
//  Copyright (c) 2013年 Bai-Kai-Ren. All rights reserved.
//

#import "HistoryController.h"
#import "HistoryView.h"
#import "HistoryListCell.h"
#import "CurveFiles.h"
#import "ProfileController.h"

@implementation HistoryController

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.historyView = [[HistoryView alloc]initWithFrame:self.frame];
    
    [self.historyView.leftButton addTarget:self action:@selector(dismissViewController) forControlEvents:UIControlEventTouchUpInside];
    [self.historyView.deleteBtn addTarget:self action:@selector(deleteButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.historyView.midButton addTarget:self action:@selector(editorButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    self.historyListEvent = [HistoryListEvent setListEventView:self.historyView.listView];
    self.historyListEvent.delegate = self;
    
    NSData *jsonData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"newJsonFile.crp" ofType:nil]];
    RoastJSONModel *roastJson = [RoastJSONModel roastJSONDataWithDict:[NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:NULL]];
    [self changeLineChartAtRoastProfile:[RoastProfile roastProfileWithDict:roastJson.roastProfiles]];

    [self.view addSubview:self.historyView];
}

#pragma mark - Delete Button Action
-(void) deleteButtonAction:(id)sender
{
    if(self.historyListEvent.expansionIndex != -1) {
        UIAlertView *deleteView = [[UIAlertView alloc] initWithTitle:@"Message" message:@"Delete ?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Delete", nil];
        [deleteView show];
    }
}

#pragma mark - Delete Button Action
-(void) editorButtonAction:(id)sender
{
    if (self.historyListEvent.expansionIndex != -1) {
         NSString *filePath = [self.historyListEvent.curveFiles getFileFullPathAtIndex:self.historyListEvent.expansionIndex - 1];
        NSData *jsonData = [NSData dataWithContentsOfFile:filePath];
        ProfileController *profileController = [[ProfileController alloc]init];
        profileController.roastJson = [RoastJSONModel roastJSONDataWithDict:[NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:NULL]];
        profileController.transitioningDelegate = self.transitioningDelegate;
      
        [self presentViewController:profileController animated:YES completion:nil];
    }
}

-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        NSString *filePath = [self.historyListEvent.curveFiles getFileFullPathAtIndex:self.historyListEvent.expansionIndex - 1];
      
        if([[NSFileManager defaultManager] removeItemAtPath:filePath error:NULL]) {
            [self.historyListEvent.curveFiles reloadData];
        
            NSIndexPath *path = [NSIndexPath indexPathForRow:self.historyListEvent.expansionIndex - 1 inSection:0];
            NSIndexPath *path2 = [NSIndexPath indexPathForRow:self.historyListEvent.expansionIndex inSection:0];
            self.historyListEvent.expansionIndex = -1;
            [self.historyView.listView deleteRowsAtIndexPaths:@[path,path2] withRowAnimation:UITableViewRowAnimationFade];
        }
    }
}

-(void) historyEventDidSelectAtIndex:(NSIndexPath *)indexPath withRoastProfile:(RoastProfile *)roastProfile
{
    CATransition *transition = [CATransition animation];
    transition.type = kCATransitionFade;
    transition.duration = 0.6;
    [self.historyView.tempView.layer addAnimation:transition forKey:nil];
    [self.historyView.rollerView.layer addAnimation:transition forKey:nil];
    [self changeLineChartAtRoastProfile:roastProfile];
}

-(void) changeLineChartAtRoastProfile:(RoastProfile*)roastProfile
{
    self.historyView.tempView.startPoint = roastProfile.inPutBeanIndex;
    self.historyView.tempView.stopPoint = roastProfile.outPutBeanIndex;
    self.historyView.tempView.lineDatas = roastProfile.temperatureVaules;
    self.historyView.rollerView.lineDatas = roastProfile.rollerSpeedVaules;
    self.historyView.rollerView.windDatas = roastProfile.windSpeedVaules;
}

@end
