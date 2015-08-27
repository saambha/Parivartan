//
//  LLMap.h
//  LocusLabsSDK
//
//  Created by Samuel Ziegler on 6/17/14.
//  Copyright (c) 2014 LocusLabs. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "LLJavaScriptObject.h"

@class LLLatLng;

@interface LLMap : LLJavaScriptObject

@property (nonatomic) NSNumber *radius;
@property (nonatomic) LLLatLng *center;
@property (nonatomic,readonly) NSString *venueId;
@property (nonatomic,readonly) NSString *buildingId;
@property (nonatomic) NSString *floorId;

@end
