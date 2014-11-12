//
//  AppDelegate.m
//  CoffeRoast_Project
//
//  Created by Bai-Kai-Ren on 2013/11/28.
//  Copyright (c) 2013年 Bai-Kai-Ren. All rights reserved.
//

#import "AppDelegate.h"
#import "TransitionDelegate.h"
#import "MenuController.h"
#import "DocumentsPaths.h"
#import "BeaconController.h"

@interface AppDelegate () <BeaconDelegate>

@property(nonatomic, strong) UIImageView *imageView;
@property(nonatomic, strong) BeaconController *beaconController;
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [self copyOriginalJson:@"json_profile" toDocument:[DocumentsPaths getDocumentProfileJsonPath]];
    [self copyOriginalJson:@"json_auto" toDocument:[DocumentsPaths getDocumentAutoJsonPath]];
    [self copyOriginalJson:@"json_history" toDocument:[DocumentsPaths getDocumentHistoryJsonPath]];
    [ALLModels saveLasySyncConnectStatus:NO];
    [ALLModels saveLasyRoastStatus:RoastStopStatus];

    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
    self.menuController = [[MenuController alloc]init];
    self.window.rootViewController = self.menuController;
//    self.menuController.transitioningDelegate = (id<UIViewControllerTransitioningDelegate>)[[TransitionDelegate alloc]init];
    application.idleTimerDisabled = YES;
    

    
    self.beaconController = [[BeaconController alloc]init];
    self.beaconController.delegate = self;
    [self.window makeKeyAndVisible];

    return YES;
}

-(void) copyOriginalJson:(NSString*)origin toDocument:(NSString*)document
{
    if(![[NSFileManager defaultManager]fileExistsAtPath:document]) {
        NSString *originFile = [[NSBundle mainBundle]pathForResource:origin ofType:nil];
        if([[NSFileManager defaultManager]fileExistsAtPath:originFile]) {
            [[NSFileManager defaultManager] copyItemAtPath:originFile toPath:document error:nil];
        }
        originFile = nil;
    }
}

-(void) application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    [self addDMView];
}

-(void)enterBeacon
{
    [self addDMView];
}

-(void) leaveBeacon
{
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    self.imageView.transform = CGAffineTransformIdentity;
    [UIView animateWithDuration:0.5 animations:^{
        self.imageView.transform = CGAffineTransformMakeScale(0.0, 0.0);
    } completion:^(BOOL finish) {
        [self.imageView removeFromSuperview];
        self.imageView = nil;
    }];
}

-(void) addDMView
{
    if(!self.imageView) {
        self.imageView = [[UIImageView alloc]initWithFrame:self.window.frame];
        self.imageView.image = [UIImage imageNamed:@"DM.png"];
        [[UIApplication sharedApplication].keyWindow addSubview:self.imageView];
        self.imageView.transform = CGAffineTransformMakeScale(0.0, 0.0);
        [UIView animateWithDuration:0.5 animations:^{
            self.imageView.transform = CGAffineTransformIdentity;
        }];
    }
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
}

@end
