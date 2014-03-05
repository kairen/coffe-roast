//
//  ManualView.m
//  CoffeRoast_Project
//
//  Created by Bai-Kai-Ren on 2013/12/31.
//  Copyright (c) 2013年 Bai-Kai-Ren. All rights reserved.
//

#import "ManualView.h"
#import "CustomSlider.h"

static CGFloat const LabelWidth = 150;
static CGFloat const LabelHight = 30;

static CGFloat const SliderHight = 50;

@implementation ManualView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setTitle:@"Manual" logoImage:@"manual_logo.png"];
        [self setLeftBarItemImage:@"Back"];
        [self setMiddleBarItemImage:@"start"];
        [self showSeparationView];
        
        [self addTempLineView];
        [self addRollerLineView];
        
        CGRect cvFrame = self.controlView.frame;
        
        self.timeStampBtn = [[UIButton alloc]initWithFrame:CGRectMake((CGRectGetWidth(cvFrame) / 2) - ( CGRectGetWidth(cvFrame) - 40) / 2, CGRectGetMaxY(cvFrame) - 130, CGRectGetWidth(cvFrame) - 40, 40)];
        [self.timeStampBtn setImage:[UIImage loadFileImageName:@"Manual_btn03.png"] forState:UIControlStateNormal];
        [self.timeStampBtn setImage:[UIImage loadFileImageName:@"Manual_btn03_s2.png"]forState:UIControlStateHighlighted];
        [self.controlView addSubview:self.timeStampBtn];
        
        self.loadRoastBtn = [[UIButton alloc]initWithFrame:CGRectMake((CGRectGetWidth(cvFrame) / 2) - ( CGRectGetWidth(cvFrame) - 40) / 2, CGRectGetMinY(self.timeStampBtn.frame) - 40, CGRectGetWidth(cvFrame) - 40, 40)];
        [self.loadRoastBtn setImage:[UIImage loadFileImageName:@"Manual_btn02.png"] forState:UIControlStateNormal];
        [self.loadRoastBtn setImage:[UIImage loadFileImageName:@"Manual_btn02_s2.png"] forState:UIControlStateHighlighted];
        [self.controlView addSubview:self.loadRoastBtn];
        
        self.loadGreenBtn = [[UIButton alloc]initWithFrame:CGRectMake((CGRectGetWidth(cvFrame) / 2) - ( CGRectGetWidth(cvFrame) - 40) / 2, CGRectGetMinY(self.loadRoastBtn.frame) - 40, CGRectGetWidth(cvFrame) - 40, 40)];
        [self.loadGreenBtn setImage:[UIImage loadFileImageName:@"Manual_btn01.png"] forState:UIControlStateNormal];
        [self.loadGreenBtn setImage:[UIImage loadFileImageName:@"Manual_btn01_s2.png"] forState:UIControlStateHighlighted];
        [self.controlView addSubview:self.loadGreenBtn];
        
        CGFloat x = (CGRectGetWidth(cvFrame) / 2) - (CGRectGetWidth(cvFrame) - 40) / 2 ,y = 10 ;
        int tag = 0;
        
        if(self.sliders == nil) {
            self.sliders = [NSMutableArray array];
            self.labels = [NSMutableArray array];
            for(NSString *iStr in @[@"Timer.png",@"Temperature.png",@"Wind.png",@"Roller.png"]) {
                UIImageView *infoBgView = [[UIImageView alloc]initWithImage:[UIImage loadFileImageName:iStr]];
                infoBgView.frame = CGRectMake(x, y, CGRectGetWidth(cvFrame) - 40,infoBgView.image.size.height);
                infoBgView.userInteractionEnabled = YES;
                [self.controlView addSubview:infoBgView];
                UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake((CGRectGetWidth(infoBgView.frame) / 2) - (LabelWidth / 2) + 40, 10, LabelWidth, LabelHight)];
                label.textAlignment = NSTextAlignmentCenter;
                label.textColor = [UIColor whiteColor];
                label.backgroundColor = [UIColor clearColor];
                label.adjustsFontSizeToFitWidth = YES;
                label.tag = tag + 10;
                label.text = [@[@"00:00",@"0",@"3",@"20"] objectAtIndex:tag];
                label.font = [UIFont fontWithName:@"Futura-Medium" size:20];
                [infoBgView addSubview:label];
                
                if(tag >= 1) {
                    CustomSlider *slider = [[CustomSlider alloc]initWithFrame:CGRectMake((CGRectGetWidth(infoBgView.frame) / 2) - ((CGRectGetWidth(infoBgView.frame) - 20) / 2),(CGRectGetHeight(infoBgView.frame) / 2) - (SliderHight / 2) + 10, CGRectGetWidth(infoBgView.frame) - 20, SliderHight)];
                    slider.tag = tag;
                    [slider setMaximumValue:10];
                    if(tag == 2) {
                        [slider setMinimumValue:3];
                    }
                    if(tag == 3) {
                        [slider setMaximumValue:120];
                        [slider setMinimumValue:20];
                    }
                    [infoBgView addSubview:slider];
                    [self.sliders addObject:slider];
                }
                [self.labels addObject:label];
                
                y += infoBgView.image.size.height;
                tag++;
            }
        }
        [self performSelector:@selector(StartChartViewAnimation) withObject:nil afterDelay:0.8];
    }
    return self;
}

-(void) setBarButtonHidden:(BOOL)hidden withButton:(UIButton *)button
{
    if(hidden) {
        [UIView animateWithDuration:0.3 animations:^{
            button.alpha = 0.0;
        }];
    } else {
        [UIView animateWithDuration:0.3 animations:^{
            button.alpha = 1.0;
        }];
    }
}

@end
