//
//  MethodForwardTarget.m
//  Test
//
//  Created by 强王 on 2022/3/31.
//

#import "MethodForwardTarget.h"
#import <objc/runtime.h>

@implementation MethodForwardTarget

+ (void)load {
    Method test = class_getInstanceMethod(self, @selector(test));
    Method otherTest = class_getInstanceMethod(self, @selector(otherTest));
    method_exchangeImplementations(test, otherTest);
}

//- (void)test {
//    NSLog(@"test");
//}

- (void)otherTest {
    NSLog(@"otherTest");
    [self otherTest];
}

void testImp (void) {
    NSLog(@"testImp");
}

- (void)hahaha {
    NSLog(@"hahaha");
}
+ (BOOL)resolveInstanceMethod:(SEL)sel {
    
    if ([NSStringFromSelector(sel) isEqualToString:@"test"]) {
        NSLog(@"resolveInstanceMethod");
        //动态添加方法
        Method haha = class_getInstanceMethod(self, @selector(hahaha));
        IMP imp = method_getImplementation(haha);
        class_addMethod(self, @selector(test), imp, "v@:");
        return YES;
    } else {
        return [super resolveInstanceMethod:sel];
    }
}

/// 转发给其他对象
- (id)forwardingTargetForSelector:(SEL)aSelector {
    NSLog(@"forwardingTargetForSelector");
    return nil;
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    NSLog(@"methodSignatureForSelector");
    if ([NSStringFromSelector(aSelector) isEqualToString:@"test"]) {
        return [NSMethodSignature signatureWithObjCTypes:"v@:"];
        //return [NSMethodSignature methodSignatureForSelector:aSelector];
    }
    return [super methodSignatureForSelector:aSelector];
}

- (void)forwardInvocation:(NSInvocation *)anInvocation {
    NSLog(@"forwardInvocation:");
}

+ (void)logTest {
    NSLog(@"superMethodForwardTarget");
}

+ (Class)class {
    return NSClassFromString(@"ChildMethodForwardTarget");
}

@end

@implementation ChildMethodForwardTarget

+ (void)logTest {
    NSLog(@"ChildMethodForwardTarget");
}

+ (void)testAction {
    [self logTest];
    [super logTest];
    NSLog(@"%@", NSStringFromClass([self class]));
    NSLog(@"%@", NSStringFromClass([super class]));
    /*
     self class  接受者：当前对象，NSObject 实现
     super class 接受者：当前对象，当前对象的父方法开始查找。但是实现都是 NSObject
     objc_msgSendSuper(objc_super, sel)
     objc_super {
     receiver 就是当前对象
     
     }
     
     objc_msgSendSuper 和 objc_msgSend 区别：
     objc_msgSendSuper 从父类方法列表里开始查找
     而objc_msgSend 是从本类方法里查找
     
     
     消息传递：
     1. cache_t 缓存查找
     2. method_array_t 排序:二分，未排序:遍历
     3. 消息转发
     
     Unrecognized Selector crash 拦截:
     
     
     performSelector:
     
     
     @dynamic
     手动添加set和get，将函数决议推送到运行时（即函数调用时）
     
     */
    
    
}

+ (Class)class {
    return NSClassFromString(@"ChildMethodForwardTarget");
}

@end
