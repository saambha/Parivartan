//
//  MapViewController.h
//  DubaiConnect
//
//  Created by Aman on 8/26/15.
//  Copyright (c) 2015 Anoop. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <LocusLabsSDK/LocusLabsSDK.h>

@interface MapViewController : UIViewController @end

@interface MapViewController(AirportDatabaseDelegate) <LLAirportDatabaseDelegate> @end
@interface MapViewController(FloorDelegate)           <LLFloorDelegate>           @end
@interface MapViewController(PositionManagerDelegate) <LLPositionManagerDelegate> @end
@interface MapViewController(MapViewDelegate)         <LLMapViewDelegate>         @end
@interface MapViewController(AirportDelegate)         <LLAirportDelegate>         @end
@interface MapViewController(SearchDelegate)          <LLSearchDelegate>          @end
@interface MapViewController(POIDatabaseDelegate)     <LLPOIDatabaseDelegate>     @end
