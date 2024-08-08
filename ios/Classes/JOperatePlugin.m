#import "JOperatePlugin.h"
// 引入 JOPERATEService.h 头文件
#import "JOPERATEService.h"
// 如果需要使用 idfa 功能所需要引入的头文件（可选）
#import <AdSupport/AdSupport.h>
@implementation JOperatePlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar> *)registrar {
    FlutterMethodChannel *channel = [FlutterMethodChannel
                                     methodChannelWithName:@"j_operate"
                                           binaryMessenger:[registrar messenger]];
    JOperatePlugin *instance = [[JOperatePlugin alloc] init];

    [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall *)call result:(FlutterResult)result {
    if ([@"getPlatformVersion" isEqualToString:call.method]) {
        result([@"iOS " stringByAppendingString:[[UIDevice currentDevice] systemVersion]]);
    } else if ([@"setup" isEqualToString:call.method]) {
        
        [JOPERATEService initializeSDK];
        JOPERATEConfig *config = [[JOPERATEConfig alloc] init];
        config.appKey =call.arguments[@"key"];

        [JOPERATEService operationStart:config];

//        JOPERATEConfig *config = [[JOPERATEConfig alloc] init];
//        config.appKey = call.arguments[@"key"];
//        config.advertisingId = @"";
//        config.isProduction = NO;
//        [JOPERATEService setupWithConfig:config];
        
    }else if([@"setDebug" isEqualToString:call.method]){
        [JOPERATEService setDebug:call.arguments[@"debug"]];
    }else if([@"login" isEqualToString:call.method]){
        JOPERATEUserID *userID = [[JOPERATEUserID alloc] init];
        userID.userIDs = call.arguments;
        [JOPERATEService identifyAccount:userID];
    }else if([@"setChannel" isEqualToString:call.method]){
        JOPERATEUserChannel *channel = [[JOPERATEUserChannel alloc] init];
        channel.channels = call.arguments;
        channel.completion = ^(NSInteger errcode, NSString * _Nonnull msg) {
            result(@(YES));
        };
        [JOPERATEService setUserChannel:channel];
    }else if([@"onEvent" isEqualToString:call.method]){
        NSString* key = call.arguments[@"key"];
        JOPERATEEventObject *e = [[JOPERATEEventObject alloc] init];
        e.eventName = key;
        e.property = call.arguments;
        [JOPERATEService eventRecord:e];
    }else if([@"getCuid" isEqualToString:call.method]){
        NSString* cuid = [JOPERATEService CUID];
        result(cuid);
    }else if([@"registerSuperProperties" isEqualToString:call.method]){
        [JOPERATEService setCommonProperties:call.arguments];
    }else if([@"clearSuperProperties" isEqualToString:call.method]){
        [JOPERATEService clearCommonProperties];
    }else if([@"setUtmProperties" isEqualToString:call.method]){
        [JOPERATEService setUtmProperties:call.arguments];
    }else if([@"profileSet" isEqualToString:call.method]){
        NSString* key = call.arguments[@"key"];
        NSString* value = call.arguments[@"value"];
        [JOPERATEService set:key to:value completion:^(NSInteger errcode, NSString * _Nonnull msg) {
            result(@(YES));
        }];
    }else if([@"profileSetValues" isEqualToString:call.method]){
        [JOPERATEService set:call.arguments completion:^(NSInteger errcode, NSString * _Nonnull msg) {
            result(@(YES));
        }];
    }else if([@"profileSetOnceValues" isEqualToString:call.method]){
        [JOPERATEService setOnce:call.arguments completion:^(NSInteger errcode, NSString * _Nonnull msg) {
            result(@(TRUE));
        }];
    }else if([@"profileSetOnce" isEqualToString:call.method]){
        NSString* key = call.arguments[@"key"];
        NSString* value = call.arguments[@"value"];
        [JOPERATEService setOnce:@{key:value} completion:^(NSInteger errcode, NSString * _Nonnull msg) {
            result(@(TRUE));
        }];
    }else if([@"profileIncrement" isEqualToString:call.method]){
        [JOPERATEService increment:call.arguments completion:^(NSInteger errcode, NSString * _Nonnull msg) {
            result(@(TRUE));
        }];
    }else if([@"profileAppend" isEqualToString:call.method]){
        NSString* key = call.arguments[@"key"];
        NSString* values = call.arguments[@"values"];
        [JOPERATEService append:key by:@[values] completion:^(NSInteger errcode, NSString * _Nonnull msg) {
            result(@(YES));
        }];
    }else if([@"profileAppendValues" isEqualToString:call.method]){

        NSString* key = call.arguments[@"key"];
        NSArray* values = call.arguments[@"values"];
        [JOPERATEService append:key by:values completion:^(NSInteger errcode, NSString * _Nonnull msg) {
            result(@(YES));
        }];
    }else if([@"profileUnset" isEqualToString:call.method]){
        [JOPERATEService unset:call.arguments[@"property"] completion:^(NSInteger errcode, NSString * _Nonnull msg) {
            result(@(true));
        }];
    }else if([@"onEventTimerStart" isEqualToString:call.method]){
        NSString* keyName =  [JOPERATEService timeKeepingEventStart:call.arguments[@"eventName"]];
        result(keyName);
    }else if([@"onEventTimerPause" isEqualToString:call.method]){
        [JOPERATEService timeKeepingEventPause:call.arguments[@"eventNameKey"]];
    }else if([@"onEventTimerResume" isEqualToString:call.method]){
        [JOPERATEService timeKeepingEventResume:call.arguments[@"eventNameKey"]];
    }else if([@"onEventTimerEnd" isEqualToString:call.method]){
        [JOPERATEService timeKeepingEventEnd:call.arguments[@"eventNameKey"] with:nil];
    }else if([@"removeTimer" isEqualToString:call.method]){
        [JOPERATEService removeTimeKeepingEvent:call.arguments[@"eventNameKey"]];
    }else if([@"getPeripheralProperty" isEqualToString:call.method]){
        [JOPERATEService setDebug:call.arguments[@"debug"]];
        result(@(YES));
    }else if([@"setPermissionsAll" isEqualToString:call.method]){
        NSLog(@"ios no impl");
    }else if([@"setPermissionsLocation" isEqualToString:call.method]){
        NSLog(@"ios no impl");
    }else if([@"setPermissionsMac" isEqualToString:call.method]){
        NSLog(@"ios no impl");
    } else {
        result(FlutterMethodNotImplemented);
    }
    
}

@end
