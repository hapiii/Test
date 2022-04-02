//
//  GCDViewController.m
//  Test
//
//  Created by 强王 on 2022/3/31.
//

#import "GCDViewController.h"

@interface GCDViewController (){
    dispatch_queue_t queue;
}
@property (nonatomic, strong) NSMutableDictionary *mArr;

@end

@implementation GCDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    queue = dispatch_queue_create("read_write_queue", DISPATCH_QUEUE_CONCURRENT);
    self.mArr = @{}.mutableCopy;
    // Do any additional setup after loading the view.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self queueLock];
}

///队列卡死
- (void)queueLock {
    
    dispatch_sync(dispatch_get_main_queue(), ^{
        NSLog(@"我 卡住了！");
    });
    
}
///子线程手动开启runLoop
- (void)childQueueNeedOpenRunLoop {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSLog(@"1");
        //必须手动开启
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
        [self performSelector:@selector(log2) withObject:nil afterDelay:0];
        NSLog(@"3");
    });
    
}

- (void)log2 {
    NSLog(@"2");
}

- (id)objectForKey:(NSString *)key {
    __block id obj;
    dispatch_sync(queue, ^{
        obj = [self.mArr objectForKey:key];
    });
    return obj;
}

- (void)setObject:(id)obj ForKey:(NSString *)key {
    dispatch_barrier_sync(queue, ^{
        [self.mArr setValue:obj forKey:key];
    });
    
}

- (void)group {
 //信号量
    
    dispatch_queue_t queue = dispatch_queue_create("11", DISPATCH_QUEUE_SERIAL);
    dispatch_semaphore_t lock = dispatch_semaphore_create(1);
    dispatch_semaphore_signal(lock);
    dispatch_semaphore_wait(lock, 4);
    
}

- (void)operation {
    /*
     添加依赖
     状态控制
     
     isReady
     isExecuting
     isFinished
     isCancelled
     优先级
     最大并发量
     */
    NSOperationQueue *queur = [[NSOperationQueue alloc] init];
    NSOperation *op = [[NSOperation alloc] init];
    
}

@end
