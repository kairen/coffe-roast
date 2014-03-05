//
//  ProfileProtocolHandler.h
//  CoffeRoast_Project
//
//  Created by Bai-Kai-Ren on 2014/2/27.
//  Copyright (c) 2014年 Bai-Kai-Ren. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ProfileDelegate <NSObject>

@required
-(void) profileTextField:(UITextField*)textField;

@end

@class ProfileListEvent;
@class EPPickerView;

@interface ProfileProtocolHandler : NSObject <ProfileDelegate>

-(id) initWithProfileListEvent:(ProfileListEvent*)event;

@property(nonatomic, weak) ProfileListEvent *profileListEvent;
@property(nonatomic, weak) UIView *profileView;
@property(nonatomic, strong) EPPickerView *epPickerView;
@end

