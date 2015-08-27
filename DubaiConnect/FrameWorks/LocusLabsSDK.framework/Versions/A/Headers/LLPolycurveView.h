//
//  LLPolycurveView.h
//  LocusLabsSDK
//
//  Created by Glenn Dierkes on 1/12/15.
//  Copyright (c) 2015 LocusLabs. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "LLOverlayView.h"

@class LLMVCObjectShadow;

@interface LLPolycurveView : LLOverlayView

- (void)setPolyline:(LLMVCObjectShadow *)polyline;

@end
