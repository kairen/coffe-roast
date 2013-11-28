//
//  BaseController.m
//  CoffeRoast_Project
//
//  Created by Bai-Kai-Ren on 2013/11/28.
//  Copyright (c) 2013年 Bai-Kai-Ren. All rights reserved.
//

#import "BaseController.h"
#import "TransitionAnimation.h"

@interface BaseController ()

@property(nonatomic, strong) TransitionAnimation *presentAnimation;
@end

@implementation BaseController

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.presentAnimation = [TransitionAnimation new];
}

-(void) dismissViewController
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(viewControllerDidDismissModal:)]) {
        [self.delegate viewControllerDidDismissModal:self];
    }
}

-(void) viewControllerDidDismissModal:(BaseController *)viewController
{
    [self dismissViewControllerAnimated:YES completion:nil];
    viewController = nil;
}

#pragma mark - Transition Delegate
-(id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    return self.presentAnimation;
}

-(id<UIViewControllerAnimatedTransitioning>) animationControllerForDismissedController:(UIViewController *)dismissed
{
    return self.presentAnimation;
}

#pragma mark - dealloc
-(void)dealloc
{
    self.view = nil;
    NSLog(@"%@ , dealloc",self);
}

#pragma mark - Memory Method
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - View Deploy
-(BOOL) shouldAutorotate
{
    return YES;
}

-(NSUInteger) supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskLandscapeLeft;
}

@end
