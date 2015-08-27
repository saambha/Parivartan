//
//  LLFloor.h
//  LocusLabsSDK
//
//  Created by Samuel Ziegler on 6/12/14.
//  Copyright (c) 2014 LocusLabs. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "LLJavaScriptObject.h"
#import "LLMap.h"
#import "LLLocation.h"

@class LLFloor;

@protocol LLFloorDelegate <NSObject>

@optional

/**
 *  Delegate method called with a newly loaded map which was created via the loadMap: call.
 *
 *  @param floor the floor object which generated the callback
 *  @param map   the newly loaded map
 */
- (void)floor:(LLFloor *)floor mapLoaded:(LLMap *)map;

/**
 *  Delegate method called when the listBeacons: call is successful
 *
 *  @param floor   the floor object which generated the callback
 *  @param beacons the list of beacons
 */
- (void)floor:(LLFloor *)floor beaconList:(NSArray *)beacons;

@end

@class LLBuilding;
@class LLFloorDelegate;
@class LLSection;

/**
 *  This class contains methods for interacting with an individual floor of a building.
 */
@interface LLFloor : LLLocation {
    __weak id<LLFloorDelegate> _delegate;
}

@property (weak,nonatomic) id<LLFloorDelegate> delegate;
@property (nonatomic,readonly) NSArray *sectionIds;

/**
 *  The unique identifier for this floor.
 *
 *  @return the identifier
 */
- (NSString *)floorId;

/**
 *  An integer which denoted the relative position of the floor in the building.  Typically, the ground floor is 0, subfloors are negative and above ground floors are
 *  positive values.
 *
 *  @return the floor index
 */
- (NSNumber *)floor;

/**
 *  The unique identifier of the building which contains this floor.
 *
 *  @return the building identifier
 */
- (NSString *)buildingId;

/**
 *  The unique identifier of the venue that this floor exists in.
 *
 *  @return the venue identifier
 */
- (NSString *)venueId;

/**
 *  Creates a new LLMap object for this floor which is returned via the floor:mapLoaded: callback in the delegate.
 */
- (void)loadMap;

/**
 * Gets the list of beacons found on this floor.
 */
- (void)listBeacons;

- (LLSection *)getSectionWithId:(NSString *)sectionId;

@end
