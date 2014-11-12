//
//  BaseView.h
//  CoffeRoast_Project
//
//  Created by Bai-Kai-Ren on 2013/11/28.
//  Copyright (c) 2013年 Bai-Kai-Ren. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TempChartView.h"
#import "RollerChartView.h"
#import "UIImage+LoadFileImage.h"

typedef NS_ENUM(NSInteger, BottomDirection) {
    LeftDirection = 0,
    MiddleDirection,
    RightDirection ,
};

@class RollerChartView;
@class TempChartView;

@interface BaseView : UIView

@property(nonatomic, strong) UIImageView *titleBar;
@property(nonatomic, strong) UIImageView *logoImage;
@property(nonatomic, strong) UILabel *titleLabel;


@property(nonatomic, strong) UIImageView *bottomBar;
@property(nonatomic, strong) UIButton *leftButton;
@property(nonatomic, strong) UIButton *midButton;
@property(nonatomic, strong) UIButton *rightButton;

-(void) setTitle:(NSString*)title logoImage:(NSString*)imageName;

-(void) setLeftBarItemImage:(NSString*)image;
-(void) setMiddleBarItemImage:(NSString*)image;
-(void) setRightBarItemImage:(NSString*)image;
-(void) addButton:(UIButton*)btn  imageName:(NSString*)iName direction:(BottomDirection)direction;

@property(nonatomic, strong) UIImageView *plittingHRView;
@property(nonatomic, strong) UIImageView *controlView;

-(void) showSeparationView;

@property(nonatomic, strong) UITableView *listView;

@property(nonatomic, strong) UIImageView *temperaturBgView;
@property(nonatomic, strong) TempChartView *tempView;

@property(nonatomic, strong) UIImageView *rollerBgView;
@property(nonatomic, strong) RollerChartView *rollerView;

-(void) addTempLineView;
-(void) addRollerLineView;

-(void) StartListViewAnimation;
-(void) StartChartViewAnimation;

@end


@interface UITextField (other)

@end
