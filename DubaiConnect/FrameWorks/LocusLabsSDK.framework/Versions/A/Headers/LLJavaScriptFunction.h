//
//  LLJavaScriptFunction.h
//  LocusLabsSDK
//
//  Created by Samuel Ziegler on 5/23/14.
//  Copyright (c) 2014 LocusLabs. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "LLJavaScriptBridge.h"

@interface LLJavaScriptFunction : NSObject <LLJavaScriptBridgeObject> {
    NSString *_uuid;
    __weak LLJavaScriptBridge *_javaScriptBridge;
}

@property (strong,nonatomic) NSString *uuid;
@property (weak,nonatomic) LLJavaScriptBridge *javaScriptBridge;

+ (LLJavaScriptFunction *)javaScriptFunctionWithJavaScriptBridge:(LLJavaScriptBridge *)javaScriptBridge;

- (id)initWithJavaScriptBridge:(LLJavaScriptBridge *)javaScriptBridge;

- (void)execute:(NSArray *)args;
- (NSArray *)arguments;

@end
