//
//  SemaphoreViewController.m
//  Test
//
//  Created by wq on 2022/6/9.
//

#import "SemaphoreViewController.h"
#import "NSString+add.h"
#define StringNotNullAndEmpty(str) (str!=nil && ![(str) isEqual:[NSNull null]] &&![str isEqualToString:@""])

@interface Add : NSObject

@property (nonatomic, copy) NSString *result;

- (nullable id)pep_valueForKey:(NSString *)key;

@end

@implementation Add


- (nullable id)pep_valueForKey:(NSString *)key{
    if (!key.length) {
        return nil;
    }
    id value = nil;
    @try {
        value = [self valueForKey:key];
        if (NSNull.null == value) {
            value = nil;
        }
    } @catch (NSException *exception) {
        NSLog(@"%@",exception);
    } @finally {
    }
    NSLog(@"===?%@",value);
    return value;
}


@end

@interface SemaphoreViewController ()

@end

@implementation SemaphoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
//    for (NSInteger i = 0; i < 9; i++) {
//        dispatch_queue_t queue = dispatch_queue_create("外部调用", 0);
//        dispatch_async(queue, ^{
//            NSLog(@"开始执行 ===> %li ===>%@",i , [NSThread currentThread]);
//            dispatch_semaphore_t sem = dispatch_semaphore_create(0);
//            __block NSInteger unreadCount = 0;
//            
//            [self asyncLoadindex:i handle:^(NSString *name) {
//                unreadCount += 1;
//                NSLog(@"执行中===> %li ===>%@",i, [NSThread currentThread]);
//                dispatch_semaphore_signal(sem);
//            }];
//            dispatch_semaphore_wait(sem, DISPATCH_TIME_FOREVER);
//            NSLog(@"执行完成===> %li ===>%@",i, [NSThread currentThread]);
//        });
//    }
   
//    NSArray *arr = @[@(0),@(1),@(2),@(3),@(3),@(3)];
//    [arr enumerateObjectsUsingBlock:^(NSNumber*  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        if (idx == 2) {
//            return;
//        }
//
//        NSLog(@"%i",obj.intValue);
//    }];
    /*
    NSString *str1 = NULL;
    NSString *str2 = NSNull.new;
    NSString *str3 = nil;
    NSString *str4 = @"nil";
    NSString *str5 = @"NULL";
    NSString *str6 = @"null";
    
    NSLog(@"%i",StringNotNullAndEmpty(str1));
    NSLog(@"%i",StringNotNullAndEmpty(str2));
    NSLog(@"%i",StringNotNullAndEmpty(str3));
    NSLog(@"%i",StringNotNullAndEmpty(str4));
    NSLog(@"%i",StringNotNullAndEmpty(str5));
    NSLog(@"%i",StringNotNullAndEmpty(str6));
     */
    Add *add = [Add new];
    add.result = NSNull.null;
    id obj = [add pep_valueForKey:@"reslut"];
    NSLog(@"obj===>%@",obj);
    NSLog(@"NULL===>%i",[obj isEqual:NSNull.null]);
    NSLog(@"nil===>%i",obj == nil);
    
    NSArray *arr = @[NSNull.null, NSNull.null,NSNull.null,NSNull.null,NSNull.null];
    NSLog(@"%@ %i %@",arr, arr.count, arr.firstObject);
    if (arr.count > 10 && arr[9] == @"hah") {
        NSLog(@"不可能走这里");
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
