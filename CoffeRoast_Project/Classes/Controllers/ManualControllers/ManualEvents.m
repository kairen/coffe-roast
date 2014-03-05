//
//  ManualEvents.m
//  CoffeRoast_Project
//
//  Created by Bai-Kai-Ren on 2014/2/23.
//  Copyright (c) 2014年 Bai-Kai-Ren. All rights reserved.
//

#import "ManualEvents.h"
#import "ManualController.h"
#import "ManualView.h"
#import "RoastJSONModel.h"
#import "PopInfoView.h"

@implementation ManualEvents

-(id)initWithManualController:(ManualController *)controller
{
    self = [super init];
    if(self) {
        self.manualController = controller;
        [controller.manualView.midButton addTarget:self action:@selector(startButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [controller.manualView.loadGreenBtn addTarget:self action:@selector(loadGreenBeanAction:) forControlEvents:UIControlEventTouchUpInside];
        [controller.manualView.loadRoastBtn addTarget:self action:@selector(loadRoastedBeanAction:) forControlEvents:UIControlEventTouchUpInside];
        [controller.manualView.timeStampBtn addTarget:self action:@selector(setTimeStampAction:) forControlEvents:UIControlEventTouchUpInside];
        
        for(UISlider *slider in controller.manualView.sliders) {
            [slider addTarget:self action:@selector(sliderSwipeAction:) forControlEvents:UIControlEventValueChanged];
            [slider addTarget:self action:@selector(sliderSwipeDone:) forControlEvents:UIControlEventTouchUpInside|UIControlEventTouchUpOutside];
        }
    }
    return self;
}

#pragma makr - Slider Swipe Action
-(void) sliderSwipeAction:(UISlider*)slider
{
    [(UILabel*)self.manualController.manualView.labels[slider.tag] setText:[NSString stringWithFormat:@"%d",(int)slider.value]];
}

-(void) sliderSwipeDone:(id)sender
{
    __weak typeof(self.manualController) manualSelf = self.manualController;
    int temp = (int)[(UISlider*)manualSelf.manualView.sliders[0] value];
    int wind = (int)[(UISlider*)manualSelf.manualView.sliders[1] value];
    int roller = (int)[(UISlider*)manualSelf.manualView.sliders[2] value];
    [manualSelf checkStatusComplete:^{
        [[SocketHadler share] writeHex:CMControlWriteParaIndex ackHandle:^(NSData *ack){
            [[SocketHadler share] writeHex:[NSString stringWithFormat:CMControlValue,temp,roller,wind] ackHandle:nil];
        }];
    }];
}

#pragma makr - Start Button Action
-(void) startButtonAction:(id)sender
{
    __weak typeof(self.manualController) manualSelf = self.manualController;
    if([ALLModels syncConnected]) {
        NSString *command = nil;
        RoastStatus index = [ALLModels roastRunedStatus];
        if(index == RoastStopStatus) {
            command = CMControlManualModeStart;
        } else if(index == RoastRunStatus) {
            command = CMControlStopRoast;
        } else if(index == RoastCoolingStatus) {
            command = CMControlStopCooling;
        }
        if(command) {
            if(manualSelf.stageControl == 0) {
                [[SocketHadler share] writeHex:command ackHandle:^(NSData *ack){
                    if(index == RoastStopStatus) {
                        [manualSelf.manualView setMiddleBarItemImage:@"stop"];
                        [manualSelf.manualView setBarButtonHidden:YES withButton:manualSelf.manualView.midButton];
                        [ALLModels saveLasyRoastStatus:RoastRunStatus];
                        manualSelf.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(stageTimerAction:) userInfo:nil repeats:YES];
                        [manualSelf readRoastStatus];
                        [manualSelf.infoView showInView:manualSelf.view];
                    } else if(index == RoastRunStatus) {
                        [manualSelf.manualView setMiddleBarItemImage:@"stopCooling"];
                        NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:manualSelf.roastPorfiles.roastProfileChars[manualSelf.stageIndex]];
                        dict[JSONRoastControlItemKey] = [NSNumber numberWithInt:StopRoastItem];
                        [manualSelf.roastPorfiles.roastProfileChars replaceObjectAtIndex:manualSelf.stageIndex withObject:dict];
                        [ALLModels saveLasyRoastStatus:RoastCoolingStatus];
                    } else if(index == RoastCoolingStatus) {
                        [manualSelf endRoastSaveProfile];
                        [manualSelf defaultValueSet];
                        [manualSelf.infoView removePopView];
                        [ALLModels saveLasyRoastStatus:RoastStopStatus];
                        [manualSelf.manualView setMiddleBarItemImage:@"start"];
                    }
                }];
            }
        }
    }
}

-(void) stageTimerAction:(NSTimer*)_timer
{
    self.manualController.stageSec ++;
    if(self.manualController.stageSec > 300 && self.manualController.stageIndex > 0) {
       NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:self.manualController.roastPorfiles.roastProfileChars[self.manualController.stageIndex]];
        dict[JSONRoastTimeKey] = [NSNumber numberWithInt:self.manualController.stageSec / 60];
        [self.manualController.roastPorfiles.roastProfileChars replaceObjectAtIndex:self.manualController.stageIndex withObject:dict];
        self.manualController.stageControl = 0;
        self.manualController.stageSec = 0;
        self.manualController.stageIndex++;
    }
}

#pragma mark - Load Green Bean
-(void) loadGreenBeanAction:(id)sender
{
    __weak typeof(self.manualController) manualSelf = self.manualController;
    __weak typeof(self) weakSelf = self;
    [manualSelf checkStatusComplete:^{
        if(manualSelf.stageControl == 0  && manualSelf.stageIndex > 1) {
            [[SocketHadler share] writeHex:CMControlWriteParaIndex ackHandle:^(NSData *ack){
                [[SocketHadler share] writeHex:CMControlLoadGreenBean ackHandle:^(NSData *bAck) {
                    [manualSelf.manualView setBarButtonHidden:YES withButton:manualSelf.manualView.loadGreenBtn];
                    [manualSelf.manualView setBarButtonHidden:NO withButton:manualSelf.manualView.loadRoastBtn];
                    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:manualSelf.roastPorfiles.roastProfileChars[manualSelf.stageIndex]];
                    dict[JSONRoastControlItemKey] = [NSNumber numberWithInt:LoadGreenBeanItem];
                    [manualSelf.roastPorfiles.roastProfileChars replaceObjectAtIndex:manualSelf.stageIndex withObject:dict];
                    manualSelf.stageControl = LoadGreenBeanItem;
                    manualSelf.manualView.tempView.startPoint = manualSelf.stageIndex;
                    [manualSelf.manualView.sliders[1] setValue:3 animated:YES];
                    [weakSelf sliderSwipeAction:manualSelf.manualView.sliders[1]];
                    [self sliderSwipeDone:nil];
                }];
            }];
        }
    }];
}

-(void) loadRoastedBeanAction:(id)sender
{
    __weak typeof(self.manualController) manualSelf = self.manualController;
    __weak typeof(self) weakSelf = self;
    [manualSelf checkStatusComplete:^{
        if(manualSelf.stageControl == 0) {
            [[SocketHadler share] writeHex:CMControlWriteParaIndex ackHandle:^(NSData *ack){
                [[SocketHadler share] writeHex:CMControlLoadRoastedBean ackHandle:^(NSData *rAck) {
                    [manualSelf.manualView setBarButtonHidden:YES withButton:manualSelf.manualView.loadRoastBtn];
                    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:manualSelf.roastPorfiles.roastProfileChars[manualSelf.stageIndex]];
                    dict[JSONRoastControlItemKey] = [NSNumber numberWithInt:LoadRoastedBeanItem];
                    [manualSelf.roastPorfiles.roastProfileChars replaceObjectAtIndex:manualSelf.stageIndex withObject:dict];
                    manualSelf.isLoadRoasted = YES;
                    manualSelf.stageControl = LoadRoastedBeanItem;
                    manualSelf.manualView.tempView.stopPoint = manualSelf.stageIndex;
                    [manualSelf.manualView.sliders[1] setValue:3 animated:YES];
                    [weakSelf sliderSwipeAction:manualSelf.manualView.sliders[1]];
                    [self sliderSwipeDone:nil];
                }];
            }];
        }
    }];
}

#pragma mark - Set Time Stamp
-(void) setTimeStampAction:(id)sender
{
    __weak typeof(self.manualController) manualSelf = self.manualController;
    [manualSelf checkStatusComplete:^{
        [[SocketHadler share] writeHex:CMControlSetTimeStamp ackHandle:^(NSData *ack) {
            if(manualSelf.stageSec > 60 && manualSelf.stageSec <= 300 ) {
                NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:manualSelf.roastPorfiles.roastProfileChars[manualSelf.stageIndex]];
                dict[JSONRoastTimeKey] = [NSNumber numberWithInt:manualSelf.stageSec / 60];
                [manualSelf.roastPorfiles.roastProfileChars replaceObjectAtIndex:manualSelf.stageIndex withObject:dict];
                manualSelf.stageIndex ++;
                manualSelf.stageSec = 0;
                manualSelf.stageControl = 0;
            }
        }];
    }];
}

@end
