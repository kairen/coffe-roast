//
//  ManualController.m
//  CoffeRoast_Project
//
//  Created by Bai-Kai-Ren on 2013/12/31.
//  Copyright (c) 2013年 Bai-Kai-Ren. All rights reserved.
//

#import "ManualController.h"
#import "ManualView.h"
#import "RoastJSONModel.h"

@interface ManualController ()

@property(nonatomic, strong) ManualView *manualView;
@property(nonatomic, strong) RoastJSONModel *roastJson;
@end

@implementation ManualController

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.manualView = [[ManualView alloc]initWithFrame:self.frame];
    
    [self.manualView.leftButton addTarget:self action:@selector(dismissViewController) forControlEvents:UIControlEventTouchUpInside];
    for(UISlider *slider in self.manualView.sliders) {
        [slider addTarget:self action:@selector(sliderSwipeAction:) forControlEvents:UIControlEventValueChanged];
    }
     NSData *jsonData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"default.crp" ofType:nil]];
    self.roastJson = [RoastJSONModel roastJSONDataWithDict:[NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:NULL]];
    
    RoastProfile *roastPorfile = [RoastProfile roastProfileWithDict:self.roastJson.roastProfile];
    self.manualView.tempView.lineDatas = roastPorfile.temperatureVaules;
    
    self.manualView.rollerView.lineDatas = roastPorfile.rollerSpeedVaules;
    self.manualView.rollerView.windDatas = roastPorfile.windSpeedVaules;
    
    [self.view addSubview:self.manualView];
}

-(void) sliderSwipeAction:(id)sender
{
    UISlider *slider = (UISlider*)sender;
    UILabel *label = [self.manualView.labels objectAtIndex:slider.tag];
    label.text = [NSString stringWithFormat:@"%d",(int)slider.value];
}

@end
