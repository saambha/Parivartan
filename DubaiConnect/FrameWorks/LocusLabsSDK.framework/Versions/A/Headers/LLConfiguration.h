//
//  LLConfiguration.h
//  LocusLabsSDK
//
//  Created by Samuel Ziegler on 6/17/14.
//  Copyright (c) 2014 LocusLabs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface LLConfiguration : NSObject

// Bundle Constants
@property (strong,nonatomic) NSString *sdkUrl;
@property (strong,nonatomic) NSString *assetsBase;
@property (strong,nonatomic) NSString *accountId;
@property (strong,nonatomic) NSString *formatVersion;
@property (strong,nonatomic) NSString *sdkBundleName;
@property (atomic) bool useBundle;
@property (atomic) bool cache;
@property (strong,nonatomic) NSDictionary *config;

// Remote Assets
@property (strong,nonatomic) NSString *poiImagesUrl;

// Fonts
@property (strong,nonatomic) UIFont *font;
@property (strong,nonatomic) UIFont *lightFont;
@property (strong,nonatomic) UIFont *boldFont;
@property (strong,nonatomic) UIFont *routeSummaryTitleFont;
@property (strong,nonatomic) UIFont *routeSummaryLabelFont;
@property (strong,nonatomic) UIFont *routeSummarySubFont;

// Colors
@property (strong,nonatomic) UIColor *textColor;
@property (strong,nonatomic) UIColor *darkTextColor;
@property (strong,nonatomic) UIColor *levelHighlightTextColor;
@property (strong,nonatomic) UIColor *levelDetailTextColor;
@property (strong,nonatomic) UIColor *lightTextColor;
@property (strong,nonatomic) UIColor *disabledTextColor;
@property (strong,nonatomic) UIColor *linkColor;
@property (strong,nonatomic) UIColor *lightGrayBackgroundColor;
@property (strong,nonatomic) UIColor *navigationModeBackgroundColor;
@property (strong,nonatomic) UIColor *blueBackgroundColor;
@property (strong,nonatomic) UIColor *searchTextColor;
@property (strong,nonatomic) UIColor *grayColor;
@property (strong,nonatomic) UIColor *navPathColor;
@property (strong,nonatomic) UIColor *transitPathColor;
@property (strong,nonatomic) UIColor *queryWindowBackgroundColor;
@property (strong,nonatomic) UIColor *poiFlightTypeColor;
@property (strong,nonatomic) UIColor *routeSummaryColor;
@property (strong,nonatomic) UIColor *defaultSearchBarBackgroundColor;
@property (assign) CGFloat poiAlphaChannel;
@property (strong,nonatomic) UIColor *securityNavLineColor;

// Icon Images
@property (readonly,nonatomic) UIImage *mapIconPoi;
@property (readonly,nonatomic) UIImage *iconDestinationNavWhite;
@property (readonly,nonatomic) UIImage *iconEtaNavWhite;
@property (readonly,nonatomic) UIImage *iconArrowdownNavBlue;
@property (readonly,nonatomic) UIImage *iconArrowupNavBlue;
@property (readonly,nonatomic) UIImage *iconStopnavNavBlue;
@property (readonly,nonatomic) UIImage *navIconStartingPoint;
@property (readonly,nonatomic) UIImage *iconRoutearrowNav;
@property (readonly,nonatomic) UIImage *navIconElevator;
@property (readonly,nonatomic) UIImage *navIconStairs;
@property (readonly,nonatomic) UIImage *navIconSecurity;
@property (readonly,nonatomic) UIImage *navIconEscalator;
@property (readonly,nonatomic) UIImage *navIconTrain;
@property (readonly,nonatomic) UIImage *navIconBus;
@property (readonly,nonatomic) UIImage *navIconDestination;
@property (readonly,nonatomic) UIImage *locusLabsLogo;

// String & Other Constants
@property (strong,nonatomic) NSNumber *navPathWidth;
@property (strong,nonatomic) NSString *cancelButtonLabel;
@property (readonly,nonatomic) NSString *navStart;
@property (readonly,nonatomic) NSString *navFinish;
@property (strong,nonatomic) NSString *bottomBarInfoButtonLabel;
@property (strong,nonatomic) NSString *bottomBarMyPositionButtonLabel;
@property (strong,nonatomic) NSString *bottomBarLevelsButtonLabel;
@property (strong,nonatomic) NSNumber *currentLevelFadeDuration;
@property (strong,nonatomic) NSNumber *currentLevelFadeDelay;

@property (strong,nonatomic) NSNumber *maximumCloudTags;

// API Webservices
@property (strong,nonatomic) NSString *apiWebservicesUrl;

// autocomplete
@property (strong,nonatomic) NSString *email;
@property (strong,nonatomic) NSString *password;
@property (strong,nonatomic) NSString *initialAirportCode;

+ (LLConfiguration *)sharedConfiguration;
+ (UIFont *) fontWithSize:(CGFloat)fontSize; // return the font in the given size
+ (UIFont*) lightFontWithSize:(CGFloat)size; // return the lightFont in the given size
+ (UIFont*) boldFontWithSize:(CGFloat)size;  // return the boldFont in the given size

+ (UIColor*) gray:(NSUInteger)zeroTo255;     // return a gray with the specified value (0-255) alpha: 1

// return a color with rgb each in the range 0-255 (alpha always set to 1)
+ (UIColor*) colorWithRed:(NSUInteger)red green:(NSUInteger)green blue:(NSUInteger)blue;


- (void)loadConfiguration;
- (void)loadConfigurationFrom:(NSString *)filename;

- (NSBundle *)sdkBundle;
- (NSURL*)getBaseURL;
- (NSString*)getResourcePath;
- (UIImage *)cachedImageFromSDKBundle:(NSString *)imageFilename;
- (void)clearCache;


@end
