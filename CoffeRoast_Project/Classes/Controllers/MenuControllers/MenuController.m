//
//  MenuController.m
//  CoffeRoast_Project
//
//  Created by Bai-Kai-Ren on 2013/11/28.
//  Copyright (c) 2013年 Bai-Kai-Ren. All rights reserved.
//

#import "MenuController.h"
#import "SwipeDeployModel.h"
#import "SwipeObjectEvent.h"
#import "MenuButtonAction.h"
#import "MenuView.h"

@interface MenuController () <UIAlertViewDelegate>
{
    NSString *deviceInfo;
}
@property(nonatomic, strong) SwipeObjectEvent *swipeEvent;
@property(nonatomic, strong) UIAlertView *wifiMessage;
@property(nonatomic, strong) MenuButtonAction *menuButtonAction;
@end

@implementation MenuController

- (void)viewDidLoad
{
    self.menuView = [[MenuView alloc]initWithFrame:self.frame];

    [self.menuView.rightButton addTarget:self action:@selector(connectSocket:) forControlEvents:UIControlEventTouchUpInside];
    self.swipeEvent = [SwipeObjectEvent swipeObjectEventEventInView:self.menuView];
    self.menuButtonAction = [[MenuButtonAction alloc]initWithMenuController:self];
    
    [[SocketHadler share] socketConnectToHost:[ALLModels ipAddress] onPort:[[ALLModels ipPort] integerValue] withTimeout:10];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(didEnterBackground:) name:UIApplicationDidEnterBackgroundNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(socketDidConnect) name:kSocketDidConnect object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(socketDiddisConnect) name:kSocketDisConnect object:nil];
    [self.view addSubview:self.menuView];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(machineCloseNotification) name:kSocketMachineClose object:nil];
}

-(void) machineCloseNotification
{
    [self.menuView setLeftBarItemImage:@""];
    [self.menuView setRightBarItemImage:@"MainScreen_connection"];
    [ALLModels saveLasySyncConnectStatus:NO];
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

#pragma mark - Notification Center did Connect
-(void) socketDidConnect
{
    [self.menuView setLeftBarItemImage:@"wifi-icon-hi"];
    self.menuView.leftButton.userInteractionEnabled = NO;
    [[SocketHadler share] writeHex:CMSyncIdentification ackHandle:^(NSData *ack) {
        deviceInfo = [DeviceInfoModel deviceModelAtData:ack];
    }];
}

#pragma mark - Notification Center dis Connect
-(void) socketDiddisConnect
{
    [self.menuView setLeftBarItemImage:@""];
    [self.menuView setRightBarItemImage:@"MainScreen_connection"];
    [ALLModels saveLasySyncConnectStatus:NO];
//    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"WiFi Status" message:@"disconnected ..." delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil];
//    [alert show];
}

#pragma mark - Connecting Button
-(void) connectSocket:(id)sender
{
    __weak typeof(self) menuSelf = self;
    if([SocketHadler share].connected) {
        if(![ALLModels syncConnected]) {
            [[SocketHadler share] writeHex:CMSyncConnection ackHandle:^(NSData *ack) {
                [menuSelf.menuView setRightBarItemImage:@"MainScreen_disconnection"];
                [ALLModels saveLasySyncConnectStatus:YES];
                [[SocketHadler share] writeHex:CMDeviceHDVersion ackHandle:^(NSData *hdAck) {
                    deviceInfo = [deviceInfo stringByAppendingFormat:@",%@",[DeviceInfoModel deviceModelAtData:hdAck]];
                    [ALLModels saveDeviceInfo:deviceInfo];
                    [[SocketHadler share]writeHex:CMCalibrateDateRequest ackHandle:^(NSData *ack) {
                        [[SocketHadler share] writeHex:[NSString stringWithFormat:CMCalibrateTimeFormate,[JSonDictToHex stringToHexString:[ALLModels getNowDate:@"yyMMddHHmmss"]]] ackHandle:nil];
                    }];
                }];
            } ];
        } else {
            [[SocketHadler share] writeHex:CMSyncDisConnection ackHandle:^(NSData *ack) {
                [menuSelf.menuView setRightBarItemImage:@"MainScreen_connection"];
                [ALLModels saveLasySyncConnectStatus:NO];
            }];
        }
    }
}

#pragma mark - Alert View Delegate
-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [[SocketHadler share] socketConnectToHost:[ALLModels ipAddress] onPort:[[ALLModels ipPort] integerValue] withTimeout:10];
}
@end
