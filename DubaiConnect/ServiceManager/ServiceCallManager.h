//
//  ServiceCallManager.h
//  SampleTest
//
//  Created by Krishna on 8/20/15.
//  Copyright (c) 2015 Krishna. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol ServiceManagerDelegate <NSObject>

@optional

- (void)serviceFailedWithError:(NSError *)error errorMessage:(NSString *)message tagValue:(NSInteger )tagValue;
- (void)serviceSuccessWithData:(NSDictionary *)dictData tagValue:(NSInteger)tagValue;


@end

@interface ServiceCallManager : NSObject <NSURLConnectionDelegate> {
    NSMutableData *_responseData;
    int tagValue;
}

@property (nonatomic , strong) id <ServiceManagerDelegate> serviceManagerDelegate;
@property (nonatomic , assign) int tagValue;

-(void)initiateRequest:(NSString *)params;
@end
