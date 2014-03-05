//
//  BaseController.m
//  CoffeRoast_Project
//
//  Created by Bai-Kai-Ren on 2013/11/28.
//  Copyright (c) 2013年 Bai-Kai-Ren. All rights reserved.
//

#import "BaseController.h"

@interface BaseController () <AVAudioPlayerDelegate>

@property(nonatomic, strong) AVAudioPlayer *avPlayer;
@end

@implementation BaseController

-(void) dismissViewController
{
    if([ALLModels roastRunedStatus] == RoastStopStatus) {
        [self dismissViewControllerAnimated:YES completion:NULL];
    }
}

#pragma mark - Button Audio Event

-(void) playAudioWithFile:(NSString*)file
{
    NSURL* url = [[NSURL alloc] initFileURLWithPath:[[NSBundle mainBundle] pathForResource:file ofType:nil]];
    
    NSError* error = nil;
    AVAudioPlayer* myPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
    myPlayer.delegate = self;
    [myPlayer setVolume:[[AVAudioSession sharedInstance] outputVolume]];
    if (!url || error) {
        NSLog(@"%@",error);
    } else {
        self.avPlayer = myPlayer;
        [myPlayer setNumberOfLoops:0];
        [myPlayer play];
    }
}

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    player.delegate = nil;
    player = nil;
}

#pragma mark - View Deploy
-(BOOL) shouldAutorotate
{
    return YES;
}

-(NSUInteger) supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskLandscapeLeft;
}

-(CGRect) frame
{
    return UIInterfaceOrientationIsLandscape(self.interfaceOrientation) ? CGRectMake(0, 0, CGRectGetHeight(self.view.frame), CGRectGetWidth(self.view.frame)): CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame));
}

@end
