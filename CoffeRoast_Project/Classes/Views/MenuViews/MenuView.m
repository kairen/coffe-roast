//
//  MenuView.m
//  CoffeRoast_Project
//
//  Created by Bai-Kai-Ren on 2013/11/28.
//  Copyright (c) 2013年 Bai-Kai-Ren. All rights reserved.
//

#import "MenuView.h"

@implementation MenuView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setTitle:@"Coffe Controller" logoImage:@"main_logo.png"];
        [self setRightBarItemImage:@"MainScreen_connection"];
        
        self.autoButton = [[UIButton alloc]initWithFrame:CGRectMake(6, self.titleBar.frame.size.height + 6, 208, 208)];
        [self buttonWithNormalImageName:@"MainScreen_auto" forBtn:self.autoButton withTag:0];
        
        self.profileButton = [[UIButton alloc]initWithFrame:CGRectMake(6, self.autoButton.frame.origin.y +  self.autoButton.frame.size.height + 6, 208, 208)];
        [self buttonWithNormalImageName:@"MainScreen_profile" forBtn:self.profileButton withTag:1];
        
        self.settingButton = [[UIButton alloc]initWithFrame:CGRectMake(6, self.profileButton.frame.origin.y +  self.profileButton.frame.size.height + 6, 208, 208)];
        [self buttonWithNormalImageName:@"MainScreen_setting" forBtn:self.settingButton withTag:2];
        
        self.manualButton = [[UIButton alloc]initWithFrame:CGRectMake(self.autoButton.frame.size.width + self.autoButton.frame.origin.x + 6, self.titleBar.frame.size.height + 6, 208, 208)];
        [self buttonWithNormalImageName:@"MainScreen_manual" forBtn:self.manualButton withTag:3];
        
        self.historyButton = [[UIButton alloc]initWithFrame:CGRectMake(self.autoButton.frame.size.width + self.autoButton.frame.origin.x + 6,self.manualButton.frame.origin.y +  self.manualButton.frame.size.height + 6, 208, 208)];
        [self buttonWithNormalImageName:@"MainScreen_history" forBtn:self.historyButton withTag:4];
        
        self.forumButton = [[UIButton alloc]initWithFrame:CGRectMake(self.autoButton.frame.size.width + self.autoButton.frame.origin.x + 6,self.historyButton.frame.origin.y +  self.historyButton.frame.size.height + 6, 208, 208)];
        [self buttonWithNormalImageName:@"MainScreen_forum" forBtn:self.forumButton withTag:5];
        [self createALLEnterFrames];
    }
    return self;
}

#pragma mark - Button Setting Method
-(void) buttonWithNormalImageName:(NSString*)normal  forBtn:(UIButton*)btn withTag:(int)tag
{
    if(self.arrayOfBtn == nil) {
        self.arrayOfBtn = [[NSMutableArray alloc]init];
    }
    [btn setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@.png",normal]] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@_s2.png",normal]] forState:UIControlStateHighlighted];
    btn.showsTouchWhenHighlighted = YES;
    btn.alpha = 0.0;
    btn.tag = tag;
    [self addSubview:btn];
    [self.arrayOfBtn addObject:btn];
}

#pragma mark - Button alhpa Effect Animation
- (void) alphaEffectForButtons
{
    [UIView animateWithDuration:0.4 delay:1 options:UIViewAnimationOptionCurveEaseIn animations:^{
        for(UIButton *btn in self.arrayOfBtn) {
            btn.alpha = 1.0;
        }
    } completion:^(BOOL finish){
        
    }];
}

#pragma mark - Custom Main Enter Block Frame
-(void) createALLEnterFrames
{
    float x = 6,y = self.titleBar.frame.size.height + 6;
    self.enterFrames = [[NSMutableArray alloc]init];
    
    for(int count = 1 ; count <= 12 ; count ++) {
        SwipeFrame *swipeFrame = [SwipeFrame getSwipeFrame:CGRectMake(x, y, 208, 208)];
        if(count % 3 == 0)
        {
            x = !(count == 6) ? x += 214 : 596;
        }
        y = !(count % 3 == 0) ? y += 214 : self.titleBar.frame.size.height + 6;
        
        [self.enterFrames addObject:swipeFrame];
    }
}

#pragma mark - set Button Frame
-(void) setButtonFrames:(NSArray*) frames
{
    int count = 0;
    for(UIButton *btn in self.arrayOfBtn) {
        SwipeFrame *swipeFrame = [self.enterFrames objectAtIndex:[[frames objectAtIndex:count] intValue]];
        
        btn.tag = [[frames objectAtIndex:count] intValue];
        btn.frame  = swipeFrame.frame;
        swipeFrame.isUse = YES;
        count++;
        [self.enterFrames replaceObjectAtIndex:btn.tag withObject:swipeFrame];
    }
    [self alphaEffectForButtons];
}

@end
