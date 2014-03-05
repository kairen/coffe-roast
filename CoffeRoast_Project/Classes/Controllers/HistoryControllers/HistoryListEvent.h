//
//  HistoryListViewEvent.h
//  CoffeRoast_Project
//
//  Created by Bai-Kai-Ren on 2014/1/5.
//  Copyright (c) 2014年 Bai-Kai-Ren. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RoastProfile.h"

@class CurveFiles;

@protocol HistroyListEventDelegate;

@interface HistoryListEvent : NSObject <UITableViewDataSource,UITableViewDelegate>

+(id) setListEventView:(UITableView*)tableView ; 

@property(nonatomic, weak) id<HistroyListEventDelegate> delegate;
@property(nonatomic, weak) UITableView *historyListView;
@property(nonatomic, strong) CurveFiles *curveFiles;
@property(nonatomic) NSInteger expansionIndex;
@end

@protocol HistroyListEventDelegate <NSObject>
@required
-(void) historyEventDidSelectAtIndex:(NSIndexPath*)indexPath withRoastProfile:(RoastProfile*)roastProfile ;
@end
