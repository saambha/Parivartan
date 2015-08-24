//
//  DCFacebookManager.m
//  DubaiConnect
//
//  Created by Krishna on 8/24/15.
//  Copyright (c) 2015 Anoop. All rights reserved.
//

#import "DCFacebookManager.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>


@implementation DCFacebookManager

@synthesize fbDelegate;

static DCFacebookManager *fbSharedObject;

+(DCFacebookManager *)getSharedInstance {
    
    if (!fbSharedObject) {
        fbSharedObject = [[DCFacebookManager alloc]init];
        fbSharedObject.arr_Interests = [[NSMutableArray alloc] init];
        fbSharedObject.arr_Events = [[NSMutableArray alloc] init];
        fbSharedObject.arr_Places = [[NSMutableArray alloc] init];
        fbSharedObject.arr_timeLineFeeds = [[NSMutableArray alloc] init];
        fbSharedObject.fbCallsCount = 0;
    }
    return fbSharedObject;
}

-(void)fbLogin {
    
    if ([FBSDKAccessToken currentAccessToken]) {
        [self.fbDelegate facebookLoginResult:YES];
        return;
    }
    FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
    [login logInWithReadPermissions:@[@"public_profile", @"email", @"user_friends",@"user_likes",@"user_tagged_places",@"user_posts"] handler:^
        (FBSDKLoginManagerLoginResult *result, NSError *error) {
        if (error) {
            [self.fbDelegate facebookLoginResult:YES];
        } else if (result.isCancelled) {
            [self.fbDelegate facebookLoginResult:YES];

        } else {
            if ([result.grantedPermissions containsObject:@"email"]) {
                if ([FBSDKAccessToken currentAccessToken]) {
                    [self.fbDelegate facebookLoginResult:YES];
                }
            }
        }
    }];
}

-(void)getFBData {
    
    if ([FBSDKAccessToken currentAccessToken]) {
        [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me/likes" parameters:@{@"fields": @"data,category,about,category_list,name"}]
         startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
             if (!error) {
                 self.arr_Interests = [result objectForKey:@"data"];
                 fbSharedObject.fbCallsCount ++;
                 if (fbSharedObject.fbCallsCount == 4) {
                     [self.fbDelegate fetchedFaceBookData];
                 }
                 NSLog(@"arr_Interests:%@",self.arr_Interests);
             }
         }];
    }

    if ([FBSDKAccessToken currentAccessToken]) {
        [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me/tagged_places" parameters:@{@"fields": @"data,place,created_time"}]
         startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
             if (!error) {
                 self.arr_Places = [result objectForKey:@"data"];
                 fbSharedObject.fbCallsCount ++;
                 if (fbSharedObject.fbCallsCount == 4) {
                     [self.fbDelegate fetchedFaceBookData];
                 }
                 NSLog(@"arr_Places:%@",self.arr_Places);

             }
         }];
    }

    if ([FBSDKAccessToken currentAccessToken]) {
        [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me/feed" parameters:@{@"fields": @"message,link,place"}]
         startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
             if (!error) {
                 self.arr_timeLineFeeds = [result objectForKey:@"data"];
                 fbSharedObject.fbCallsCount ++;
                 if (fbSharedObject.fbCallsCount == 4) {
                     [self.fbDelegate fetchedFaceBookData];
                 }
                 NSLog(@"arr_timeLineFeeds:%@",self.arr_timeLineFeeds);

             }
         }];
    }
 
    if ([FBSDKAccessToken currentAccessToken]) {
        [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me/events" parameters:@{@"fields": @"name,place,owner"}]
         startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
             if (!error) {
                 fbSharedObject.fbCallsCount ++;
                 if (fbSharedObject.fbCallsCount == 4) {
                     [self.fbDelegate fetchedFaceBookData];
                 }
                 self.arr_Events = [result objectForKey:@"data"];
                 NSLog(@"arr_Events:%@",self.arr_Events);

             }
         }];
    }
}

@end
