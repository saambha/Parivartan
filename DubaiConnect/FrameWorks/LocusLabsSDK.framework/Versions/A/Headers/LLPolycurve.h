//
//  LLPolycurve.h
//  LocusLabsSDK
//
//  Created by Glenn Dierkes on 1/12/15.
//  Copyright (c) 2015 LocusLabs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LLCurvedPath.h"
#import "LLOverlay.h"

@interface LLPolycurve : LLOverlay

/**
 *  Return the path associated with this LLPolyline
 *
 *  @return the path
 */
- (LLCurvedPath *)getCurvedPath;

/**
 *  Return the stroke width of this polyline.
 *
 *  @return the stroke width
 */
- (CGFloat)strokeWidth;

/**
 *  Set the path of this polyline.
 *
 *  @param path the new path
 */
- (void)setCurvedPath:(LLCurvedPath *)path;

/**
 *  Set the stroke with of this polyline.
 *
 *  @param width the new stroke width
 */
- (void)setStrokeWidth:(CGFloat)width;

/**
 *  Set the stroke color of this polyline.
 *
 *  @param color the new stroke color
 */
- (void)setStrokeColor:(UIColor *)color;

/**
 *  Set the icons used along this polyline.
 *
 *  @param icons
 */
- (void)setIcons:(NSArray *)icons;


@end
