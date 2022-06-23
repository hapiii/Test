//
//  SemaphoreViewController.m
//  Test
//
//  Created by wq on 2022/6/9.
//

#import "SemaphoreViewController.h"

@interface SemaphoreViewController ()

@end

@implementation SemaphoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    for (NSInteger i = 0; i < 9; i++) {
        dispatch_queue_t queue = dispatch_queue_create("外部调用", 0);
        dispatch_async(queue, ^{
            NSLog(@"开始执行 ===> %li ===>%@",i , [NSThread currentThread]);
            dispatch_semaphore_t sem = dispatch_semaphore_create(0);
            __block NSInteger unreadCount = 0;
            
            [self asyncLoadindex:i handle:^(NSString *name) {
                unreadCount += 1;
                NSLog(@"执行中===> %li ===>%@",i, [NSThread currentThread]);
                dispatch_semaphore_signal(sem);
            }];
            dispatch_semaphore_wait(sem, DISPATCH_TIME_FOREVER);
            NSLog(@"执行完成===> %li ===>%@",i, [NSThread currentThread]);
        });
    }
   
    
}

- (void)asyncLoadindex:(NSInteger)index handle:(void(^)(NSString *name))handle {
    dispatch_queue_t queue = dispatch_queue_create("网络请求",  0);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), queue, ^{
        handle(@"hello");
        NSLog(@"执行内部===> %li ===>%@", (long)index, [NSThread currentThread]);
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
