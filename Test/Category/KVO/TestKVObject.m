//
//  TestKVObject.m
//  Test
//
//  Created by 强王 on 2022/3/30.
//

#import "TestKVObject.h"

@implementation TestKVObject

- (instancetype)init {
    if (self = [super init]) {
        NSLog(@"%@", NSStringFromClass(self.class));
        ///依然是self开始调用
        NSLog(@"%@", NSStringFromClass(super.class));
        
        
        
        /*
         可以看到- (Class)class是在NSObject声明的，
         
        - (Class)class {
            return object_getClass(self);
        }
        
        Class object_getClass(id obj)
        {
            if (obj) return obj->getIsa();
            else return Nil;
        }
        
         可以看到，这里实际调用的是obj->getIsa()
         
         [super class] ===> objc_msgSend(super,@selector(class));
         super 转位 objc_super
         objc_msgSendSuper
         内部的receiver 是self，所以消息的时机接受者是self
         
         那么我有个问题
         super init 也就是调用 self init了？
         那这样不就是死循环了吗？
         
         
         
         */
    }
    return self;
}

- (void)change {
    _testString = @"hahahah1";
    self.numberValue ++;
}

- (void)sayHello {
    NSLog(@"sayHello");
}
@end
