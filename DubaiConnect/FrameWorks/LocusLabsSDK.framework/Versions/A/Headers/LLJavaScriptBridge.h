//
//  LLJavaScriptBridge.h
//  LocusLabsSDK
//
//  Created by Samuel Ziegler on 5/23/14.
//  Copyright (c) 2014 LocusLabs. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>

@protocol LLJavaScriptBridgeObject <NSObject>

- (NSString *)uuid;

@end

@class LLJavaScriptBridge;

@protocol LLJavaScriptBridgeDelegate <NSObject>

- (void)javaScriptBridgeReady:(LLJavaScriptBridge *)javaScriptBridge;

@end

@interface LLJavaScriptBridge : NSObject <UIWebViewDelegate> {
    UIWebView *_webView;
    NSMutableArray *_pendingJavaScript;
    BOOL _ready;
    NSMapTable *_objects;
    __weak id<LLJavaScriptBridgeDelegate> _delegate;
}

@property (strong,nonatomic) UIWebView *webView;
@property (strong,nonatomic) NSMutableArray *pendingJavaScript;
@property (assign) BOOL ready;
@property (strong,nonatomic) NSMapTable *objects;
@property (weak,nonatomic) id<LLJavaScriptBridgeDelegate> delegate;
@property (assign) BOOL isSharedBridge;

+ (LLJavaScriptBridge *)javaScriptBridgeWithWebView:(UIWebView *)webView;
+ (LLJavaScriptBridge *)sharedJavaScriptBridge;
+ (void)resetSharedJavaScriptBridge;
+ (NSString *)toJSON:(id)object;

- (id)initWithWebView:(UIWebView *)webView;
- (id)initWithWebView:(UIWebView *)webView isSharedBridge:(BOOL)isSharedBridge;
- (id)runJavaScript:(NSString *)javaScript;
- (void)javaScriptReady;
- (id)javaScriptCall:(NSString *)method;
- (id)javaScriptCall:(NSString *)method withArgument:(id)argument;
- (id)javaScriptCall:(NSString *)method withArguments:(NSArray *)arguments;
- (id)fromJavaScriptObject:(id)object klass:(Class)klass;
- (void)beginSession;
- (void)submitSessionEvent:(NSObject *)event;

- (void)registerJavaScriptBridgeObject:(NSObject<LLJavaScriptBridgeObject> *)object;
- (void)releaseJavaScriptBridgeObject:(NSObject<LLJavaScriptBridgeObject> *)object;
- (NSObject<LLJavaScriptBridgeObject> *)findJavaScriptBridgeObject:(NSString *)uuid;

@end
