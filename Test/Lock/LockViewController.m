//
//  LockViewController.m
//  Test
//
//  Created by 强王 on 2022/4/1.
//

#import "LockViewController.h"

@interface LockViewController ()
@property (nonatomic, strong) NSLock *lock;
@property (nonatomic, strong) NSRecursiveLock *recLock;
@property (nonatomic, strong) dispatch_semaphore_t semaphore;
@end

@implementation LockViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.lock = [[NSLock alloc] init];
    /*
    self.semaphore = dispatch_semaphore_create(0);
    //内部会 -1 如果 < 0,会主动阻塞
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    //内部 + 1,如果<= 0 唤起线程 ，被动行为
    dispatch_semaphore_signal(self.semaphore);
     */
    /*NSRecursiveLock 递归锁
    NSLock
     [self.lock lock];
     [self.lock lock];
     直接就锁死了
     
     dispatch_semaphore_t 信号量
     
     
     
     OSSpinLock 自旋锁。自己旋转。循环等待使用。用于轻量级访问，引用计数+1 -1
     spin_lock sideTable 使用自旋锁
     
     @synchronized 单例中使用
     atomic
     */
    
    
    // Do any additional setup after loading the view.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self conditionLockTest];
    
}

- (void)lockA {
    [self.lock lock];
    //[self.lock lock];
    NSLog(@"lockA");
    //[self lockB];
    [self.lock unlock];
    //[self.lock unlock];
    NSLog(@"lockEnd");
}

- (void)lockB {
    [self.lock lock];
    NSLog(@"lockB");
    [self.lock unlock];
}

- (void)recLockA {
    [self.recLock lock];
    [self.recLock lock];
    NSLog(@"recLockA");
    //[self lockB];
    [self.recLock unlock];
    [self.recLock unlock];
    NSLog(@"recLockAEnd");
}

- (void)conditionLockTest {

    NSConditionLock *conditionLock = [[NSConditionLock alloc] initWithCondition:2];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
       [conditionLock lockWhenCondition:1];
       NSLog(@"线程1");
       [conditionLock unlockWithCondition:0];
    });
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
       [conditionLock lockWhenCondition:2];
       NSLog(@"线程2");
       [conditionLock unlockWithCondition:1];
    });
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
       [conditionLock lock];
       NSLog(@"线程3");
       [conditionLock unlock];
    });
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
