//
//  KeyBoardView.h
//  ComWeb_BroadcastSystem
//
//  Created by Bai-Kai-Ren on 13/7/15.
//  Copyright (c) 2013年 Bai-Kai-Ren. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KeyBoardView : UIImageView


@property(nonatomic, strong) NSMutableArray *numberBtns;

-(id) initWithNumberButtonTarget:(id)delegate action:(SEL)action inputFields:(NSArray*)fields;

-(void) showAnimation; 
@end
