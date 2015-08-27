//
//  LLAirports.h
//  LocusLabsSDK
//
//  Created by Samuel Ziegler on 6/12/14.
//  Copyright (c) 2014 LocusLabs. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "LLAirport.h"
#import "LLJavaScriptObject.h"
#import "LLDownloader.h"

@class LLAirportDatabase;
@class LLJavaScriptFunction;

/**
 *  Delegates for LLAirportDatabase should implement this protocol.
 */
@protocol LLAirportDatabaseDelegate <NSObject>

@optional

/**
 *  Called with the data returned by the listAirports: method.
 *
 *  @param airportDatabase the database instance which generated the call
 *  @param airportList     an array of LLAirportInfo instances
 */
- (void)airportDatabase:(LLAirportDatabase *)airportDatabase airportList:(NSArray *)airportList;

/**
 *  Called once an airport has been loaded via the loadAirport: method.
 *
 *  @param airportDatabase the database instance which generated the call
 *  @param airport         the airport
 */
- (void)airportDatabase:(LLAirportDatabase *)airportDatabase airportLoaded:(LLAirport *)airport;

/**
 *  Called once an airport begun downloading maps and other necessary assets.
 *
 *  @param airportDatabase the database instance which generated the call
 *  @param venueId         the venue id for the airport
 */
- (void)airportDatabase:(LLAirportDatabase *)airportDatabase airportLoadStarted:(NSString*)venueId;

/**
 *  Called once an airport has completed downloading maps and other necessary assets.
 *
 *  @param airportDatabase the database instance which generated the call
 *  @param venueId         the venue id for the airport
 */
- (void)airportDatabase:(LLAirportDatabase *)airportDatabase airportLoadCompleted:(NSString*)venueId;

/**
 *  Called during asset downloads to give a progress update.
 *
 *  @param airportDatabase the database instance which generated the call
 *  @param venueId         the venue id for the airport
 *  @param percent         the percent download complete
 */
- (void)airportDatabase:(LLAirportDatabase *)airportDatabase airportLoadStatus:(NSString*)venueId percentage:(int)percent;

/**
 *  Called if an error is encountered while downloading the airport maps.
 *
 *  @param airportDatabase the database instance which generated the call
 *  @param venueId         the venue id for the airport
 *  @param errorCode       the code for the failure
 *  @param message         the message for the failure
 */
- (void)airportDatabase:(LLAirportDatabase *)airportDatabase airportLoadFailed:(NSString*)venueId code:(LLDownloaderError)errorCode message:(NSString*)message;


@end

/**
 *  LLAirportDatabase is the primary entry point for all the LocusLabs airport functionality.  To recieve any of the asynchronously generated data generated by
 *  this class, you must assign a delegate that implements the methods of the LLAirportDatabaseDelegate protocol.
 */
@interface LLAirportDatabase : LLJavaScriptObject<LLDownloaderDelegate> {
    __weak id<LLAirportDatabaseDelegate> _delegate;
}

/**
 *  Delegate for this instance
 */
@property (weak, nonatomic) id<LLAirportDatabaseDelegate> delegate;

/**
 *  Create an instance of LLAirportDatabase
 *
 *  @return the new airport database object
 */
+ (LLAirportDatabase *)airportDatabase;

/**
 *  Retrieve the list of airports available in the LocusLabs airport database.  The result will be returned via the
 *  airportDatabase:airportList: delegate method.
 */
- (void)listAirports;

/**
 *  Load a specific airport.  The result will be returned to the delegate via airportDatabase:airportLoaded:
 *  Only 4 concurrent loadAirports can be handled simultaneously.  Doing more than 4 could result in load failures.
 *
 *  @param venueId identifies the airport to load
 */
- (void)loadAirport:(NSString *)venueId;

// "private" in the sense that our customers shouldn't need to call this directly
- (void) teardown;

@end