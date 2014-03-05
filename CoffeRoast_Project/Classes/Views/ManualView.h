//
//  ManualView.h
//  CoffeRoast_Project
//
//  Created by Bai-Kai-Ren on 2013/12/31.
//  Copyright (c) 2013年 Bai-Kai-Ren. All rights reserved.
//

#import "BaseView.h"

@interface ManualView : BaseView


@property(nonatomic, strong) UIButton *loadGreenBtn;
@property(nonatomic, strong) UIButton *loadRoastBtn;
@property(nonatomic, strong) UIButton *timeStampBtn;


@property(nonatomic, strong) NSMutableArray *labels;
@property(nonatomic, strong) NSMutableArray *sliders;


-(void) setBarButtonHidden:(BOOL) hidden withButton:(UIButton*)button;
@end
