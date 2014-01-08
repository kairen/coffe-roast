//
//  ProfileListEvent.h
//  CoffeRoast_Project
//
//  Created by Bai-Kai-Ren on 2014/1/5.
//  Copyright (c) 2014年 Bai-Kai-Ren. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RoastJSONModel;

@interface ProfileListEvent : NSObject <UITableViewDataSource,UITableViewDelegate>

+(id) setListEventView:(UITableView*)tableView data:(RoastJSONModel*)roastData;

@end
