//
//  SocketController.m
//  CoffeRoast_Project
//
//  Created by Bai-Kai-Ren on 2013/11/28.
//  Copyright (c) 2013年 Bai-Kai-Ren. All rights reserved.
//

#import "SocketController.h"

@interface SocketController ()

@property(nonatomic, strong) AsyncSocket *socket;
@end

@implementation SocketController

+(SocketController*) shareSocket
{
    static id socketShare = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        socketShare = [[self alloc]initWithSocket];
    });
    return socketShare;
}

-(id) initWithSocket
{
    self = [super init];
    if(self) {
        self.socket = [[AsyncSocket alloc]initWithDelegate:self];
        NSError *err = nil;
        
        if([self.socket connectToHost:@"192.168.1.180" onPort:4660 withTimeout:2 error:&err]) {
            NSLog(@"connected...");
        }
        else {
            NSLog(@"failed...");
        }
    }
    return self;
}

#pragma mark - Stop TCPSocket
-(void) stopSocket
{
    [self.socket disconnect];
    self.socket.delegate = nil;
    self.socket = nil;
}

#pragma mark - TCP Socket Write Data
-(void) writeData:(NSData*)data
{
    [self.socket writeData:data withTimeout:-1 tag:self.socket.tag];
}

#pragma mark - TCP Socket Send Hex Data
-(void) writeHex:(NSString *)hex
{
    NSMutableData* data = [NSMutableData data];
    int idx;
    for (idx = 0; idx+2 <= hex.length; idx+=2) {
        NSScanner *scanner = [NSScanner scannerWithString:[hex substringWithRange:NSMakeRange(idx, 2)]];
        unsigned int intValue;
        if ([scanner scanHexInt:&intValue]) {
            [data appendBytes:&intValue length:1];
        }
        scanner = nil;
    }
    [self.socket writeData:data withTimeout:-1 tag:self.socket.tag];
    NSLog(@"%@",data);
    data  = nil;
}

#pragma mark - Async Socket Delegate Method
- (void)onSocket:(AsyncSocket *)sock didConnectToHost:(NSString *)host port:(UInt16)port
{
    [sock readDataWithTimeout:-1 tag:0];
}

-(void)onSocket:(AsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag
{
    NSLog(@"%@,%d",data,(int)data.length);
    [sock readDataWithTimeout:-1 tag:0];
}

-(void) onSocket:(AsyncSocket *)sock didWriteDataWithTag:(long)tag
{
    
}

-(void)onSocketDidDisconnect:(AsyncSocket *)sock
{
    
}
@end
