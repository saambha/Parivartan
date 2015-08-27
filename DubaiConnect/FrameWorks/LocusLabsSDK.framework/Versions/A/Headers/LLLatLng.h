//
//  LLLatLng.h
//  LocusLabsSDK
//
//  Created by Samuel Ziegler on 6/18/14.
//  Copyright (c) 2014 LocusLabs. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "LLJavaScriptObject.h"

/**
 *  Represents a geographics position in latitude and longitude.
 */
@interface LLLatLng : LLJavaScriptObject

- (id)initWithLat:(NSNumber *)lat lng:(NSNumber *)lng;

- (id)initWithLat:(NSNumber *)lat lng:(NSNumber *)lng javaScriptBridge:(LLJavaScriptBridge *)javaScriptBridge uuid:(NSString *)uuid;

/**
 *  Latitude
 *
 *  @return latitude
 */
- (NSNumber *)lat;

/**
 *  Longitude
 *
 *  @return longitutde
 */
- (NSNumber *)lng;

/**
 *  Calculates the distance (in meters) between two LLLatLng objects
 *
 *  @param latLng the other LLLatLng
 *
 *  @return the distance (in meteres)
 */
- (NSNumber *)distance:(LLLatLng *)latLng;

/**
 *  Calculates the bearing between this position and another one.
 *
 *  @param latLng the other LLLatLng
 *
 *  @return the bearing (in radians)
 */
- (NSNumber *)bearing:(LLLatLng *)latLng;

/**
 *  Calculates the geohash for the Lat/Lng coordinates.
 *
 *  @return the geohash string
 */
- (NSString *)geohash;

@end
