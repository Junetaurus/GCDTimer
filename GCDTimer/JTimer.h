//
//  JTimer.h
//  GCDTimer
//
//  Created by Zhang on 2019/7/12.
//  Copyright © 2019 cue. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


/*
+ (NSTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)interval repeats:(BOOL)repeats block:(void (^)(NSTimer *timer))block

+ (NSTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)ti target:(id)aTarget selector:(SEL)aSelector userInfo:(nullable id)userInfo repeats:(BOOL)yesOrNo;
 */

@interface JTimer : NSObject

/**
 定时器初始化

 @param start 开始时间
 @param interval 间隔时间
 @param repeats 是否重复执行
 @param async 是否异步执行
 @param block 执行的任务
 @return 定时器标识
 */
+ (NSString *)scheduledTimerWithTimeStart:(NSTimeInterval)start  interval:(NSTimeInterval)interval repeats:(BOOL)repeats async:(BOOL)async block:(void (^)(void))block;

/**
 定时器初始化

 @param start 开始时间
 @param interval 间隔时间
 @param repeats 是否重复执行
 @param async 是否异步执行
 @param target 执行对象
 @param selector 执行的方法
 @return 定时器标识
 */
+ (NSString *)scheduledTimerWithTimeStart:(NSTimeInterval)start  interval:(NSTimeInterval)interval repeats:(BOOL)repeats async:(BOOL)async target:(id)target selector:(SEL)selector;

/**
 取消定时器任务

 @param name 定时器标识
 */
+ (void)cancelTimerWithName:(NSString *)name;

@end

NS_ASSUME_NONNULL_END
