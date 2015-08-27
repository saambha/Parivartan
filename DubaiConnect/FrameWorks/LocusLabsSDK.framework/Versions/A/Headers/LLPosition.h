//
//  LLPosition.h
//  LocusLabsSDK
//
//  Created by Samuel Ziegler on 6/12/14.
//  Copyright (c) 2014 LocusLabs. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LLLatLng;
@class LLFloor;

/**
 *  Represents a specific geographic position inside of a building.
 */
@interface LLPosition : NSObject {
    NSString *_name;
    NSNumber *_nearAirport;
    NSString *_venueId;
    NSString *_buildingId;
    NSString *_floorId;
    LLLatLng *_latLng;
    NSNumber *_isAfterSecurity;
}

- (id)initWithFloor:(LLFloor *)floor latLng:(LLLatLng *)latLng;

/**
 *  Name of the location if available.
 *  Usually available if the position specifies a specific POI.
 */
@property (retain,nonatomic) NSString *name;

/**
 *  Boolean which is true if the position within the proximity of an airport.
 */
@property (retain,nonatomic) NSNumber *nearAirport;

/**
 *  Identifies the venue (if known).
 */
@property (retain,nonatomic) NSString *venueId;

/**
 *  Identifies the building (if known).
 */
@property (retain,nonatomic) NSString *buildingId;

/**
 *  Identifies the floor (if known).
 */
@property (retain,nonatomic) NSString *floorId;

/**
 * Identifies the section (if known).
 */
@property (retain,nonatomic) NSString *sectionId;

/**
 *  The geographic position (if known).
 */
@property (retain,nonatomic) LLLatLng *latLng;

/**
 *  If in an airport, whether or not this POI is before or after security.
 */
@property (strong,nonatomic) NSNumber *isAfterSecurity;

@end
