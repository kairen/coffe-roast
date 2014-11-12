//
//  BeaconViewController.h
//  CoffeRoast_Project
//
//  Created by Bai-Kai-Ren on 2014/5/29.
//  Copyright (c) 2014年 Bai-Kai-Ren. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import <CoreLocation/CoreLocation.h>

@protocol BeaconDelegate <NSObject>

@required
-(void) enterBeacon;
-(void) leaveBeacon;
@end

@interface BeaconController : UIResponder <CLLocationManagerDelegate>

@property (nonatomic, weak) id<BeaconDelegate> delegate;
@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) CLBeaconRegion *beaconRegion;
@end
