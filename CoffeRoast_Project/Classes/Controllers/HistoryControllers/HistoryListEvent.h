//
//  HistoryListViewEvent.h
//  CoffeRoast_Project
//
//  Created by Bai-Kai-Ren on 2014/1/5.
//  Copyright (c) 2014年 Bai-Kai-Ren. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RoastProfile.h"

@protocol HistroyListEventDelegate;

@interface HistoryListEvent : NSObject <UITableViewDataSource,UITableViewDelegate>

+(id) setListEventView:(UITableView*)tableView ; 

@property(nonatomic, weak) id<HistroyListEventDelegate> delegate;
@end

@protocol HistroyListEventDelegate <NSObject>
@required
-(void) historyEventDidSelectRoastProfile:(RoastProfile*)roastProfile;
@end
