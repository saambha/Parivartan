//
//  LLLocusLabs.h
//  LocusLabsSDK
//
//  Created by Glenn Dierkes on 1/23/15.
//  Copyright (c) 2015 LocusLabs. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "LLLocusLabsDelegate.h"

@class LLPerson;

/**
 * This class is used for setting up the LocusLabs SDK.  It has a singleton instance which is accessed via the +(LLLocusLabs *)setup method.
 * Before any other SDK methods are called, the accountId property must be set.
 */
@interface LLLocusLabs : NSObject

/**
 * The account id the SDK should use to interact with the LocusLabs resources.
 */
@property (nonatomic, retain) NSString *accountId;

/**
 * Sets the LLLocusLabsDelegate
 */
@property (weak,nonatomic) id<LLLocusLabsDelegate> delegate;

/**
 * Returns the LLLocusLabs singleton.
 * @returns the singleton
 */
+ (LLLocusLabs*)setup;


-(NSString*)assetsFormatVersion;
+ (void)reset;

/**
 * Log a person in, associating them with this install of the SDK.
 */
- (void)login:(LLPerson *)person;

/**
 * Log a person out, removing their association with this install of the SDK.
 */
- (void)logout:(LLPerson *)person;

@end