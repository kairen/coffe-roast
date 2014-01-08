//
//  ProfileView.m
//  CoffeRoast_Project
//
//  Created by Bai-Kai-Ren on 2013/12/24.
//  Copyright (c) 2013年 Bai-Kai-Ren. All rights reserved.
//

#import "ProfileView.h"

@implementation ProfileView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setTitle:@"Profile" logoImage:@"profile_logo.png"];
        [self setLeftBarItemImage:@"Back"];
        [self setMiddleBarItemImage:@"Profile_Save"];
        [self setRightBarItemImage:@"btn_Run"];
        [self showSeparationView];
        
        self.listView = [[UITableView alloc] initWithFrame: CGRectMake(0, 0, CGRectGetWidth(self.controlView.frame), CGRectGetHeight(self.controlView.frame)) style:UITableViewStylePlain];
        self.listView.backgroundColor = [UIColor clearColor];
        self.listView.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.listView.showsHorizontalScrollIndicator = NO;
        self.listView.showsVerticalScrollIndicator = NO;
        self.listView.opaque = YES;
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
