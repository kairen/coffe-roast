//
//  KeyBoardView.m
//  ComWeb_BroadcastSystem
//
//  Created by Bai-Kai-Ren on 13/7/15.
//  Copyright (c) 2013年 Bai-Kai-Ren. All rights reserved.
//

#import "KeyBoardView.h"
#import "BasicAnimation.h"

static CGFloat keyBoardBtnX[12] = {
    0.034179688,0.11425781,0.19482422,0.27490234,0.35498047,0.43554688,
    0.515625,0.59594727,0.67626953,0.7565918,0.83666992,0.91674805
};

@implementation KeyBoardView

- (id)initWithNumberButtonTarget:(id)delegate action:(SEL)action inputFields:(NSArray *)fields
{
    self = [super init];
    if (self)
    {
        self.frame = CGRectMake(0, 0, 1024 , 100);
        self.image = [UIImage imageNamed:@"keyboard_background.png"];
        self.userInteractionEnabled = YES;
        
        self.numberBtns = [[NSMutableArray alloc]init];
        
        for (int i = 0 ; i <= 11 ; i++) {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(CGRectGetWidth(self.frame) * keyBoardBtnX[i] , CGRectGetMidY(self.frame) - (75 / 2) + 2, 50, 70);
            [btn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"keyboard_%d.png",i]] forState:UIControlStateNormal];
            [btn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"keyboard_%d_s2.png",i]] forState:UIControlStateHighlighted];
            btn.tag = i;
            btn.alpha = 0.0;
            [btn addTarget:delegate action:action forControlEvents:UIControlEventTouchDown];
            [self addSubview:btn];
            [self.numberBtns addObject:btn];
        }
        if(fields.count > 0)
        {
            for(UITextField *field in fields)
            {
                field.inputView = self;
            }
        }
    }
    return self;
}

-(void) showAnimation
{
    for(UIButton *btn in self.numberBtns) {
        [self performSelector:@selector(delayShowAnimation:) withObject:btn afterDelay:0.2 * btn.tag];
    }
}

-(void) delayShowAnimation:(UIButton*)btn
{
    [BasicAnimation popAnimationFor:btn complete:nil];
}

@end
