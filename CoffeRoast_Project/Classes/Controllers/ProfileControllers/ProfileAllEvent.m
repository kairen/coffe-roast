//
//  ProfileButtonAction.m
//  CoffeRoast_Project
//
//  Created by Bai-Kai-Ren on 2014/3/3.
//  Copyright (c) 2014年 Bai-Kai-Ren. All rights reserved.
//

#import "ProfileAllEvent.h"
#import "ProfileController.h"
#import "ProfileView.h"
#import "PopInfoView.h"

@interface ProfileAllEvent () <UIAlertViewDelegate>

@property(nonatomic, weak) ProfileController *target;
@end

@implementation ProfileAllEvent

-(id) initWithTarget:(id)target
{
    self = [super init];
    if(self) {
        self.target = target;
        [self.target.profileView.midButton addTarget:self action:@selector(saveButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.target.profileView.rightButton addTarget:self action:@selector(profileRunButtonAction:) forControlEvents:UIControlEventTouchUpInside];

        
        self.target.profileView.tempView.lineDatas =  self.target.roastProfiles.temperatureVaules;
        self.target.profileView.tempView.startPoint =  self.target.roastProfiles.inPutBeanIndex;
        self.target.profileView.tempView.stopPoint =  self.target.roastProfiles.outPutBeanIndex;
        
        self.target.profileView.rollerView.lineDatas =  self.target.roastProfiles.rollerSpeedVaules;
        self.target.profileView.rollerView.windDatas =  self.target.roastProfiles.windSpeedVaules;
  
    }
    return self;
}

#pragma mark - Save Button Action
-(void) saveButtonAction:(id)sender
{
    UIAlertView *saveView = [[UIAlertView alloc]initWithTitle:@"Message" message:@"Save ?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Save", nil];
    saveView.tag = 1;
    [saveView show];
}

#pragma mark - Profile Run ButtonA ction
-(void) profileRunButtonAction:(id)sender
{
    if([ALLModels syncConnected]) {
        NSString *command = nil;
        RoastStatus index = [ALLModels roastRunedStatus];
        if(index == RoastStopStatus) {
            UIAlertView *saveView = [[UIAlertView alloc]initWithTitle:@"Message" message:@"Run ?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Run", nil];
            saveView.tag = 2;
            [saveView show];
        } else if(index == RoastRunStatus) {
            command = CMControlStopRoast;
        } else if(index == RoastCoolingStatus) {
            command = CMControlStopCooling;
        }
        if(command) {
             __weak typeof(self.target) weakSelf = self.target;
            [[SocketHadler share] writeHex:command ackHandle:^(NSData *ack){
                if(index == RoastRunStatus) {
                    [ALLModels saveLasyRoastStatus:RoastCoolingStatus];
                    [weakSelf.profileView setRightBarItemImage:@"stopCooling"];
                } else if(index == RoastCoolingStatus) {
                    [ALLModels saveLasyRoastStatus:RoastStopStatus];
                    [weakSelf.profileView setRightBarItemImage:@"btn_Run"];
                    [weakSelf.infoView removePopView];
                    [weakSelf.profileView.tempView stopDisplayTarget];
                    [weakSelf.profileView.rollerView stopDisplayTarget];
                    NSData *json = [NSJSONSerialization dataWithJSONObject:weakSelf.roastJson.roastJsonDict options:0 error:nil];
                    NSString *JSONString = [[NSString alloc] initWithBytes:[json bytes] length:[json length] encoding:NSUTF8StringEncoding];
                    [JSONString writeToFile:[[DocumentsPaths getDocumentHistoryJsonPath] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.crp",[ALLModels getNowDate:@"yyyyMMddhhmmss"]]] atomically:YES encoding:NSUTF8StringEncoding error:NULL];
                }
            }];
        }
    }
}

-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 1 ) {
        [self.target reloadRoastData];
        if(alertView.tag == 2) {
            NSData *data = [JSonDictToHex roastJsonDictToHexData:self.target.roastJson.roastJsonDict];
            __weak typeof(self.target) weakSelf = self.target;
            [[SocketHadler share]writeHex:CMProfileWriteTemp ackHandle:^(NSData *tempAck) {
                [[SocketHadler share]writeHex:[NSString stringWithFormat:CMProfileWriteBody,[JSonDictToHex dataToHexString:data]] ackHandle:^(NSData* bodyAck) {
                    [[SocketHadler share] writeHex:CMControlAutoModeStart ackHandle:^(NSData *roastAck) {
                        [ALLModels saveLasyRoastStatus:RoastRunStatus];
                        weakSelf.isRoasted = NO;
                        [weakSelf.profileView setRightBarItemImage:@"stop"];
                        [weakSelf readRoastStatus];
                        [weakSelf.infoView showInView:weakSelf.view];
                    }];
                }];
            }];
        } else {
            [self.target reloadRoastData];
            if(![self.target.roastJson.profileName isEqualToString:@""]) {
                if(alertView.tag == 1) {
                    [self.target checkSaveRepeatFileName:self.target.roastJson.profileName duplicate:NO];
                } else {
                    [self.target checkSaveRepeatFileName:self.target.roastJson.profileName duplicate:YES];
                }
            }
        }
    }
}

@end
