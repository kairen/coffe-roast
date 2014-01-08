//
//  HistoryController.m
//  CoffeRoast_Project
//
//  Created by Bai-Kai-Ren on 2013/12/31.
//  Copyright (c) 2013年 Bai-Kai-Ren. All rights reserved.
//

#import "HistoryController.h"
#import "HistoryListEvent.h"
#import "HistoryView.h"

@interface HistoryController () <HistroyListEventDelegate>

@property(nonatomic, strong) HistoryView *historyView;
@property(nonatomic, strong) HistoryListEvent *historyListEvent;
@end

@implementation HistoryController

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.historyView = [[HistoryView alloc]initWithFrame:self.frame];
    
    [self.historyView.leftButton addTarget:self action:@selector(dismissViewController) forControlEvents:UIControlEventTouchUpInside];
    self.historyListEvent = [HistoryListEvent setListEventView:self.historyView.listView];
    self.historyListEvent.delegate = self;
    
    NSData *jsonData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"default.crp" ofType:nil]];
    RoastJSONModel *roastJson = [RoastJSONModel roastJSONDataWithDict:[NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:NULL]];
    [self changeLineChartAtRoastProfile:[RoastProfile roastProfileWithDict:roastJson.roastProfile]];

    [self.view addSubview:self.historyView];
}

-(void) historyEventDidSelectRoastProfile:(RoastProfile *)roastProfile
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
    self.historyView.tempView.lineDatas = roastProfile.temperatureVaules;
    self.historyView.rollerView.lineDatas = roastProfile.rollerSpeedVaules;
    self.historyView.rollerView.windDatas = roastProfile.windSpeedVaules;
}

@end
