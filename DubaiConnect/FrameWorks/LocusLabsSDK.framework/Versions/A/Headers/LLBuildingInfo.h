//
//  LLBuildingInfo.h
//  LocusLabsSDK
//
//  Created by Samuel Ziegler on 6/12/14.
//  Copyright (c) 2014 LocusLabs. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  The index information about a specific building as returned by the LLAirport listBuildings method.
 */
@interface LLBuildingInfo : NSObject {
    NSString *_buildingId;
    NSString *_name;
}

/**
 *  The unique identifier for this building.  This is used in the LLAirport loadBuilding: method to instanciate an instance of the LLBuilding class.
 */
@property (retain,nonatomic) NSString *buildingId;

/**
 *  The localized name of this building.
 */
@property (retain,nonatomic) NSString *name;

@end
