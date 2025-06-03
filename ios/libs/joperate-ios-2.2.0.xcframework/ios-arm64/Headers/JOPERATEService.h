//
//  JOPERATEService.h
//  JOperate
//
//  Created by ys on 2021/7/2.
//

#import <Foundation/Foundation.h>

#define JOPERATE_VERSION_NUMBER 2.2.0

NS_ASSUME_NONNULL_BEGIN
@class JOPERATEUserID;
@class JOPERATEEventObject;
@class JOPERATEUserChannel;


@interface JOPERATEConfig : NSObject

/* appKey 必须的,应用唯一的标识. */
@property (nonatomic, copy) NSString *appKey;
/* channel 发布渠道. 可选，默认为空*/
@property (nonatomic, copy) NSString *channel;
/* advertisingIdentifier 广告标识符（IDFA). 可选，默认为空*/
@property (nonatomic, copy) NSString *advertisingId;
/* isProduction 是否生产环境. 如果为开发状态,设置为NO;如果为生产状态,应改为YES.可选，默认为NO */
@property (nonatomic, assign) BOOL isProduction;
//用户标识字典 当设置该属性时时会在初始化时进行设置用户标识，2.1.1版本支持
@property (nonatomic, strong) NSDictionary<NSString *, NSString *> *userIDs;
/* 请求结果回调, errcode:0为成功，2.1.1版本支持 */
@property (nonatomic, copy) void (^completion)(NSInteger errcode, NSString * msg);

@end


@interface JOperateCollectControl : NSObject

/* wifi WIFI信息。设置为NO,不采集wifi信息。默认为YES。*/
@property (nonatomic, assign) BOOL wifi;
/* ssid SSID信息。设置为NO,不采集SSID信息。默认为YES。 */
@property (nonatomic, assign) BOOL ssid;
/* bssid BSSID信息。设置为NO,不采集bssid信息。默认为YES。 */
@property (nonatomic, assign) BOOL bssid;
/* gps 经纬度信息。设置为NO,不采集经纬度信息。默认为YES。 */
@property (nonatomic, assign) BOOL gps;

@end

@interface JOPERATEService : NSObject

/*!
 * @abstract 初始化SDK
 *
 */
+ (void)initializeSDK;

/*!
 * @abstract 启动SDK
 *
 * @param config SDK启动相关模型,必填
 *
 * @discussion 调用该接口之前请确保先调用初始化SDK接口(initialize)。
 */
+ (void)operationStart:(JOPERATEConfig *)config;

/**
 设置用户标识
 
 @param userID 用户标识模型
 */
+ (void)identifyAccount:(JOPERATEUserID *)userID;

/**
 设置用户通道
 
 @param channel 用户通道模型
 */
+ (void)setUserChannel:(JOPERATEUserChannel *)channel;

/*！自定义事件统计
 *
 * @param event 上报的自定义事件模型
 */
+ (void)eventRecord:(JOPERATEEventObject *)event;

/**
    上报所有当前缓存的事件
 */
+ (void)flush;

/**
 设置上报数据间隔，不调用该接口时，默认为10s上报一次事件数据
 上报间隔内存缓存，需要在应用程序每次生命周期中调用才会生效
 
 @param interval 上报间隔，单位s(秒)
 */
+ (void)setReportInterval:(NSInteger)interval;


/**
    设置事件缓存上限条数，默认50条，最高不能超过500条
    当超出缓存数量时会上报全部数据
    @param count 事件缓存条数上限
 */
+ (void)setMaxEventCacheCount:(NSInteger)count;

//获取运营增长CUID
+ (NSString *)CUID;

/**
 * 设置UTM属性
 *
 * @discussion
 * UTM属性为预置属性
 * 目前能够设置UTM属性为
 * utm_source 广告系列来源
 * utm_medium 广告系列媒介
 * utm_term 广告系列字词
 * utm_content 广告系列内容
 * utm_campaign 广告系列名称
 *
 */
+ (void)setUtmProperties:(NSDictionary<NSString*, NSString *> *)property;

/**
 * 设置事件通用的公共属性，会缓存到本地
 *
 * @discussion
 * 当事件属性和公共属性重复时，事件属性会覆盖公共属性
 * @param property 公共属性
 * 1、key为NSString，只能包含数字小写字母下划线，以及以字母开头；
 * 2、value可以是NSString/NSNumber/NSSet、NSArray
 * 3、NSSet、NSArray 中的所有元素必须为 NSString
 */
+ (void)setCommonProperties:(NSDictionary *)property;
 
/**
 * 设置事件的动态公共属性
 *
 * @discussion
 * 当事件属性和公共属性和动态公共属性三者重复时
 * 会按如下优先级进行覆盖
 * 事件属性 > 动态公共属性 > 静态公共属性
 * 1、key为NSString，只能包含数字小写字母下划线，以及以字母开头；
 * 2、value可以是NSString/NSNumber/NSSet、NSArray
 * 3、NSSet、NSArray 中的所有元素必须为 NSString
 * @param dynamicProperties block 用来返回事件的动态公共属性
 */
+ (void)setDynamicCommonProperties:(NSDictionary<NSString *, id> *(^)(void)) dynamicProperties; //设置动态公共属性

/**
 * @abstract
 * 删除某个静态公共属性
 *
 * @param key 待删除的property的key
 */
+ (void)unregisterCommonProperty:(NSString *)key;

/**
 * @abstract
 * 删除当前所有的静态公共属性
 */
+ (void)clearCommonProperties;

/**
 * @abstract
 * 静态公共属性的副本
 *
 * @return 当前的静态公共属性的副本
 */
+ (NSDictionary *)currentCommonProperties;

/**
 * @abstract
 * 设置用户属性
 *
 * 这些 用户属性 的内容用一个 NSDictionary 来存储
 * 其中的 key 是 用户属性 的名称，必须是 NSString
 * Value 则是 用户属性 的内容，只支持 NSString、NSNumber，NSSet、NSArray 这些类型
 * 特别的，NSSet 或者 NSArray 类型的 value 中目前只支持其中的元素是 NSString
 * 如果某个 用户属性 之前已经存在了，则这次会被覆盖掉；不存在，则会创建
 *
 * @param userinfo 要替换的那些 用户属性 的内容
 * @param completion 回调
 */
+ (void)set:(NSDictionary *)userinfo completion:(void (^)(NSInteger errcode, NSString * msg))completion;
 
/**
 * @abstract
 * 设置用户的单个 用户属性 的内容
 *
 * 如果这个 用户属性 之前已经存在了，则这次会被覆盖掉；不存在，则会创建
 * Value 是 用户属性 的内容，只支持 NSString、NSNumber，NSSet、NSArray 这些类型
 * 特别的，NSSet 或者 NSArray 类型的 value 中目前只支持其中的元素是 NSString
 *
 * @param key 用户属性 的名称
 * @param value 用户属性 的内容
 * @param completion 回调
 */
+ (void)set:(NSString *)key to:(id)value completion:(void (^)(NSInteger errcode, NSString * msg))completion;
 
 
/**
 * @abstract
 * 首次设置用户的一个或者几个 用户属性
 *
 * 与 set 接口不同的是，如果该用户的某个 用户属性 之前已经存在了，会被忽略；不存在，则会创建
 * 这些 用户属性 的内容用一个 NSDictionary 来存储
 * 其中的 key 是 用户属性 的名称，必须是 NSString
 * Value 则是 用户属性 的内容，只支持 NSString、NSNumber，NSSet、NSArray 这些类型
 * 特别的，NSSet 或者 NSArray 类型的 value 中目前只支持其中的元素是 NSString
 *
 * @param userinfo 要替换的那些 用户属性 的内容
 * @param completion 回调
 */
+ (void)setOnce:(NSDictionary *)userinfo completion:(void (^)(NSInteger errcode, NSString * msg))completion;
 
 
/**
 * @abstract
 * 给一个数值类型的 用户属性 增加一个数值
 *
 * 只能对 NSNumber 类型的 用户属性 调用这个接口，否则会被忽略
 * 如果这个 用户属性 之前不存在，则初始值当做 0 来处理
 *
 * @param key  待增加数值的 用户属性 的名称
 * @param amount   要增加的数值
 * @param completion 回调
 */
+ (void)increment:(NSString *)key by:(NSNumber *)amount completion:(void (^)(NSInteger errcode, NSString * msg))completion;
 
/**
 * @abstract
 * 给多个数值类型的 用户属性 增加数值
 *
 * profileDict 中，key 是 NSString ，value 是 NSNumber
 * 其它与 - (void)increment:by: 相同
 *
 * @param userinfo 多个
 * @param completion 回调
 */
+ (void)increment:(NSDictionary *)userinfo completion:(void (^)(NSInteger errcode, NSString * msg))completion;
 
/**
 * @abstract
 * 向一个 NSSet 或者 NSArray 类型的属性 添加一些值
 *
 * 如前面所述，这个 NSSet 或者 NSArray 的元素必须是 NSString，否则，会忽略
 * 同时，如果要 append 的 用户属性 之前不存在，会初始化一个空的 NSSet 或者 NSArray
 *
 * @param key key
 * @param content description
 * @param completion 回调
 */
+ (void)append:(NSString *)key by:(NSObject<NSFastEnumeration> *)content completion:(void (^)(NSInteger errcode, NSString * msg))completion;
     
/**
 * @abstract
 * 删除某个 用户属性 的全部内容
 * 如果这个 用户属性 之前不存在，则直接忽略
 *
 * @param key 用户属性 的名称
 * @param completion 回调
 */
+ (void)unset:(NSString *)key completion:(void (^)(NSInteger errcode, NSString * msg))completion;
 
/**
 开始事件计时
 
 若需要统计某个事件的持续时间，先在事件开始时调用 timeKeepingEventStart:"事件名" 记录事件开始时间，该方法并不会真正发送事件；
 随后在事件结束时，调用 timeKeepingEventEnd:"事件ID" with:properties，
 
 @param event 事件名称
 @return 返回计时事件的 eventId，用于结束事件计时。
 */
+ (nullable NSString *)timeKeepingEventStart:(NSString *)event;
 
/**
 结束事件计时
 
 多次调用时，以首次调用为准
 
 @param eventId 事件的Id
 @param propertys 自定义属性，规则同事件统计
 */
+ (void)timeKeepingEventEnd:(NSString *)eventId with:(nullable NSDictionary *)properties;

 
/**
 暂停事件计时
 多次调用时，以首次调用为准。
 
 @param eventId 事件的eventId
 */
+ (void)timeKeepingEventPause:(NSString *)eventId;
 
/**
 恢复事件计时
 多次调用时，以首次调用为准。
 
 @param eventId 事件的eventId
 */
+ (void)timeKeepingEventResume:(NSString *)eventId;
 
/**
 删除事件计时

 多次调用时，只有首次调用有效。
 
 @param eventId 事件的eventId
*/
+ (void)removeTimeKeepingEvent:(NSString *)eventId;
    
/**
 清除所有计时事件
 */
+ (void)clearTimeKeepingEvent;


/**
 * @abstract
 * 您的项目是否已经开通了运营增长
 * @param completion 回调
 */
+ (void)isValid:(void (^)(NSInteger code, NSString * msg))completion;

/**
 * @abstract
 * 用户数据
 * 格式如下
 * {
     "code": 0,//0为成功，-1为超出频次
     "project": { //项目信息数据
         "name": "", //项目名称
         "id": "", //项目ID
     },
     "events": [{ //自定义事件数据
         "name": "", //事件显示名称
         "key": "", //事件key
     }],
     "tag": { //标识数据
         "loginId": "", //登陆id
         "phone": "", //手机号
     },
     "channels": [{ //通道数据 //显示排序为服务器返回数据顺序
         "name": "", //属性显示名
         "key": "", //属性key
         "value": "", //属性value //没有值可为""或null
     }],
     "user": [{ //用户属性数据 //显示排序为服务器返回数据顺序
         "name": "", //属性显示名
         "key": "", //属性key
         "value": "", //属性value
         "type": 0, //设置类型，0覆盖，1累计，2、增加（数组类型），3不可修改（首次）
         "edit_type": 0 //编辑类型，，0:字符串，1：数字，2、日期(2021-09-09)，3，时间戳，4，数组，5，布尔
     }]
    }
 *  数据主要用于demo使用，有请求限制，每10s只能请求一次
 * @param completion code:为0则为成功， data:用户数据
 */
+ (void)userData:(void (^)(NSInteger code, NSDictionary<NSString*,  id> * data))completion;

/**
 * @abstract
 * 项目信息
 * @param completion 回调
 */

+ (void)appInfo:(void (^)(NSInteger code, NSDictionary<NSString*,  id> * data))completion;

/**
 * @abstract
 * 外围属性
 */

+ (NSArray *)peripheralData;

/*!
 * @abstract 设置是否打印sdk产生的Debug级log信息, 默认为NO(不打印log)
 *
 * SDK 默认开启的日志级别为: Info. 只显示必要的信息, 不打印调试日志.
 *
 * 请在SDK启动后调用本接口，调用本接口可打开日志级别为: Debug, 打印调试日志.
 * 请在发布产品时改为NO，避免产生不必要的IO
 */
+ (void)setDebug:(BOOL)enable;

/**
 进入数据校验模式
 
 @param url 回调的url，在 Appdelegate 的 application:handleOpenURL: 中调用。不调用此接口 JOPERATE 将无法进入数据校验模式。
 */
+ (void)openDebugMode:(NSURL *)url;

/**
 数据采集控制
 
 @param control 数据采集配置。
 */
+ (void)setCollectControl:(JOperateCollectControl *)control;


@end

//用户标识模型
@interface JOPERATEUserID : NSObject

//用户标识字典
@property (nonatomic, strong) NSDictionary<NSString *, NSString *> *userIDs;
/* 请求结果回调, errcode:0为成功 */
@property (nonatomic, copy) void (^completion)(NSInteger errcode, NSString * msg);

@end

/**
 * @abstract 自定义事件对象
 *
 * @discussion 所有的字符串属性长度不能超过256字节（包括extra的key）
 *
 */
@interface JOPERATEEventObject : NSObject
//事件ID，必填，非空，不能使用jg前缀
@property (nonatomic, copy, nonnull) NSString * eventName;
//自定义属性（<=500个）key为NSString，只能包含数字小写字母下划线，以及以字母开头
@property (nonatomic, strong, nonnull) NSDictionary<NSString *, id> * property;

@end


//用户通道模型
@interface JOPERATEUserChannel : NSObject

@property (nonatomic, strong) NSDictionary<NSString *, NSDictionary<NSString *, NSString *> *> *channels;

/* 请求结果回调, errcode:0为成功 */
@property (nonatomic, copy) void (^completion)(NSInteger errcode, NSString * msg);

@end


NS_ASSUME_NONNULL_END
