//
//  LLPOI.h
//  LocusLabsSDK
//
//  Created by Samuel Ziegler on 7/24/14.
//  Copyright (c) 2014 LocusLabs. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LLPosition;
@class LLFlight;

/**
 *  All of the available information about a POI.
 */
@interface LLPOI : NSObject {
}

/**
 *  The geographic position of the POI.
 */
@property (strong,nonatomic) LLPosition *position;

/**
 *  The URL associated with this POI.  For example, this may be a company website if the POI is a store.
 */
@property (strong,nonatomic) NSString *url;

/**
 *  An icon for the POI.
 */
@property (strong,nonatomic) NSString *icon;

/**
 *  Absolute URL of icon
 */
@property (nonatomic,readonly) NSURL *iconUrl;

/**
 *  An image of the POI.
 */
@property (strong,nonatomic) NSString *image;

/**
 *  Absolute URL of image
 */
@property (nonatomic,readonly) NSURL *imageUrl;

/**
 *  An array of NSStrings which are used to classify this POI.
 */
@property (strong,nonatomic) NSArray *tags;

/**
 *  Subset og the tags meant for display.
 */
@property (strong,nonatomic) NSArray *displayTags;

/**
 *  A localized string identifying this POI which can be used for display purposes.
 */
@property (strong,nonatomic) NSString *name;

/**
 *  The category that this POI is apart of.
 */
@property (strong,nonatomic) NSString *category;

/**
 *  A localized description of this POI.
 */
@property (strong,nonatomic) NSString *description;
@property (assign,nonatomic) BOOL hasDescription;

/**
 *  A phone number for this POI, if applicable.
 */
@property (strong,nonatomic) NSString *phone;

/**
 *  The unique identifier of this POI.
 */
@property (strong,nonatomic) NSString *poiId;

/**
 *  The nearest gate to this POI, if applicable.
 */
@property (strong,nonatomic) NSString *gate;

/**
 *  The operating hours of this POI, if applicable.
 */
@property (strong,nonatomic) NSString *hours;

/**
 *  The operating airport of this POI, if applicable.
 */
@property (strong,nonatomic) NSString *airport;

/**
 *  The operating terminal of this POI, if applicable.
 */
@property (strong,nonatomic) NSString *terminal;

/**
 *  An arbitrary userLabel set in LLMapView.addUserPOI
 */
@property (strong,nonatomic) NSString *userLabel;

@property (strong,nonatomic) LLFlight *flight;

/**
* An array of NSDictionary objects each of which has a 'days' and 'hours' field that indicates the
* operating hours of the POI for a part of the week
*/
@property (strong,nonatomic) NSArray *operatingHours;

- (BOOL)isEqual:(id)object;
- (NSUInteger)hash;
- (NSString*)description;
- (void)setDescription:(NSString*)description;



@end
