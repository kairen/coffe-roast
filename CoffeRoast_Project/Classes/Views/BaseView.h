//
//  BaseView.h
//  CoffeRoast_Project
//
//  Created by Bai-Kai-Ren on 2013/11/28.
//  Copyright (c) 2013年 Bai-Kai-Ren. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, BottomDirection) {
    LeftDirection = 0,
    MiddleDirection,
    RightDirection ,
};

@interface BaseView : UIView

@property(nonatomic, strong) UIImageView *titleBar;
@property(nonatomic, strong) UIImageView *logoImage;
@property(nonatomic, strong) UILabel *titleLabel;


@property(nonatomic, strong) UIImageView *bottomBar;
@property(nonatomic, strong) UIButton *leftBtn;
@property(nonatomic, strong) UIButton *midBtn;
@property(nonatomic, strong) UIButton *rightBtn;

-(void) setTitle:(NSString*)title logoImage:(NSString*)imageName;

-(void) setLeftBarItemImage:(NSString*)image;
-(void) setMiddleBarItemImage:(NSString*)image;
-(void) setRightBarItemImage:(NSString*)image;

@end
