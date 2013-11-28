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

@property(nonatomic, strong) UIButton *autoBtn;
@property(nonatomic, strong) UIButton *manualBtn;
@property(nonatomic, strong) UIButton *profileBtn;
@property(nonatomic, strong) UIButton *historyBtn;
@property(nonatomic, strong) UIButton *settingBtn;
@property(nonatomic, strong) UIButton *forumBtn;

@property(nonatomic, strong) NSMutableArray *enterFrames;
@property(nonatomic, strong) NSMutableArray *arrayOfBtn;

-(void) setButtonFrames:(NSArray*) frames;
@end

