//
//  LLOverlay.h
//  LocusLabsSDK
//
//  Created by Samuel Ziegler on 6/12/14.
//  Copyright (c) 2014 LocusLabs. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "LLJavaScriptObject.h"
#import "LLFloorView.h"

//@class LLFloorView;
@class LLMVCObjectRelay;
@class LLOverlayView;
@class LLMVCObjectShadow;

/**
 *  Base class for all objects which will be drawn on a map.
 */
@interface LLOverlay : LLJavaScriptObject {
    LLMVCObjectRelay *_objectRelay;
    LLOverlayView *_overlayView;
}

/**
 *  The floor of the map which this object should be drawn on.  This floorView object is provided by a LLMapView.
 */
@property (weak,nonatomic) LLFloorView *floorView;

@property (strong,nonatomic) LLMVCObjectRelay *objectRelay;
@property (strong,nonatomic) LLOverlayView *overlayView;
@property NSNumber *zIndex;

- (LLOverlayView *)newOverlayViewWithObjectShadow:(LLMVCObjectShadow *)objectShadow;

@end
