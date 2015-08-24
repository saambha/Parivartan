//
//  ServiceCallManager.m
//  SampleTest
//
//  Created by Krishna on 8/20/15.
//  Copyright (c) 2015 Krishna. All rights reserved.
//

#import "ServiceCallManager.h"

@implementation ServiceCallManager

@synthesize serviceManagerDelegate,tagValue;

-(void)initiateRequest:(NSString *)params {
    
    NSURL *url = [NSURL URLWithString:params];
    
    NSMutableURLRequest *request    = [[NSMutableURLRequest alloc] initWithURL:url];

    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    if (connection) {
        
        //_responseData = [[NSMutableData alloc] init];
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {

    _responseData = [[NSMutableData alloc] init];

}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    
    [_responseData appendData:data];

}

- (NSCachedURLResponse *)connection:(NSURLConnection *)connection
                  willCacheResponse:(NSCachedURLResponse*)cachedResponse {
    return nil;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
   
    NSString *responseStr = [[NSString alloc] initWithData:_responseData encoding:NSUTF8StringEncoding];
    NSDictionary*   responseDict  = [NSJSONSerialization JSONObjectWithData:[responseStr dataUsingEncoding:NSUTF8StringEncoding] options:0 error:nil];
    
    [self.serviceManagerDelegate serviceSuccessWithData:responseDict tagValue:self.tagValue];
    
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {

    [self.serviceManagerDelegate serviceFailedWithError:error errorMessage:@"error" tagValue:self.tagValue];
    NSLog(@"error:%@",error);
}

@end
