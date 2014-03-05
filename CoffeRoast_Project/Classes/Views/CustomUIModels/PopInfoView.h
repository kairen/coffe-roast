//
//  PopInfoView.h
//  CoffeRoast_Project
//
//  Created by Bai-Kai-Ren on 2014/2/26.
//  Copyright (c) 2014年 Bai-Kai-Ren. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PopInfoView : UIView

+(instancetype) popInfoViewWitFrame:(CGRect)frame;
-(void)  showInView:(UIView*)view;
-(void) removePopView;
-(void) setMessage:(NSString*)message;
@end
