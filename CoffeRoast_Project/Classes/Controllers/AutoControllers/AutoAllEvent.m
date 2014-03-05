//
//  AutoAllEvent.m
//  CoffeRoast_Project
//
//  Created by Bai-Kai-Ren on 2014/3/3.
//  Copyright (c) 2014年 Bai-Kai-Ren. All rights reserved.
//

#import "AutoAllEvent.h"
#import "AutoController.h"
#import "PopInfoView.h"
#import "AutoView.h"

@interface AutoAllEvent () <UIAlertViewDelegate>

@property(nonatomic, weak) AutoController *target;
@end


@implementation AutoAllEvent


-(id) initWithTarget:(id)target
{
    self = [super init];
    if(self) {
        self.target = target;
        [self.target.autoView.rightButton addTarget:self action:@selector(autoRunButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        
        self.target.autoView.tempView.lineDatas =  self.target.roastProfiles.temperatureVaules;
        self.target.autoView.tempView.startPoint =  self.target.roastProfiles.inPutBeanIndex;
        self.target.autoView.tempView.stopPoint =  self.target.roastProfiles.outPutBeanIndex;
        
        self.target.autoView.rollerView.lineDatas =  self.target.roastProfiles.rollerSpeedVaules;
        self.target.autoView.rollerView.windDatas =  self.target.roastProfiles.windSpeedVaules;
    }
    return self;
}

#pragma mark - Auto Run Button Acton
-(void) autoRunButtonAction:(id)sender
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
                    [weakSelf.autoView setRightBarItemImage:@"stopCooling"];
                } else if(index == RoastCoolingStatus) {
                    [ALLModels saveLasyRoastStatus:RoastStopStatus];
                    [weakSelf.autoView setRightBarItemImage:@"btn_Run"];
                    [weakSelf.infoView removePopView];
                    [weakSelf.autoView.tempView stopDisplayTarget];
                    [weakSelf.autoView.rollerView stopDisplayTarget];
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
        NSData *data = [JSonDictToHex roastJsonDictToHexData:self.target.roastJson.roastJsonDict];
        __weak typeof(self.target) weakSelf = self.target;
        [[SocketHadler share]writeHex:CMProfileWriteTemp ackHandle:^(NSData *tempAck) {
            [[SocketHadler share]writeHex:[NSString stringWithFormat:CMProfileWriteBody,[JSonDictToHex dataToHexString:data]] ackHandle:^(NSData* bodyAck) {
                [[SocketHadler share] writeHex:CMControlAutoModeStart ackHandle:^(NSData *roastAck) {
                    [ALLModels saveLasyRoastStatus:RoastRunStatus];
                    weakSelf.isRoasted = NO;
                    [weakSelf.autoView setRightBarItemImage:@"stop"];
                    [weakSelf readRoastStatus];
                    [weakSelf.infoView showInView:weakSelf.view];
                }];
            }];
        }];
    }
}

@end
