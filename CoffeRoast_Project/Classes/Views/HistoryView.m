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
        [self setMiddleBarItemImage:@"History_Edit"];
        [self setDeleteBarItemImage:@"History_Delete"];
        [self showSeparationView];

        CGRect cvFrame = self.controlView.frame;
        
        self.listView  =[[UITableView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(cvFrame) , CGRectGetHeight(cvFrame)) style:UITableViewStylePlain];
        self.listView.alpha = 0.0;
        
        [self.controlView addSubview:self.listView];
        
        [self addTempLineView];
        [self addRollerLineView];
        
        cvFrame = self.midButton.frame;
        cvFrame.origin.x = CGRectGetMidX(frame) + 10;
        self.midButton.frame = cvFrame;
        
        cvFrame = self.deleteBtn.frame;
        cvFrame.origin.x -= CGRectGetWidth(cvFrame) / 2 + 10;
        self.deleteBtn.frame = cvFrame;
        
        [self performSelector:@selector(StartListViewAnimation) withObject:nil afterDelay:0.8];
        [self performSelector:@selector(StartChartViewAnimation) withObject:nil afterDelay:1.2];
    }
    return self;
}

-(void) setDeleteBarItemImage:(NSString*)image
{
    if(self.deleteBtn == nil) {
        self.deleteBtn = [[UIButton alloc]init];
    }
    [self addButton:self.deleteBtn imageName:image direction:MiddleDirection];
}

@end
