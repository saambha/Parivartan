//
//  LLMarker.h
//  LocusLabsSDK
//
//  Created by Samuel Ziegler on 7/9/14.
//  Copyright (c) 2014 LocusLabs. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "LLOverlay.h"

@class LLPoint;

@class LLLatLng;

/**
 *  Used for placing images markers on a map.
 */
@interface LLMarker : LLOverlay {
}

/**
 *  The image coordinates which is centered on the position.
 */
@property (nonatomic) LLPoint *anchor;

/**
 *  The URL of the image icon to use for this marker.
 */
@property (nonatomic) NSString *iconUrl;

/**
 *  The position of this icon on the map.
 */
@property (nonatomic) LLLatLng *position;

@property (weak,nonatomic) id userData;

/**
 *  The FloorId for this marker.
 */
@property (nonatomic) NSString *floorId;


@end
