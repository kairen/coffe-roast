//
//  SocketController.h
//  CoffeRoast_Project
//
//  Created by Bai-Kai-Ren on 2013/11/28.
//  Copyright (c) 2013年 Bai-Kai-Ren. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AsyncSocket.h"
#import "CommandTable.h"


static NSString * const kSocketDidConnect = @"socketDidConnect";
static NSString * const kSocketDisConnect = @"socketDisConnect";
static NSString * const kSocketMachineClose = @"socketMachineClose";
static NSString * const kSocketBackguroundHandler = @"socketBackguroundHandler";

typedef void(^SocketAckHandle)(NSData*);

@interface SocketHadler : NSObject <AsyncSocketDelegate>

+(SocketHadler*)share;
-(void) socketConnectToHost:(NSString*)host onPort:(NSInteger)port withTimeout:(NSTimeInterval)timer ;
-(void) writeHex:(NSString *)hex ackHandle:(SocketAckHandle) handle;

-(BOOL) checkCommandAckData:(NSData*)data;
@property(nonatomic, strong) NSData *sendData;


@property(nonatomic) BOOL connected;
@end
