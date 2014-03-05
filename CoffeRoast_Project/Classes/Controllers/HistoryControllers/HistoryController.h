//
//  HistoryController.h
//  CoffeRoast_Project
//
//  Created by Bai-Kai-Ren on 2013/12/31.
//  Copyright (c) 2013年 Bai-Kai-Ren. All rights reserved.
//

#import "BaseController.h"
#import "HistoryListEvent.h"

@class HistoryListEvent;
@class HistoryView;

@interface HistoryController : BaseController <HistroyListEventDelegate,UIAlertViewDelegate>

@property(nonatomic, strong) HistoryView *historyView;
@property(nonatomic, strong) HistoryListEvent *historyListEvent;
@end
