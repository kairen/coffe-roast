//
//  HistoryView.m
//  CoffeRoast_Project
//
//  Created by Bai-Kai-Ren on 2013/12/31.
//  Copyright (c) 2013年 Bai-Kai-Ren. All rights reserved.
//

#import "HistoryView.h"

@implementation HistoryView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setTitle:@"History" logoImage:@"history_logo.png"];
        [self setLeftBarItemImage:@"Back"];
        [self showSeparationView];

         CGRect cvFrame = self.controlView.frame;
        
        self.listView  =[[UITableView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(cvFrame) , CGRectGetHeight(cvFrame)) style:UITableViewStylePlain];
        self.listView.backgroundColor = [UIColor clearColor];
        self.listView.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.listView.showsHorizontalScrollIndicator = NO;
        self.listView.showsVerticalScrollIndicator = NO;
        self.listView.alpha = 0.0;
        
        [self.controlView addSubview:self.listView];
        
        [self addTempLineView];
        [self addRollerLineView];
        [self performSelector:@selector(StartListViewAnimation) withObject:nil afterDelay:0.8];
        [self performSelector:@selector(StartChartViewAnimation) withObject:nil afterDelay:1.2];
    }
    return self;
}


@end
