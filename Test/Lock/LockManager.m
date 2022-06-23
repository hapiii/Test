//
//  LockManager.m
//  Test
//
//  Created by wq on 2022/5/11.
//

#import "LockManager.h"

@interface LockManager ()

@property (nonatomic, strong) dispatch_semaphore_t semaphore;

@property (nonatomic, assign) int money;
@end

@implementation LockManager

- (instancetype)init {
    if (self = [super init]) {
        self.semaphore = dispatch_semaphore_create(1);
        _money = 0;
    }
    return self;
}

- (void)addMoney:(NSInteger)count {
    dispatch_semaphore_wait(self.semaphore, 3);
   
    
        self.money += count;
        NSLog(@"收入+%i元 总计 %i 元", count, self.money);
        dispatch_semaphore_signal(self.semaphore);
    
    
}

+ (void)lockHandle:(void (^)(void))handle {
    NSInteger time = random()% 10;
    NSLog(@"任务 %i我要卡住了，等%i秒",index, time);
    dispatch_queue_t queue = dispatch_queue_create(0, 0);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(time * NSEC_PER_SEC)), queue, ^{
        NSLog(@"任务 %i我卡完了，咱继续",index);
        handle();
    });
}
@end
