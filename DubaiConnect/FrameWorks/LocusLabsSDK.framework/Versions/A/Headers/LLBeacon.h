//
//  LLBeaconInfo.h
//  LocusLabsSDK
//
//  Created by Samuel Ziegler on 6/18/14.
//  Copyright (c) 2014 LocusLabs. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LLLatLng;

@interface LLBeacon : NSObject {
    NSString *_uuid;
    NSString *_floorId;
    NSString *_buildId;
    NSString *_venueId;
    NSNumber *_majorId;
    NSNumber *_minorId;
    NSNumber *_rssi;
    LLLatLng *_position;
}

@property (retain,nonatomic) NSString *uuid;
@property (retain,nonatomic) NSString *floorId;
@property (retain,nonatomic) NSString *buildingId;
@property (retain,nonatomic) NSString *venueId;
@property (retain,nonatomic) NSNumber *majorId;
@property (retain,nonatomic) NSNumber *minorId;
@property (retain,nonatomic) NSNumber *rssi;
@property (retain,nonatomic) LLLatLng *position;

@end
