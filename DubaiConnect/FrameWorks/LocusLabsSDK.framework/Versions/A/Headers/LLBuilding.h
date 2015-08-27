//
//  LLBuilding.h
//  LocusLabsSDK
//
//  Created by Samuel Ziegler on 6/12/14.
//  Copyright (c) 2014 LocusLabs. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "LLFloor.h"
#import "LLJavaScriptObject.h"
#import "LLLocation.h"

@class LLBuilding;
@class LLFloor;

/**
 *  Delegate to process responses to the asynchonrous methods of a LLBuilding object.
 */
@protocol LLBuildingDelegate <NSObject>

@optional

/**
 *  The list of floors found in this building.
 *
 *  @param building the object which generated this list
 *  @param floors   an array of LLFloorInfo objects
 */
- (void)building:(LLBuilding *)building floorList:(NSArray *)floors;
- (void)building:(LLBuilding *)building floorLoaded:(LLFloor *)floor;

@end

@interface LLBuilding : LLLocation {
    __weak id<LLBuildingDelegate> _delegate;
}

@property (weak, nonatomic) id<LLBuildingDelegate> delegate;

/**
 * Contains the id of the default floor for this building
 */
@property (nonatomic,readonly) NSString *defaultFloorId;

/**
 *  Unique identifier for this building
 *
 *  @return the building identifier
 */
- (NSString *)buildingId;

/**
 *  Load and create a new instance of a LLFloor object for a specific floor of this building.
 *
 *  @param floorId the identifier of the floor to load
 */
- (LLFloor*)loadFloor:(NSString *)floorId;

/**
 *  Generate a list of the floors found in this building.
 */
- (NSArray*)listFloors;

@end
