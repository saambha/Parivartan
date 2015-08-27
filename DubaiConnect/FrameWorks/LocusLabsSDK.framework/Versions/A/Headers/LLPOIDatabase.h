//
//  LLPOIDatabase.h
//  LocusLabsSDK
//
//  Created by Samuel Ziegler on 7/2/14.
//  Copyright (c) 2014 LocusLabs. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "LLJavaScriptObject.h"

#import "LLPOIDatabaseDelegate.h"

/**
 *  Provides access to the LocusLabs POI database.  Objects not be created directly, but via the LLAirport poiDatabase method
 */
@interface LLPOIDatabase : LLJavaScriptObject {
    __weak id<LLPOIDatabaseDelegate> _delegate;
}

@property (weak,nonatomic) id<LLPOIDatabaseDelegate> delegate;

/**
 *  Load data about a specific POI.
 *
 *  @param poiId the POI to load
 */
- (void)loadPOI:(NSString *)poiId;

@end
