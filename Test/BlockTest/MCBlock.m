//
//  MCBlock.m
//  Test
//
//  Created by wq on 2023/6/13.
//

#import "MCBlock.h"

@implementation MCBlock

int global_var = 4;
static int static_global_var = 5;

- (void)method {
    //clang -rewrite-objc -fobjc-arc file.m
    int var = 6;
    __unsafe_unretained id unsafe_obj = nil;
    __strong id strong_objc = nil;
    static int static_var = 3;
    
    int (^testBlock)(int) = ^int(int num) {
        
        NSLog(@"局部变量<基本数据类型> var %d",var);
        NSLog(@"局部变量<__unsafe_unretained> unsafe_obj %@",unsafe_obj);
        NSLog(@"局部变量<__strong> strong_objc %@",strong_objc);
        
        NSLog(@"静态局部变量<static_var> var %d",static_var);
        
        NSLog(@"全局变量<global_var> %d",global_var);
        NSLog(@"静态局部变量<static_global_var> %d",static_global_var);
        return var * num;
    };
    testBlock(2);
}

@end
