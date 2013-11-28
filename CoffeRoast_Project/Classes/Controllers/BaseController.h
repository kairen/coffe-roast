//
//  BaseController.h
//  CoffeRoast_Project
//
//  Created by Bai-Kai-Ren on 2013/11/28.
//  Copyright (c) 2013年 Bai-Kai-Ren. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BaseController;

@protocol ControllerDisModalDelegate<NSObject>

@required
-(void) viewControllerDidDismissModal:(BaseController *)viewController;
@end

@interface BaseController : UIViewController <UIViewControllerTransitioningDelegate,ControllerDisModalDelegate>

@property(nonatomic, weak) id<ControllerDisModalDelegate>delegate;

-(void) dismissViewController;

@end

