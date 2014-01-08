//
//  AutonController.m
//  CoffeRoast_Project
//
//  Created by Bai-Kai-Ren on 2013/11/28.
//  Copyright (c) 2013年 Bai-Kai-Ren. All rights reserved.
//

#import "AutoController.h"
#import "AutoListEvent.h"
#import "AutoView.h"


@interface AutoController ()

@property(nonatomic, strong) AutoView *autoView;
@property(nonatomic, strong) AutoListEvent *autoListEvent;
@end

@implementation AutoController

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.autoView = [[AutoView alloc]initWithFrame:self.frame];
    
    [self.autoView.leftButton addTarget:self action:@selector(dismissViewController) forControlEvents:UIControlEventTouchUpInside];
    
    RoastProfile *roastProfile = [RoastProfile roastProfileWithDict:self.roastJson.roastProfile];
    self.autoView.tempView.lineDatas = roastProfile.temperatureVaules;
    self.autoView.tempView.startPoint = roastProfile.inPutBeanIndex;
    self.autoView.tempView.stopPoint = roastProfile.outPutBeanIndex;
    
    self.autoView.rollerView.lineDatas = roastProfile.rollerSpeedVaules;
    self.autoView.rollerView.windDatas = roastProfile.windSpeedVaules;
 
    self.autoListEvent = [AutoListEvent setListEventView:self.autoView.listView data:self.roastJson];
    
    [self.view addSubview:self.autoView];
}



@end
