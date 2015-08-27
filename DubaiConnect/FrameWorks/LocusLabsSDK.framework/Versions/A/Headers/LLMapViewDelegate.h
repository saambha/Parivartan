//
//  LLMapViewDelegate.h
//  LocusLabsSDK
//
//  Created by Samuel Ziegler on 7/22/14.
//  Copyright (c) 2014 LocusLabs. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LLMapView;
@class LLMarker;
@class LLLatLng;

typedef enum _LLMapViewMode
{
    LLMapViewModeNormal = 1,
    LLMapViewModeNavigation
} LLMapViewMode;

@protocol LLMapViewDelegate <NSObject>

@optional

- (void)mapViewReady:(LLMapView *)mapView;

/**
 *  Is called by the LLMapView whenever a marker on the map is tapped.
 *
 *  @param mapView the mapView that generated the event
 *  @param marker  the marker that was tapped
 *
 *  @return return TRUE if the event has been handled, FALSE if mapView should continue with it's default processing.
 */
- (BOOL)mapView:(LLMapView *)mapView didTapMarker:(LLMarker *)marker;

/**
 *  Called whenever a point on the map not containing a marker is tapped.
 *
 *  @param mapView the mapView that generated the event
 *  @param latLng  the point where the tap event occurred
 */
- (void)mapView:(LLMapView *)mapView didTapAtLatLng:(LLLatLng *)latLng;

/**
 *  Called whenever a POI on the map has been tapped.
 *
 *  @param mapView the mapView that generated the event
 *  @param poiId   the id of the POI that was tapped
 */
- (BOOL)mapView:(LLMapView *)mapView didTapPOI:(NSString *)poiId;

- (void)mapViewDidClickBack:(LLMapView *)mapView;
- (void)mapView:(LLMapView *)mapView floorChanged:(NSString *)floorId;
- (void)mapView:(LLMapView *)mapView modeChanged:(LLMapViewMode)mode;

@end
