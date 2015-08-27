//
//  LLCircle.h
//  LocusLabsSDK
//
//  Created by Samuel Ziegler on 6/12/14.
//  Copyright (c) 2014 LocusLabs. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "LLOverlay.h"

@class LLLatLng;

/**
 *  Draws a circle on an a LLMapView.
 */
@interface LLCircle : LLOverlay

/**
 *  Create a circle with the given radius and center.
 *
 *  @param center the center point of the circle
 *  @param radius the radius of the circle
 *
 *  @return the new circle object
 */
+ (LLCircle *)circleWithCenter:(LLLatLng *)center radius:(NSNumber *)radius;

/**
 *  Get the current center of the circle.
 *
 *  @return the center
 */
- (LLLatLng *)center;

/**
 *  Set the center point of the circle.
 *
 *  @param center the new center
 */
- (void)setCenter:(LLLatLng *)center;

/**
 *  Get the current radius of the circle.
 *
 *  @return the radius
 */
- (NSNumber *)radius;

/**
 *  Set the radius of the circle.
 *
 *  @param radius the new radius
 */
- (void)setRadius:(NSNumber *)radius;

/**
 *  Set the fill color of this circle.
 *
 *  @param color the new fill color
 */
- (void)setFillColor:(UIColor *)color;

/**
 *  Set the stroke with of this circle.
 *
 *  @param width the new stroke width
 */
- (void)setStrokeWidth:(CGFloat)width;

/**
 *  Set the stroke color of this circle.
 *
 *  @param color the new stroke color
 */
- (void)setStrokeColor:(UIColor *)color;

@end
