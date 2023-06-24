//
//  GCDViewController.m
//  Test
//
//  Created by 强王 on 2022/3/31.
//

#import "GCDViewController.h"
#import "LockManager.h"
#import <SDWebImage/SDWebImage.h>

static dispatch_group_t _requestDispatchGroup;

@interface GCDViewController (){
    dispatch_queue_t queue;
}
@property (nonatomic, strong) NSMutableDictionary *mArr;
//@property (nonatomic, strong) dispatch_group_t requestDispatchGroup;
@end

@implementation GCDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"gcd";
    queue = dispatch_queue_create("read_write_queue", DISPATCH_QUEUE_CONCURRENT);
    self.mArr = @{}.mutableCopy;
    
    // Do any additional setup after loading the view.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    /*//[self queueLock];
    [self loadConfigMysteryData:1];
    [self loadConfigMysteryData:2];
    [self loadConfigMysteryData:3];
    dispatch_group_notify(_requestDispatchGroup, dispatch_get_main_queue(), ^{
        NSLog(@"执行group%@====>",self.title);
        self.view.backgroundColor = [UIColor redColor];
     0x102f069b0
    });*/
    dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"%@",[NSThread currentThread]);
    });
//    _requestDispatchGroup = dispatch_group_create();
//    [self mockGroup];
}

- (void)mockGroup {
    NSArray *imageURLArray = @[@"1", @"2", @"3", @"4"];
    dispatch_group_t group = dispatch_group_create();
    
    [imageURLArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            //dispatch_group_enter(group);
            [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:[NSURL URLWithString:imageURLArray[idx]] options:SDWebImageDownloaderLowPriority progress:nil completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, BOOL finished) {
                dispatch_group_leave(group);
                NSLog(@"idx:%zd",idx);
            }];
        }];
        dispatch_group_notify(group, dispatch_get_main_queue(), ^{
            NSLog(@"%@", imageURLArray);
        });
}

- (void)dealloc {
    NSLog(@"dealloc");
}

- (void)loadConfigMysteryData:(NSInteger)index {
    
    dispatch_group_enter(_requestDispatchGroup);
    [LockManager lockHandle:^{
        dispatch_group_leave(_requestDispatchGroup);
    }];
    
    
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
