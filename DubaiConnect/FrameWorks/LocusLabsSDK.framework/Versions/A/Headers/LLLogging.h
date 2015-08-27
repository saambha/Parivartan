/*
 *
 * Licensed under the Apache License, Version 2.0 (the "License").
 * You may not use this file except in compliance with the License.
 * A copy of the License is located at
 *
 *  http://aws.amazon.com/apache2.0
 *
 * or in the "license" file accompanying this file. This file is distributed
 * on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either
 * express or implied. See the License for the specific language governing
 * permissions and limitations under the License.
 */

#import <Foundation/Foundation.h>

#import "LLJavaScriptObject.h"


#define LLLogFormat @"%@ line:%d | %s | "

#define LLLogError(fmt, ...)    [[LLLogger defaultLogger] log:LLLogLevelError format:(LLLogFormat fmt), [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__, __PRETTY_FUNCTION__, ##__VA_ARGS__]
#define LLLogWarn(fmt, ...)    [[LLLogger defaultLogger] log:LLLogLevelWarn format:(LLLogFormat fmt), [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__, __PRETTY_FUNCTION__, ##__VA_ARGS__]
#define LLLogInfo(fmt, ...)    [[LLLogger defaultLogger] log:LLLogLevelInfo format:(LLLogFormat fmt), [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__, __PRETTY_FUNCTION__, ##__VA_ARGS__]
#define LLLogDebug(fmt, ...)    [[LLLogger defaultLogger] log:LLLogLevelDebug format:(LLLogFormat fmt), [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__, __PRETTY_FUNCTION__, ##__VA_ARGS__]
#define LLLogVerbose(fmt, ...)    [[LLLogger defaultLogger] log:LLLogLevelVerbose format:(LLLogFormat fmt), [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__, __PRETTY_FUNCTION__, ##__VA_ARGS__]

#define LLLogFixMe(fmt, ...)    [[LLLogger defaultLogger] log:LLLogLevelDebug format:(LLLogFormat fmt), [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__, __PRETTY_FUNCTION__, ##__VA_ARGS__]

typedef NS_ENUM(NSInteger, LLLogLevel) {
    LLLogLevelUnknown = -1,
    LLLogLevelNone = 0,
    LLLogLevelError = 1,
    LLLogLevelWarn = 2,
    LLLogLevelInfo = 3,
    LLLogLevelDebug = 4,
    LLLogLevelVerbose = 5
};

/**
 *  AZLogger is an utility class that handles logging to the console.
 *  You can specify the log level to control how verbose the output will be.
 */
@interface LLLogger : LLJavaScriptObject

/**
 *  The log level setting. The default is LLLogLevelNone.
 */
@property (atomic, assign) LLLogLevel logLevel;

/**
 *  Returns the shared logger object.
 *
 *  @return The shared logger object.
 */
+ (instancetype)defaultLogger;

/**
 *  Prints out the formatted logs to the console.
 *
 *  @param logLevel The level of this log.
 *  @param fmt      The formatted string to log.
 */
- (void)log:(LLLogLevel)logLevel
     format:(NSString *)fmt, ... NS_FORMAT_FUNCTION(2, 3);

@end