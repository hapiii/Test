//
//  BlockTestViewController.m
//  Test
//
//  Created by 强王 on 2022/3/31.
//

#import "BlockTestViewController.h"
#import "CategoryObject.h"

@interface BlockTestViewController ()

@property (nonatomic, assign) NSString *value;

@property (nonatomic, copy) void (^test)(NSString *str);
@end

@implementation BlockTestViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    __weak typeof(self) weakSelf = self;
    self.test = ^(NSString *str) {
        typeof(weakSelf) strongSelf = weakSelf;
        weakSelf.view.backgroundColor = [UIColor purpleColor];
        NSLog(@"%@",str);
    };
    
    // Do any additional setup after loading the view.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"ddd");
    //[self blockTest];
    [self backTest];
    
}


- (void)backTest {
    
    [UIView animateWithDuration:10 animations:^{
        self.view.backgroundColor = [UIColor purpleColor];
        NSLog(@"animations");
    } completion:^(BOOL finished) {
        NSLog(@"completion");
    }];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.test(@"hello");
    });
    [self.navigationController popViewControllerAnimated:YES];
}

int global_varr = 4;

- (void)blockTest {
    
    self.value = @"6";
    int val = 1;
    __strong CategoryObject *obj = [[CategoryObject alloc] init];
    obj.title = @"nihao1";
    static int static_var = 3;
    NSMutableArray *arr = @[].mutableCopy;
    void (^block)(void) = ^{
        self.value = @"world";
        //值截获 赋值
        NSLog(@"局部变量 %d",val);
        //连同局部变量修饰符一起截获，直接将 block 持有～
        NSLog(@"局部对象 %@ ==%@", obj, obj.title);
        //指针截获静态局部变量
        NSLog(@"静态变量 %d",static_var);
        //全局变量，不截获.
        NSLog(@"全局变量 %d",global_varr);
        //NSLog(@"全局静态变量 %d",static_global_var);
        NSLog(@"实例变量 %@",self.value);
        
        [arr addObject:@"122"];
    };
    block();
    
    NSLog(@"\n \n \n \n \n \n");
    val = 1001;
    obj = [[CategoryObject alloc] init];
    obj.title = @"hello";
    static_var = 1003;
    global_varr = 1004;
    self.value = @"1006";
    
    block();
}

@end
