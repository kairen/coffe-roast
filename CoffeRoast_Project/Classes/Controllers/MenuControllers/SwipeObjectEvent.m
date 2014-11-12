//
//  PressGestureEvent.m
//  CafeRoast
//
//  Created by Bai-Kai-Ren on 13/9/23.
//  Copyright (c) 2013年 Bai-Kai-Ren. All rights reserved.
//

#import "SwipeObjectEvent.h"
#import "SwipeDeployModel.h"
#import "BasicAnimation.h"
#import "MenuView.h"

@interface SwipeObjectEvent ()
{
    int currentTag;
    BOOL isSwap;
}
@property(nonatomic, weak) MenuView *menuView;
@end

@implementation SwipeObjectEvent

+(id) swipeObjectEventEventInView:(MenuView *)menuView
{
    return [[self alloc] initWithSwipeObjectEventEventInViewInView:menuView];
}

-(id) initWithSwipeObjectEventEventInViewInView:(MenuView *)menuView
{
    self = [super init];
    if(self) {
        self.menuView = menuView;
        
        SwipeDeployModel *configuration = [SwipeDeployModel defaultConfiguration];
        [self.menuView setButtonFrames:configuration.configurationButtonFrameTags];
        
        for(UIButton *btn in self.menuView.arrayOfBtn) {
            [btn addGestureRecognizer:[[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(doMovement:)]];
        }
    }
    return self;
}

#pragma mark - Custom Button Control Method

- (void)doMovement:(UIPanGestureRecognizer *)sender
{
    [sender.view setCenter:[sender locationInView:self.menuView]];
    if(sender.state == UIGestureRecognizerStateBegan) {
        [BasicAnimation shakeAnimationFor:sender.view];
        currentTag = (int)sender.view.tag;
    }
    else if(sender.state == UIGestureRecognizerStateEnded) {
        [sender.view.layer removeAnimationForKey:kShakeAnimation];
        [self moveFrameForView:sender.view withMoveTag:currentTag];
    }
    else if(sender.state == UIGestureRecognizerStateChanged) {
        [self updateEnterFrameForView:sender.view];
    }
}

-(void) updateEnterFrameForView:(UIView*)view
{
    for(int count = 0 ; count <  self.menuView.enterFrames.count ; count++) {
        SwipeFrame *swipeFrame = [self.menuView.enterFrames objectAtIndex:count];
        if(CGRectContainsPoint(swipeFrame.frame,view.center)) {
            if(view.tag != count && !isSwap) {
                currentTag = count;
                if(swipeFrame.isUse) {
                    isSwap = YES;
                    [self swapFrameForView:view withSwapTag:count];
                }
                UIView *showView = [[UIView alloc]initWithFrame:swipeFrame.frame];
                showView.backgroundColor = [UIColor clearColor];
                showView.layer.borderColor = [UIColor blackColor].CGColor;
                showView.layer.borderWidth = 2;
                showView.alpha = 0.0;
                [self.menuView addSubview:showView];
                [UIView animateWithDuration:0.2 animations:^{
                    showView.alpha = 1.0;
                }completion:^(BOOL finish) {
                    [UIView animateWithDuration:0.4 delay:0.5 options:UIViewAnimationOptionCurveEaseIn animations:^{
                        showView.alpha = 0.0;
                    }completion:^(BOOL finish) {
                        [showView removeFromSuperview];
                     }];
                }];
                break;
            }
        }
    }
}

-(void) swapFrameForView:(UIView*)swapView withSwapTag:(int)tag
{
    for(UIButton *btn in self.menuView.arrayOfBtn) {
        if(btn.tag == tag) {
             SwipeFrame *swipeFrame = [self.menuView.enterFrames objectAtIndex:swapView.tag];
            btn.tag = swapView.tag;
            swapView.tag = tag;
            [UIView animateWithDuration:0.2 animations:^{
                btn.frame = swipeFrame.frame;
            } completion:^(BOOL finish) {
                isSwap = NO;
            }];
            break;
        }
    }
}

-(void) moveFrameForView:(UIView*)moveView withMoveTag:(int)tag
{
    SwipeFrame *moveFrame = [self.menuView.enterFrames objectAtIndex:moveView.tag];
    if(moveView.tag != tag ) {
        SwipeFrame *swapFrame = [self.menuView.enterFrames objectAtIndex:tag];
        moveFrame.isUse = NO;
        swapFrame.isUse = YES;
        [self.menuView.enterFrames replaceObjectAtIndex:tag withObject:swapFrame];
        [self.menuView.enterFrames replaceObjectAtIndex:moveView.tag withObject:moveFrame];
        moveView.tag = tag;
        [UIView animateWithDuration:0.2 animations:^{
            moveView.frame = swapFrame.frame;
        }completion:^(BOOL finish){
            isSwap = NO;
        }];
    }
    else {
        [UIView animateWithDuration:0.5 animations:^{
            moveView.frame = moveFrame.frame;
        }];
    }
}

@end
