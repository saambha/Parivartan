//
//  LLSearchResult.h
//  LocusLabsSDK
//
//  Created by Samuel Ziegler on 7/11/14.
//  Copyright (c) 2014 LocusLabs. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LLPosition;

/**
 *  A single search result.
 */
@interface LLSearchResult : NSObject {
    NSString *_poiId;
    NSString *_name;
    LLPosition *_position;
    NSString *_gate;
    NSString *_terminal;
}

/**
 *  The unique identifier for the found POI.  This can be used to access additional data about the POI with
 *  through LLPOIDatabase.
 */
@property (strong,nonatomic) NSString *poiId;

/**
 *  A localized name of the POI which can be used for display purposes.
 */
@property (strong,nonatomic) NSString *name;

/**
 *  The geographic position of this POI.
 */
@property (strong,nonatomic) LLPosition *position;

/**
 *  The gate which is near the POI.
 */
@property (strong,nonatomic) NSString *gate;

/**
 *  The terminal which is near the POI.
 */
@property (strong,nonatomic) NSString *terminal;


@end
