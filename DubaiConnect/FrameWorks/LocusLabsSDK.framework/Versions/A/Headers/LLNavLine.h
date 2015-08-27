//
//  LLNavLine.h
//  LocusLabsSDK
//
//  Created by Glenn Dierkes on 12/21/14.
//  Copyright (c) 2014 LocusLabs. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "LLPolyline.h"
#import "LLSymbol.h"


@interface LLNavLine : LLPolyline


/**
 *  Return the number of symbols shown on this nav line.
 *  @return the symbol count
 */
- (NSNumber*)numberOfSymbols;

/**
 *  Sets the number of symbols to be shown on the nav line.
 *  @param count the new symbolk count (Defaults to 10)
 */
- (void)setNumberOfSymbols:(int)count;

/**
 *  Returns the time between animation intervals for the nav line.
 *  @return the delay in milliseconds between animations.
 */
- (NSNumber*)intervalTime;

/**
 *  Sets the number of milliseconds between animations.
 *  @param time Default is 250.  Minimum is 100.
 */
- (void)setIntervalTime:(int)time;


@end
