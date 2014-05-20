//
//  ManualController.m
//  CoffeRoast_Project
//
//  Created by Bai-Kai-Ren on 2013/12/31.
//  Copyright (c) 2013年 Bai-Kai-Ren. All rights reserved.
//

#import "ManualController.h"
#import "ProfileController.h"
#import "ManualView.h"
#import "RoastJSONModel.h"
#import "ManualEvents.h"
#import "PopInfoView.h"

@implementation ManualController
- (void)viewDidLoad
{
    [super viewDidLoad];
	self.manualView = [[ManualView alloc]initWithFrame:self.frame];
    [self.manualView.leftButton addTarget:self action:@selector(dismissViewController) forControlEvents:UIControlEventTouchUpInside];
    self.manualEvents = [[ManualEvents alloc]initWithManualController:self];
 
    [self.view addSubview:self.manualView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(machineCloseNotification) name:kSocketMachineClose object:nil];
      self.infoView = [PopInfoView popInfoViewWitFrame:CGRectMake(0, 0, 1024, CGRectGetHeight(self.manualView.bottomBar.frame))];
    [self defaultValueSet];
}

-(void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kSocketMachineClose object:nil];
}

#pragma mark - Notification 
-(void) machineCloseNotification
{
    [ALLModels saveLasySyncConnectStatus:NO];
    [self defaultValueSet];
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
            
            NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:tmpSelf.roastPorfiles.roastProfileChars[tmpSelf.stageIndex]];
            dict[JSONRoastTemperatureKey] = [NSNumber numberWithInt:temp];
            dict[JSONRoastWindSpeedKey] = [NSNumber numberWithInt:wind];
            dict[JSONRoastRollerSpeedKey] = [NSNumber numberWithInt:roller];
            [tmpSelf.roastPorfiles.roastProfileChars replaceObjectAtIndex:tmpSelf.stageIndex withObject:dict];
            
            tmpSelf.manualView.tempView.lineDatas = tmpSelf.roastPorfiles.temperatureVaules;
            tmpSelf.manualView.rollerView.lineDatas = tmpSelf.roastPorfiles.rollerSpeedVaules;
            tmpSelf.manualView.rollerView.windDatas = tmpSelf.roastPorfiles.windSpeedVaules;
            
            [tmpSelf.infoView setMessage: [NSString stringWithFormat:@"Time: %d  StageNO: %d  Temperature: %.2f ℃   Wind : %d  Roller: %d",tmpSelf.stageSec,tmpSelf.stageIndex,temp,wind,roller]];
            
            if(wind >= 3 && self.isLoadRoasted && tmpSelf.manualView.tempView.stopPoint < self.stageIndex) {
                [tmpSelf.manualView setBarButtonHidden:NO withButton:tmpSelf.manualView.midButton];
            } else {
                [tmpSelf.manualView setBarButtonHidden:YES withButton:tmpSelf.manualView.midButton];
            }
            
            [(UILabel*)tmpSelf.manualView.labels[0] setText:[ReadStatusModel readRoastTimeAtDatas:roasts]];
        }];
        [tmpSelf performSelector:@selector(readRoastStatus) withObject:nil afterDelay:1];
    }];
}

-(void) defaultValueSet
{
    for(UISlider *slider in self.manualView.sliders) {
        slider.value = 0;
        [(UILabel*)self.manualView.labels[slider.tag] setText:[NSString stringWithFormat:@"%d",(int)slider.value]];
    }
    [(UILabel*)self.manualView.labels[0] setText:@"00:00"];
    
    NSData *jsonData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"newJsonFile.crp" ofType:nil]];
    if(self.roastJson) {
        self.roastJson = nil;
        self.roastPorfiles = nil;
    }
    self.roastJson = [RoastJSONModel roastJSONDataWithDict:[NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:NULL]];
    self.roastPorfiles = [RoastProfile roastProfileWithDict:self.roastJson.roastProfiles];
    
    self.manualView.tempView.lineDatas = self.roastPorfiles.temperatureVaules;
    self.manualView.rollerView.lineDatas = self.roastPorfiles.rollerSpeedVaules;
    self.manualView.rollerView.windDatas = self.roastPorfiles.windSpeedVaules;
    [self.manualView setBarButtonHidden:NO withButton:self.manualView.loadGreenBtn];
    [self.manualView setBarButtonHidden:YES withButton:self.manualView.loadRoastBtn];
    [self.manualView setBarButtonHidden:NO withButton:self.manualView.midButton];
    [ALLModels saveLasyRoastStatus:RoastStopStatus];
    self.manualView.tempView.startPoint = 0;
    self.manualView.tempView.stopPoint = 0;
    self.stageIndex = 0;
    self.stageSec = 0;
    self.stageControl = 0;
    self.isLoadRoasted = NO;
    if(self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
}

-(void) endRoastSaveProfile
{
    self.roastPorfiles.roastProfile[JSONRoastProfileCharKey] = self.roastPorfiles.roastProfileChars;
    self.roastJson.roastJsonDict[JSONRoastProfileKey] = self.roastPorfiles.roastProfile;
    
    ProfileController *profileController = [[ProfileController alloc]init];
    profileController.roastJson = [RoastJSONModel roastJSONDataWithDict:self.roastJson.roastJsonDict];
//    profileController.transitioningDelegate = self.transitioningDelegate;
    [self presentViewController:profileController animated:YES completion:nil];
}

-(void) checkStatusComplete:(void(^)(void)) complete
{
    if(([ALLModels roastRunedStatus] == RoastRunStatus || [ALLModels roastRunedStatus] == RoastCoolingStatus ) && [ALLModels syncConnected])
        complete();
}
@end
