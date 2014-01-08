//
//  MenuController.m
//  CoffeRoast_Project
//
//  Created by Bai-Kai-Ren on 2013/11/28.
//  Copyright (c) 2013年 Bai-Kai-Ren. All rights reserved.
//

#import "MenuController.h"
#import "SocketController.h"
#import "SelectFileController.h"
#import "ManualController.h"
#import "HistoryController.h"
#import "SettingController.h"
#import "SwipeDeployModel.h"
#import "SwipeObjectEvent.h"
#import "MenuView.h"

@interface MenuController ()

@property(nonatomic, strong) SwipeObjectEvent *swipeEvent;
@property(nonatomic, strong) MenuView *menuView;
@end

@implementation MenuController

- (void)viewDidLoad
{
    self.menuView = [[MenuView alloc]initWithFrame:self.frame];
    
    SwipeDeployModel *configuration = [SwipeDeployModel defaultConfiguration];
    [self.menuView setButtonFrames:configuration.configurationButtonFrameTags];
    [self.menuView.rightButton addTarget:self action:@selector(connectSocket:) forControlEvents:UIControlEventTouchUpInside];
    [self.menuView.autoButton addTarget:self action:@selector(intoAutoTableControllerBtnEvent:) forControlEvents:UIControlEventTouchUpInside];
    [self.menuView.profileButton addTarget:self action:@selector(intoProfileTableControllerBtnEvent:) forControlEvents:UIControlEventTouchUpInside];
    [self.menuView.settingButton addTarget:self action:@selector(intoSettingControllerBtnEvent:) forControlEvents:UIControlEventTouchUpInside];
    [self.menuView.manualButton addTarget:self action:@selector(intoManualControllerBtnEvent:) forControlEvents:UIControlEventTouchUpInside];
    [self.menuView.historyButton addTarget:self action:@selector(intoHistoryControllerBtnEvent:) forControlEvents:UIControlEventTouchUpInside];
    
    self.swipeEvent = [SwipeObjectEvent swipeObjectEventEventInView:self.menuView];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(didEnterBackground:) name:UIApplicationDidEnterBackgroundNotification object:nil];
    [self.view addSubview:self.menuView];
}

#pragma mark - Connecting Button
-(void) connectSocket:(id)sender
{
    [self dynamicAnimatorAction:sender];
}

#pragma mark - Background Notification Method
-(void) didEnterBackground:(NSNotification*)notification
{
    NSMutableArray *arrayOfTag = [[NSMutableArray alloc]init];
    for(UIButton *btn in self.menuView.arrayOfBtn) {
        [arrayOfTag addObject:[NSString stringWithFormat:@"%d",(int)btn.tag]];
    }
    [SwipeDeployModel saveConfigurationWithFrames:arrayOfTag];
}

#pragma mark - View Button Events
#pragma mark - Into Auto Controller
-(void) intoAutoTableControllerBtnEvent:(id)sender
{
    SelectFileController *autoController = [[SelectFileController alloc]init];
    autoController.title = @"Auto";
    autoController.transitioningDelegate = self.transitioningDelegate;
    [self presentViewController:autoController animated:YES completion:NULL];
}

#pragma mark - Into Profile Controller
-(void) intoProfileTableControllerBtnEvent:(id)sender
{
    SelectFileController *autoController = [[SelectFileController alloc]init];
    autoController.title = @"Profile";
    autoController.transitioningDelegate = self.transitioningDelegate;
    [self presentViewController:autoController animated:YES completion:NULL];
}

#pragma mark - Into Setting Controller
-(void) intoSettingControllerBtnEvent:(id)sender
{
    SettingController *settingController = [[SettingController alloc]init];
    settingController.transitioningDelegate = self.transitioningDelegate;
    [self presentViewController:settingController animated:YES completion:NULL];
}

#pragma mark - Into Manual Controller
-(void) intoManualControllerBtnEvent:(id)sender
{
    ManualController *manualController = [[ManualController alloc]init];
    manualController.transitioningDelegate = self.transitioningDelegate;
    [self presentViewController:manualController animated:YES completion:NULL];
}

#pragma mark - Into History Controller
-(void) intoHistoryControllerBtnEvent:(id)sender
{
    HistoryController *historyController = [[HistoryController alloc]init];
    historyController.transitioningDelegate = self.transitioningDelegate;
    [self presentViewController:historyController animated:YES completion:NULL];
}

@end
