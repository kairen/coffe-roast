//
//  BaseController.m
//  CoffeRoast_Project
//
//  Created by Bai-Kai-Ren on 2013/11/28.
//  Copyright (c) 2013年 Bai-Kai-Ren. All rights reserved.
//

#import "BaseController.h"
#include "PositionToBoundsMapping.h"

@interface BaseController ()

@property(nonatomic, strong) UIDynamicAnimator *animator;
@property(nonatomic, weak) UIButton *dynamicButton;
@property(nonatomic) CGRect buttonFrame;

@end


@implementation BaseController

-(void) dismissViewController
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

#pragma mark - Button Audio Event

-(void) playAudioWithFile:(NSString*)file
{
    SystemSoundID soundID;
    NSURL *sound_url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:file ofType:nil]];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)sound_url, &soundID);
    AudioServicesPlaySystemSound(soundID);
    AudioServicesAddSystemSoundCompletion(soundID, NULL, NULL, systemSoundCompletion, NULL);
}

static void systemSoundCompletion(SystemSoundID sound_id, void* user_data)
{
    AudioServicesRemoveSystemSoundCompletion(sound_id);
}

#pragma mark - Memory Method
-(void) dynamicAnimatorAction:(id)sender
{

    if(self.dynamicButton != sender) {
        self.dynamicButton = sender;
        self.buttonFrame =  self.dynamicButton.bounds;
    } else {
        self.dynamicButton.bounds = self.buttonFrame;
    }
    UIDynamicAnimator *animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    
    PositionToBoundsMapping *buttonBoundsDynamicItem = [[PositionToBoundsMapping alloc] initWithTarget:sender];
    
    UIAttachmentBehavior *attachmentBehavior = [[UIAttachmentBehavior alloc] initWithItem:buttonBoundsDynamicItem attachedToAnchor:buttonBoundsDynamicItem.center];
    [attachmentBehavior setFrequency:2.0];
    [attachmentBehavior setDamping:0.3];
    [animator addBehavior:attachmentBehavior];
    
    UIPushBehavior *pushBehavior = [[UIPushBehavior alloc] initWithItems:@[buttonBoundsDynamicItem] mode:UIPushBehaviorModeInstantaneous];
    pushBehavior.angle = 1;
    pushBehavior.magnitude = 10.0;
    [animator addBehavior:pushBehavior];
    
    [pushBehavior setActive:YES];
    
    self.animator = animator;
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

-(CGRect) frame
{
    CGRect frame;
    if(UIInterfaceOrientationIsLandscape(self.interfaceOrientation)) {
        frame = CGRectMake(0, 0, CGRectGetHeight(self.view.frame), CGRectGetWidth(self.view.frame));
    }
    else {
        frame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame));
    }
    return UIInterfaceOrientationIsLandscape(self.interfaceOrientation) ? CGRectMake(0, 0, CGRectGetHeight(self.view.frame), CGRectGetWidth(self.view.frame)): CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame));
}

@end
