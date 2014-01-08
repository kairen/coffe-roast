//
//  LandscapeEventDetailView.h
//  Classes
//
//  Created by Marcel Ruegenberg on 19.11.09.
//  Copyright 2009-2011 Dustlab. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KRInfoView : UIView

+(id) defaultKRInfoView;

@property(nonatomic, strong) NSString *text;
@property(nonatomic) CGPoint tapPoint;
@end
