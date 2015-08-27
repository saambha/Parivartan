//
//  DCFacebookManager.h
//  DubaiConnect
//
//  Created by Krishna on 8/28/15.
//  Copyright (c) 2015 Anoop. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol FbManagerDelegate <NSObject>

@optional

-(void)facebookLoginResult:(BOOL)success;

-(void)fetchedFaceBookData;

@end

@interface DCFacebookManager : NSObject {
    id <FbManagerDelegate>fbDelegate;
}
@property (nonatomic , strong) id <FbManagerDelegate>fbDelegate;
@property (nonatomic , strong)  NSMutableArray *arr_Interests;
@property (nonatomic , strong)  NSMutableArray *arr_Events;
@property (nonatomic , strong)  NSMutableArray *arr_Places;
@property (nonatomic , strong)  NSMutableArray *arr_timeLineFeeds;
@property (nonatomic ,assign)   int             fbCallsCount;

-(void)fbLogin;
-(void)getFBData;
+(DCFacebookManager *)getSharedInstance ;

@end
