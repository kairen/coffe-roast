//
//  SocketController.h
//  CoffeRoast_Project
//
//  Created by Bai-Kai-Ren on 2013/11/28.
//  Copyright (c) 2013年 Bai-Kai-Ren. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AsyncSocket.h"

@interface SocketController : NSObject <AsyncSocketDelegate>

+(SocketController*)shareSocket;

-(void) writeData:(NSData*)data;
-(void) writeHex:(NSString *)hex;

@end
