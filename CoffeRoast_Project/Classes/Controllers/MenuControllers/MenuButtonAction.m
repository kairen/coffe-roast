//
//  MenuButtonAction.m
//  CoffeRoast_Project
//
//  Created by Bai-Kai-Ren on 2014/2/21.
//  Copyright (c) 2014年 Bai-Kai-Ren. All rights reserved.
//


#import "MenuButtonAction.h"
#import "SelectFileController.h"
#import "ManualController.h"
#import "HistoryController.h"
#import "SettingController.h"
#import "MenuController.h"
#import "MenuView.h"

@interface MenuButtonAction ()

@property(nonatomic, weak) MenuController *menuController;
@end

@implementation MenuButtonAction

-(id) initWithMenuController:(MenuController *)menuController
{
    self = [super init];
    if(self) {
        self.menuController = menuController;
        [self.menuController.menuView.autoButton addTarget:self action:@selector(intoAutoTableControllerBtnEvent:) forControlEvents:UIControlEventTouchUpInside];
        [self.menuController.menuView.profileButton addTarget:self action:@selector(intoProfileTableControllerBtnEvent:) forControlEvents:UIControlEventTouchUpInside];
        [self.menuController.menuView.settingButton addTarget:self action:@selector(intoSettingControllerBtnEvent:) forControlEvents:UIControlEventTouchUpInside];
        [self.menuController.menuView.manualButton addTarget:self action:@selector(intoManualControllerBtnEvent:) forControlEvents:UIControlEventTouchUpInside];
        [self.menuController.menuView.historyButton addTarget:self action:@selector(intoHistoryControllerBtnEvent:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

#pragma mark - Into Auto Controller
-(void) intoAutoTableControllerBtnEvent:(id)sender
{
    SelectFileController *autoController = [[SelectFileController alloc]init];
    autoController.title = @"Auto";
    autoController.transitioningDelegate = self.menuController.transitioningDelegate;
    [self.menuController presentViewController:autoController animated:YES completion:NULL];
}

#pragma mark - Into Profile Controller
-(void) intoProfileTableControllerBtnEvent:(id)sender
{
    SelectFileController *autoController = [[SelectFileController alloc]init];
    autoController.title = @"Profile";
    autoController.transitioningDelegate = self.menuController.transitioningDelegate;
    [self.menuController presentViewController:autoController animated:YES completion:NULL];
}

#pragma mark - Into Setting Controller
-(void) intoSettingControllerBtnEvent:(id)sender
{
    SettingController *settingController = [[SettingController alloc]init];
    settingController.transitioningDelegate = self.menuController.transitioningDelegate;
    [self.menuController presentViewController:settingController animated:YES completion:NULL];
}

#pragma mark - Into Manual Controller
-(void) intoManualControllerBtnEvent:(id)sender
{
    ManualController *manualController = [[ManualController alloc]init];
    manualController.transitioningDelegate = self.menuController.transitioningDelegate;
    [self.menuController presentViewController:manualController animated:YES completion:NULL];
}

#pragma mark - Into History Controller
-(void) intoHistoryControllerBtnEvent:(id)sender
{
    HistoryController *historyController = [[HistoryController alloc]init];
    historyController.transitioningDelegate = self.menuController.transitioningDelegate;
    [self.menuController presentViewController:historyController animated:YES completion:NULL];
}
@end
