//
//  SocketController.m
//  CoffeRoast_Project
//
//  Created by Bai-Kai-Ren on 2013/11/28.
//  Copyright (c) 2013年 Bai-Kai-Ren. All rights reserved.
//


#import "SocketHadler.h"
#import <objc/runtime.h>

static Byte const ErrorCode[] = {0xff,0xaa,0x00,0x00};

@interface SocketHadler ()

@property(nonatomic, strong) AsyncSocket *socket;
@property(nonatomic, copy) SocketAckHandle socketAckHandle;
@end

@implementation SocketHadler

+(SocketHadler*) share
{
    static SocketHadler *socketShare = nil;
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
            }
    return self;
}

#pragma mark - Socket Connecting
-(void) socketConnectToHost:(NSString*)host onPort:(NSInteger)port withTimeout:(NSTimeInterval)timer
{
    NSError *err = nil;
    [self.socket connectToHost:host onPort:port withTimeout:timer error:&err];
    if(err) {
        self.connected = NO;
    } 
}

#pragma mark - Stop TCPSocket
-(void) stopSocket
{
    [self.socket disconnect];
    self.socket.delegate = nil;
    self.socket = nil;
}

#pragma mark - TCP Socket Send Hex Data
-(void) writeHex:(NSString *)hex ackHandle:(SocketAckHandle)handle
{
    
    NSMutableData* data = [NSMutableData data];
    int idx,checkSum = 0;
    for(idx = 0; idx+2 <= hex.length; idx+=2) {
        NSScanner *scanner = [NSScanner scannerWithString:[hex substringWithRange:NSMakeRange(idx, 2)]];
        unsigned int intValue;
        if ([scanner scanHexInt:&intValue]) {
            checkSum ^= intValue;
            [data appendBytes:&intValue length:1];
        }
    }
    [data appendBytes:&checkSum length:1];
    if(data.length > 4) {
        self.sendData = [data subdataWithRange:NSMakeRange(0, 4)];
    }
    
    self.socketAckHandle = nil;
    if(handle) {
        self.socketAckHandle = handle;
    }
    [self.socket writeData:data withTimeout:-1 tag:self.socket.tag];
}

#pragma mark - check Ack
-(BOOL) checkCommandAckData:(NSData*)data
{
    if([self.sendData isEqualToData:data]) {
        return YES;
    } else {
        return NO;
    }
}

#pragma mark - Async Socket Delegate Method
- (void)onSocket:(AsyncSocket *)sock didConnectToHost:(NSString *)host port:(UInt16)port
{
     self.connected = YES;
    [[NSNotificationCenter defaultCenter]postNotificationName:kSocketDidConnect object:nil];
    [sock readDataWithTimeout:-1 tag:0];
}

-(void)onSocket:(AsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag
{
    @try {
        NSData *dataHead = [data subdataWithRange:NSMakeRange(0, 4)];
        if([dataHead isEqualToData:[NSData dataWithBytes:ErrorCode length:sizeof(ErrorCode)]]) {
            NSLog(@"%@",[NSError errorWithDomain:@"Ack Error" code:0 userInfo:@{NSLocalizedDescriptionKey: @"Command Send Error Code"}]);
        } else if([self checkCommandAckData:dataHead]){
            if(self.socketAckHandle) {
                self.socketAckHandle([data subdataWithRange:NSMakeRange(6, data.length - 7)]);
            }
        } else if(CFSwapInt32BigToHost(*(int*)([dataHead bytes])) == 0 || data.length == 35) {
             [[NSNotificationCenter defaultCenter]postNotificationName:kSocketMachineClose object:nil];
        }
    }
    @catch (NSException *exception) {
         [[NSNotificationCenter defaultCenter]postNotificationName:kSocketMachineClose object:nil];
       
    }
    [sock readDataWithTimeout:-1 tag:0];
}

-(void) onSocket:(AsyncSocket *)sock willDisconnectWithError:(NSError *)err
{
    if(err) {
        [[NSNotificationCenter defaultCenter]postNotificationName:kSocketDisConnect object:nil];
        self.connected = NO;
    }
}
@end
