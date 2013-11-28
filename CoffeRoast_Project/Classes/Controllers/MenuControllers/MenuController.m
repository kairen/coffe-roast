//
//  MenuController.m
//  CoffeRoast_Project
//
//  Created by Bai-Kai-Ren on 2013/11/28.
//  Copyright (c) 2013年 Bai-Kai-Ren. All rights reserved.
//

#import "MenuController.h"
#import "SocketController.h"
#import "SwipeDeployModel.h"
#import "SwipeObjectEvent.h"
#import "AutonController.h"
#import "MenuView.h"

@interface MenuController ()

@property(nonatomic, strong) SwipeObjectEvent *swipeEvent;
@end

@implementation MenuController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view = [[MenuView alloc]initWithFrame:self.view.frame];
    
    SwipeDeployModel *configuration = [SwipeDeployModel defaultConfiguration];
    [(MenuView*)self.view setButtonFrames:configuration.configurationButtonFrameTags];
    self.swipeEvent = [SwipeObjectEvent swipeObjectEventEventInView:(MenuView*)self.view];
    [self.swipeEvent startReceiveEvent];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(didEnterBackground:) name:UIApplicationDidEnterBackgroundNotification object:nil];
    
    configuration = nil;
}

#pragma mark - Background Notification Method
-(void) didEnterBackground:(NSNotification*)notification
{
    MenuView *menuView = (MenuView*)self.view;
    NSMutableArray *arrayOfTag = [[NSMutableArray alloc]init];
    for(UIButton *btn in menuView.arrayOfBtn) {
        [arrayOfTag addObject:[NSString stringWithFormat:@"%d",(int)btn.tag]];
    }
    [SwipeDeployModel saveConfigurationWithFrames:arrayOfTag];
}

-(void) delayModalController
{
    AutonController *autoController = [[AutonController alloc]init];
    autoController.transitioningDelegate  = self;
    autoController.delegate = self;
    [self presentViewController:autoController animated:YES completion:nil];
}

@end
