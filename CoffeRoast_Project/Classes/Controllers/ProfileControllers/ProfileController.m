//
//  ProfileController.m
//  CoffeRoast_Project
//
//  Created by Bai-Kai-Ren on 2013/12/24.
//  Copyright (c) 2013年 Bai-Kai-Ren. All rights reserved.
//

#import "ProfileController.h"
#import "EditorListCell.h"
#import "ProfileListEvent.h"
#import "ProfileView.h"

@interface ProfileController ()

@property(nonatomic, strong) ProfileView *profileView;
@property(nonatomic, strong) ProfileListEvent *profileListEvent;
@end

@implementation ProfileController

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.profileView = [[ProfileView alloc]initWithFrame:self.frame];
    
    [self.profileView.leftButton addTarget:self action:@selector(dismissViewController) forControlEvents:UIControlEventTouchUpInside];
    
    RoastProfile *roastProfile = [RoastProfile roastProfileWithDict:self.roastJson.roastProfile];
    self.profileView.tempView.lineDatas = roastProfile.temperatureVaules;
    self.profileView.tempView.startPoint = roastProfile.inPutBeanIndex;
    self.profileView.tempView.stopPoint = roastProfile.outPutBeanIndex;
    
    self.profileView.rollerView.lineDatas = roastProfile.rollerSpeedVaules;
    self.profileView.rollerView.windDatas = roastProfile.windSpeedVaules;
    
    self.profileListEvent = [ProfileListEvent setListEventView:self.profileView.listView data:self.roastJson];
    
    [self.view addSubview:self.profileView];
}



@end
