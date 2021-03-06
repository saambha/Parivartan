//
//  DCTimeLine.h
//  DubaiConnect
//
//  Created by Krishna on 8/28/15.
//  Copyright (c) 2015 Anoop. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DCTimeLine : NSObject


@property (nonatomic , retain) NSString *placeName;
@property (nonatomic , retain) NSString *placeDescription;
@property (nonatomic , retain) NSString *taxiTime;
@property (nonatomic , retain) NSString *distanceFromAirport;
@property (nonatomic , retain) NSString *weatherInfo;
@property (nonatomic , retain) NSString *imgName;
@property (nonatomic , retain) NSString *miles;
@property (nonatomic , retain) NSString *cash;


-(NSMutableArray *)setLimeLineObjects:(int)tag;

@end
