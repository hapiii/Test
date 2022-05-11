//
//  NSObject+Hello.m
//  Test
//
//  Created by 强王 on 2022/3/31.
//

#import "NSObject+Hello.h"

@implementation NSObject (Hello)

- (void)sayHello {
    NSLog(@"NSObject say Hello");
    
    /*
     实验结果:
     当在一个不是NSObject类中声明一个类方法，在内部实现同名的实例方法。 调用会crash
     但是如果在NSObject里实现同名的实例方法。是不会crash的
     
     原因：
     类方法会沿着元类对象的superClass 逐层递归，但是 根元类对象的superClass 指向 Root类对象。也就是NSObject 的类对象，
     NSOBject类对象的方法列表里保存着 对应的实例方法。所以说是可以执行到这个实例方法
     
     但是RootClass 的super指针指向nil，不会向下查找。所以说，非NSObject 中实现是调用不到的。
     
     */
    
    /*
     消息传递：
     objc_msgSendSuper
     objc_super
     
     */
}
@end
