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
    self.window.rootViewController.transitioningDelegate = (id<UIViewControllerTransitioningDelegate>)[TransitionDelegate new];
    application.idleTimerDisabled = YES;
    
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
@end
