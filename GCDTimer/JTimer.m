//
//  JTimer.m
//  GCDTimer
//
//  Created by Zhang on 2019/7/12.
//  Copyright © 2019 cue. All rights reserved.
//

#import "JTimer.h"

static NSMutableDictionary *timers_;
static dispatch_semaphore_t semaphore_;

@implementation JTimer

+ (void)initialize {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        timers_ = [NSMutableDictionary dictionary];
        semaphore_ = dispatch_semaphore_create(1);
    });
}

+ (NSString *)scheduledTimerWithTimeStart:(NSTimeInterval)start interval:(NSTimeInterval)interval repeats:(BOOL)repeats async:(BOOL)async block:(void (^)(void))block {
    
    if (!block || start < 0 || (interval <= 0 && repeats)) return nil;
    //创建 queue
    dispatch_queue_t queue = async ? dispatch_get_global_queue(0, 0) : dispatch_get_main_queue();
    //创建 async
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    //设置 timer
    dispatch_source_set_timer(timer, dispatch_time(DISPATCH_TIME_NOW, start * NSEC_PER_SEC), interval * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
    //存储 timer
    dispatch_semaphore_wait(semaphore_, DISPATCH_TIME_FOREVER);
    NSString *name = [NSString stringWithFormat:@"%zd", timers_.count];
    timers_[name] = timer;
    dispatch_semaphore_signal(semaphore_);
    //设置 handler
    dispatch_source_set_event_handler(timer, ^{
        block();
        if (!repeats) {
            [self cancelTimerWithName:name];
        }
    });
    //启动 timer
    dispatch_resume(timer);
    return name;
}

+ (NSString *)scheduledTimerWithTimeStart:(NSTimeInterval)start interval:(NSTimeInterval)interval repeats:(BOOL)repeats async:(BOOL)async target:(id)target selector:(SEL)selector {
    
    return [self scheduledTimerWithTimeStart:start interval:interval repeats:repeats async:async block:^{
        if ([target respondsToSelector:selector]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            [target performSelector:selector];
#pragma clang diagnostic pop
        }
    }];
}

+ (void)cancelTimerWithName:(NSString *)name {
    if (!name || !name.length) return;
    
    dispatch_semaphore_wait(semaphore_, DISPATCH_TIME_FOREVER);
    dispatch_source_t timer = timers_[name];
    if (timer) {
        dispatch_source_cancel(timer);
        [timers_ removeObjectForKey:name];
    }
    dispatch_semaphore_signal(semaphore_);
}

@end
