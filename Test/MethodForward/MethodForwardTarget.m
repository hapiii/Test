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
//
//- (void)otherTest {
//    NSLog(@"otherTest");
//    [self otherTest];
//}

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
@end

@implementation ChildMethodForwardTarget

+ (void)logTest {
    NSLog(@"ChildMethodForwardTarget");
}


+ (void)testAction {
    [self logTest];
    [super logTest];
    NSLog(@"%@", NSStringFromClass(self.class));
    NSLog(@"%@", NSStringFromClass(super.class));
}

@end
