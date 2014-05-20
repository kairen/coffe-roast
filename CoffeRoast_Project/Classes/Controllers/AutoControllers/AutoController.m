//
//  AutonController.m
//  CoffeRoast_Project
//
//  Created by Bai-Kai-Ren on 2013/11/28.
//  Copyright (c) 2013年 Bai-Kai-Ren. All rights reserved.
//

#import "AutoController.h"
#import "AutoListEvent.h"
#import "AutoAllEvent.h"
#import "EditorListCell.h"
#import "PopInfoView.h"
#import "AutoView.h"



@implementation AutoController

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.autoView = [[AutoView alloc]initWithFrame:self.frame];
    
    [self.autoView.leftButton addTarget:self action:@selector(dismissViewController) forControlEvents:UIControlEventTouchUpInside];
    
    self.roastProfiles = [RoastProfile roastProfileWithDict:self.roastJson.roastProfiles];
    self.beanProfiles = [BeanProfile beanProfileWithDict:self.roastJson.beanProfiles];

    self.autoAllEvent = [[AutoAllEvent alloc]initWithTarget:self];
    self.autoListEvent = [AutoListEvent setListEventView:self.autoView.listView data:self.roastJson];
    _isRoasted = NO;
    [self.view addSubview:self.autoView];
    self.infoView = [PopInfoView popInfoViewWitFrame:CGRectMake(0, 0, 1024, CGRectGetHeight(self.autoView.bottomBar.frame))];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(machineCloseNotification) name:kSocketMachineClose object:nil];
}

-(void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kSocketMachineClose object:nil];
}

-(void) machineCloseNotification
{
    [ALLModels saveLasyRoastStatus:RoastStopStatus];
    [self.autoView setRightBarItemImage:@"btn_Run"];
    [self.infoView removePopView];
}

-(void) readRoastStatus
{
    __weak typeof(self) tmpSelf = self;
    [self checkStatusComplete:^{
        [[SocketHadler share] writeHex:CMControlReadStatus ackHandle:^(NSData *ack){
            NSArray *roasts = [ReadStatusModel readAllStatusWithData:ack];
            CGFloat temp = [ReadStatusModel readRoastTempAtDatas:roasts];
            NSInteger wind = [ReadStatusModel readRoastWindAtDatas:roasts];
            NSInteger roller = [ReadStatusModel readRoastRollerAtDatas:roasts];
            NSString *date =[ReadStatusModel readRoastTimeAtDatas:roasts];
            NSInteger stageNO = [ReadStatusModel readRoastStageAtDatas:roasts];
            if([ReadStatusModel readRoastStatusAtDatas:roasts] == 5 && !tmpSelf.isRoasted) {
                [tmpSelf.infoView removePopView];
                [tmpSelf.autoView.tempView stopDisplayTarget];
                [tmpSelf.autoView.rollerView stopDisplayTarget];
                tmpSelf.isRoasted = YES;
            }
            
            [tmpSelf.infoView setMessage: [NSString stringWithFormat:@"Time: %@  StageNO: %d  Temperature: %.2f ℃   Wind : %d  Roller: %d",date,stageNO,temp,wind,roller]];
            [tmpSelf.autoView.tempView displayTargetStageNO:stageNO];
            [tmpSelf.autoView.rollerView displayTargetStageNO:stageNO];
        }];
        [tmpSelf performSelector:@selector(readRoastStatus) withObject:nil afterDelay:1];
    }];
}

-(void) checkStatusComplete:(void(^)(void)) complete
{
    if(([ALLModels roastRunedStatus] == RoastRunStatus || [ALLModels roastRunedStatus] == RoastCoolingStatus) && [ALLModels syncConnected])
        complete();
}
@end
