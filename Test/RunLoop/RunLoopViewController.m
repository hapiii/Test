//
//  RunLoopViewController.m
//  Test
//
//  Created by 强王 on 2022/4/1.
//

#import "RunLoopViewController.h"

@interface RunLoopViewController ()

@end

@implementation RunLoopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

+ (void)runRequest {
    CFRunLoopSourceContext context = {};
    CFRunLoopSourceRef source = CFRunLoopSourceCreate(kCFAllocatorDefault, 0, &context);
    /// 常驻线程
    CFRunLoopAddSource(CFRunLoopGetCurrent(), source, kCFRunLoopDefaultMode);
    
    @autoreleasepool {
        //运行
        CFRunLoopRunInMode(kCFRunLoopDefaultMode, 1.0e10, true);
    }
    
    
    NSTimer *timer = [[NSTimer alloc] init];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
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
