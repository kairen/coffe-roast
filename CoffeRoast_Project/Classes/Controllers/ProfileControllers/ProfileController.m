//
//  ProfileController.m
//  CoffeRoast_Project
//
//  Created by Bai-Kai-Ren on 2013/12/24.
//  Copyright (c) 2013年 Bai-Kai-Ren. All rights reserved.
//

#import "ProfileController.h"
#import "SelectFileController.h"
#import "EditorListCell.h"
#import "ProfileListEvent.h"
#import "ProfileView.h"
#import "ProfileProtocolHandler.h"
#import "ProfileAllEvent.h"
#import "PopInfoView.h"

@implementation ProfileController

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.profileView = [[ProfileView alloc]initWithFrame:self.frame];
    
    [self.profileView.leftButton addTarget:self action:@selector(dismissViewController) forControlEvents:UIControlEventTouchUpInside];
    
    self.roastProfiles = [RoastProfile roastProfileWithDict:self.roastJson.roastProfiles];
    self.beanProfiles = [BeanProfile beanProfileWithDict:self.roastJson.beanProfiles];
    self.roastJson.roastJsonDict[JSONDateKey] = [ALLModels getNowDate:@"yyyyMMdd"];
    self.beanProfiles.beanPorfile[JSONBeanCropYearKey] = [ALLModels getNowDate:@"yyyyMM"];
    self.roastJson.roastJsonDict[JSONBeanProfileKey] = self.beanProfiles.beanPorfile;
    
    [self.roastJson reloadRoastJSonData];
    
    self.profileAllEvent = [[ProfileAllEvent alloc]initWithTarget:self];
    self.profileListEvent = [ProfileListEvent setListEventView:self.profileView.listView data:self.roastJson];
    self.handler = [[ProfileProtocolHandler alloc]initWithProfileListEvent:self.profileListEvent];
    self.handler.profileView = self.view;
    
    [self.view addSubview:self.profileView];
    
    self.infoView = [PopInfoView popInfoViewWitFrame:CGRectMake(0, 0, 1024, CGRectGetHeight(self.profileView.bottomBar.frame))];
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
    [self.profileView setRightBarItemImage:@"btn_Run"];
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
                [tmpSelf.profileView.tempView stopDisplayTarget];
                [tmpSelf.profileView.rollerView stopDisplayTarget];
                tmpSelf.isRoasted = YES;
            }
            [tmpSelf.infoView setMessage: [NSString stringWithFormat:@"Time: %@  StageNO: %d  Temperature: %.2f ℃   Wind : %ld  Roller: %ld",date,stageNO,temp,(long)wind,(long)roller]];
            [tmpSelf.profileView.tempView displayTargetStageNO:stageNO];
            [tmpSelf.profileView.rollerView displayTargetStageNO:stageNO];
        }];
        [tmpSelf performSelector:@selector(readRoastStatus) withObject:nil afterDelay:1];
    }];
}

-(void) reloadRoastData
{
    int i = 0;
    for(NSString *key in [ALLModels editorTitleVauleKeys]) {
        if(![key isEqualToString:JSONDateKey] && ![key isEqualToString:JSONBeanCropYearKey]) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
            EditorListCell *editorListCell = (EditorListCell*)[self.profileView.listView cellForRowAtIndexPath:indexPath];
            if(![key isEqualToString:JSONNoteKey]) {
                if(i >= 4 && i <= 11) {
                    if([self.beanProfiles.beanPorfile[key] isKindOfClass:[NSNumber class]]) {
                        self.beanProfiles.beanPorfile[key] = [NSNumber numberWithInt:[editorListCell.textField.text integerValue]];
                    } else  {
                        self.beanProfiles.beanPorfile[key] = editorListCell.textField.text;
                    }
                } else {
                    if([self.roastJson.roastJsonDict[key] isKindOfClass:[NSNumber class]]) {
                        self.roastJson.roastJsonDict[key] = [NSNumber numberWithInt:[editorListCell.textField.text integerValue]];
                    } else  {
                        self.roastJson.roastJsonDict[key] = editorListCell.textField.text;
                    }
                }
            } else {
                self.roastJson.roastJsonDict[key] = editorListCell.textView.text;
            }
        }
        i++;
    }
    [self.roastProfiles setLoadGreenBean:self.profileView.tempView.startPoint loadRoastedBean:self.profileView.tempView.stopPoint stop:self.profileView.tempView.stopPoint + 2];
    [self.roastProfiles setRoastPorfileVaules:self.profileView.tempView.lineDatas withKey:JSONRoastTemperatureKey];
    [self.roastProfiles setRoastPorfileVaules:self.profileView.rollerView.windDatas withKey:JSONRoastWindSpeedKey];
    [self.roastProfiles setRoastPorfileVaules:self.profileView.rollerView.lineDatas withKey:JSONRoastRollerSpeedKey];
    
    self.roastProfiles.roastProfile[JSONRoastProfileCharKey] = self.roastProfiles.roastProfileChars;
    self.roastJson.roastJsonDict[JSONRoastProfileKey] = self.roastProfiles.roastProfile;
    
    [self.roastJson reloadRoastJSonData];
}

-(void) checkSaveRepeatFileName:(NSString*)fileName duplicate:(BOOL)dup
{
    NSData *json = [NSJSONSerialization dataWithJSONObject:self.roastJson.roastJsonDict options:0 error:nil];
    NSString *JSONString = [[NSString alloc] initWithBytes:[json bytes] length:[json length] encoding:NSUTF8StringEncoding];
    if(!dup) {
        if([[NSFileManager defaultManager] fileExistsAtPath:[[DocumentsPaths getDocumentProfileJsonPath] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.crp",fileName]]] ){
            UIAlertView *saveView = [[UIAlertView alloc]initWithTitle:@"Message" message:@"Duplicate files named .." delegate:self.profileAllEvent cancelButtonTitle:@"Cancel" otherButtonTitles:@"Duplicate", nil];
            saveView.tag = 3;
            [saveView show];
        } else {
            [JSONString writeToFile:[[DocumentsPaths getDocumentProfileJsonPath] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.crp",fileName]] atomically:YES encoding:NSUTF8StringEncoding error:NULL];
        }
    } else {
        [JSONString writeToFile:[[DocumentsPaths getDocumentProfileJsonPath] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.crp",fileName]] atomically:YES encoding:NSUTF8StringEncoding error:NULL];
    }
}

-(void) checkStatusComplete:(void(^)(void)) complete
{
    if(([ALLModels roastRunedStatus] == RoastRunStatus || [ALLModels roastRunedStatus] == RoastCoolingStatus) && [ALLModels syncConnected])
        complete();
}

@end
