//
//  BeaconViewController.m
//  CoffeRoast_Project
//
//  Created by Bai-Kai-Ren on 2014/5/29.
//  Copyright (c) 2014年 Bai-Kai-Ren. All rights reserved.
//

#import "BeaconController.h"

typedef struct {
    char *name;
    int major;
    int minor;
    BOOL isShow;
} MYBeacon;

static NSString * const kUUID = @"B9407F30-F5F8-466E-AFF9-25556B57FE6D";
static NSString * const kIdentifier = @"SomeIdentifier";

@interface BeaconController ()
{
    MYBeacon beacon;
}
@end

@implementation BeaconController

-(id) init
{
    self = [super init];
    if(self) {
        beacon.major = 10578;
        beacon.minor = 10001;
        beacon.name = "Test";
        beacon.isShow = NO;
        
        //新增一個 locationManager
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.delegate = self;
        self.locationManager.activityType = CLActivityTypeFitness;
        self.locationManager.distanceFilter = kCLDistanceFilterNone;
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        
        [self createBeaconRegion];
        [self.locationManager startRangingBeaconsInRegion:self.beaconRegion];
        [self.locationManager startMonitoringForRegion:self.beaconRegion];
        [self.locationManager startUpdatingLocation];
    }
    return self;
}

- (void)createBeaconRegion
{
    if (self.beaconRegion) {
        return;
    }
    NSUUID *proximityUUID = [[NSUUID alloc] initWithUUIDString:kUUID];
    self.beaconRegion = [[CLBeaconRegion alloc] initWithProximityUUID:proximityUUID identifier:kIdentifier];
    self.beaconRegion.notifyEntryStateOnDisplay= YES;
    self.beaconRegion.notifyOnEntry = YES;
    self.beaconRegion.notifyOnExit = YES;
    [self.locationManager startMonitoringForRegion:self.beaconRegion];
}

- (void)locationManager:(CLLocationManager *)manager didRangeBeacons:(NSArray *)beacons inRegion:(CLBeaconRegion *)region
{
    if (beacons.count > 0) {
        for (int i = 0 ; i < beacons.count ; i++){
            CLBeacon *searchbeacon = [[CLBeacon alloc] init];
            searchbeacon = beacons[i];
            if ((fabsf(searchbeacon.accuracy) < 0.5f) && ([searchbeacon.major isEqualToNumber: [NSNumber numberWithInt:beacon.major]]) && !beacon.isShow){
                UILocalNotification *notification=[[UILocalNotification alloc] init];
                notification.alertBody = @"歡迎來到IMAC咖啡烘培場";
                notification.soundName = UILocalNotificationDefaultSoundName;
                [[UIApplication sharedApplication] scheduleLocalNotification:notification];
                beacon.isShow = YES;
                [self.delegate enterBeacon];
            }
            else if ((fabsf(searchbeacon.accuracy) >= 1.0f) && ([searchbeacon.major isEqualToNumber: [NSNumber numberWithInt:beacon.major]])){
                beacon.isShow = NO;
                [self.delegate leaveBeacon];
            }
        }
    }
}

@end
