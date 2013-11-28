//
//  AutonController.m
//  CoffeRoast_Project
//
//  Created by Bai-Kai-Ren on 2013/11/28.
//  Copyright (c) 2013年 Bai-Kai-Ren. All rights reserved.
//

#import "AutonController.h"
#import "AutoView.h"

@interface AutonController ()

@end

@implementation AutonController


- (void)viewDidLoad
{
    [super viewDidLoad];
	self.view = [[AutoView alloc]initWithFrame:self.view.frame];
}


-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self dismissViewController];
}


@end
