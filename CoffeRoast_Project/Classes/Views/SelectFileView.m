//
//  SelectFileView.m
//  CoffeRoast_Project
//
//  Created by Bai-Kai-Ren on 2013/11/29.
//  Copyright (c) 2013年 Bai-Kai-Ren. All rights reserved.
//

#import "SelectFileView.h"

@implementation SelectFileView

- (id)initWithFrame:(CGRect)frame 
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setLeftBarItemImage:@"Back"];
    
        self.listView = [[UITableView alloc] initWithFrame: CGRectMake(6,CGRectGetHeight(self.titleBar.frame) + 6, CGRectGetWidth(self.frame) - 6, CGRectGetHeight(self.frame) - CGRectGetHeight(self.titleBar.frame) - CGRectGetHeight(self.bottomBar.frame) - 12) style:UITableViewStylePlain];
        self.listView.rowHeight = 70;
        
        [self addSubview:self.listView];
    }
    return self;
}

@end
