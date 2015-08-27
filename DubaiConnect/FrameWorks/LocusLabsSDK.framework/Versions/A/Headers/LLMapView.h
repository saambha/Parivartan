//
//  LLMapView.h
//  LocusLabsSDK
//
//  Created by Samuel Ziegler on 6/12/14.
//  Copyright (c) 2014 LocusLabs. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>

#import "LLMapViewDelegate.h"
#import "LLPosition.h"
#import "LLMapTips.h"

@class LLMap;
@class LLInternalMapView;
@class LLJavaScriptBridge;
@class LLFloorView;
@class LLPOI;
@class LLFlight;

/**
 *  UIView for displaying LocusLabs floor maps.
 */
@interface LLMapView : UIView {
    LLMap *_map;
    LLJavaScriptBridge *_javaScriptBridge;
    LLInternalMapView *_mapView;
    __weak id<LLMapViewDelegate> _delegate;
}

@property (nonatomic, retain) UIActivityIndicatorView *spinner;

/**
 *  The map to render.
 */
@property (strong,nonatomic) LLMap *map;
@property (strong,nonatomic) LLJavaScriptBridge *javaScriptBridge;
@property (strong,nonatomic) LLInternalMapView *mapView;
@property (strong,nonatomic) UILabel *backLabel;

/**
 *  A delegate object to receive map events.
 */
@property (weak,nonatomic) id<LLMapViewDelegate> delegate;

/**
 *  Set the visibile radius around the center point.
 */
@property (nonatomic) NSNumber *mapRadius;

/**
 *  Set the center point of the map view.
 */
@property (nonatomic) LLLatLng *mapCenter;

/**
 * Set the user's current departing flight
 */
@property (strong,nonatomic) LLFlight *departingFlight;

/**
 * Should the LocusLabs UI include 20 extra pixels at the top to appear behind the status bar? Default: NO
 */
@property (nonatomic) BOOL shouldAllowSpaceForStatusBar;

/**
 * A disclaimer to presented to the user before showing them the result of the navigation.
 */
@property (strong,nonatomic) NSString *navigationDisclaimer;

/**
 *  A LLMapView is created to render a map within the given frame.
 *
 *  @param frame the view frame
 *
 *  @return self
 */
- (id)initWithFrame:(CGRect)frame;

- (void)didTapMarker:(LLMarker *)marker;
- (LLFloorView*)getFloorViewForId:(NSString*)floorId;
- (void)levelSelected:(NSString*)levelName;
- (LLFloorView*)getFloorViewForCurrentLevel;
- (void)addUserPOI:(LLPOI*)poi userLabel:(NSString*)label;
- (void)removeUserPOI:(LLPOI*)poi;
- (BOOL)processTransform;
- (void)navigateFromStart:(LLPosition*)start end:(LLPosition*)end;

- (void)teardown;

/**
 * Allows the back button on the Search Header to be removed.
 * This makes the search bar itself bigger.
 */
- (void)setShowBackButton:(BOOL)showBackButton;


/**
 * Set the background color of the entire search bar
 */
- (void)setSearchBarBackgroundColor:(UIColor*)backgroundColor;

/**
 * Change the back button's text
 */
- (void)setBackButtonText:(NSString*)backButtonText;

- (void) runMemoryTests;

/**
 * Toggles the use of positioning to display the user's current position on the map.  Default is FALSE.
 */
@property (nonatomic) BOOL positioningEnabled;
@property (nonatomic) BOOL shouldShowClosestBeacon;

/**
 * Hide/show the search bar.  Default is NO.
 */
@property (nonatomic) BOOL searchBarHidden;

/*
 * Hide/show the bottom bar.  Default is NO.
 */
@property (nonatomic) BOOL bottomBarHidden;

@property (retain,nonatomic) UINavigationController *mapTipsNavigationController;
@property (nonatomic) LLMapTipsPopupMethod mapTipsPopupMethod;


@end
