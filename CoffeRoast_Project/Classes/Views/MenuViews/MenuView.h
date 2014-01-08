//
//  MenuView.h
//  CoffeRoast_Project
//
//  Created by Bai-Kai-Ren on 2013/11/28.
//  Copyright (c) 2013年 Bai-Kai-Ren. All rights reserved.
//

#import "BaseView.h"
#import "SwipeFrame.h"

@interface MenuView : BaseView

@property(nonatomic, strong) UIButton *autoButton;
@property(nonatomic, strong) UIButton *manualButton;
@property(nonatomic, strong) UIButton *profileButton;
@property(nonatomic, strong) UIButton *historyButton;
@property(nonatomic, strong) UIButton *settingButton;
@property(nonatomic, strong) UIButton *forumButton;

@property(nonatomic, strong) NSMutableArray *enterFrames;
@property(nonatomic, strong) NSMutableArray *arrayOfBtn;

-(void) setButtonFrames:(NSArray*) frames;
@end

