# Test




## Category

在调用分类方法时，不管有没有引用头文件，
通过
    SEL selector = NSSelectorFromString(@"aMethod");
    [obj performSelector:selector];
也是可以正常触发分类方法的。

  不再分类.h 声明，依然是会覆盖元类方法的
  因为在attachList内部，也就是所有分类合并后，插入到原类方法是
  先将数组扩容，然后将原来的内容移到最后，再将新的插入。


分类添加关联对象

关联对象由AssonciationsManager 管理，并且保存在AssonciationsHashMap中，所有的关联对象都在一个单例中


AssonciationsHashMap
object 地址 []

分类和扩展的区别

扩展
编译时决议
声明的方式存在，多数情况下 寄生于 .m
不可以为系统类添加拓展

比如：
```
@interface UIView ()
@property (nonatomic, strong) UIView *nodeView;
@end


self.view.nodeView = [[UIView alloc] init];
```
调用时会报错， ```reason: '-[UIView setNodeView:]: unrecognized selector sent to instance 0x103125750'```

代理：
协议调用最好加安全验证
8 29 22 3
通知：
使用观察者模式来实现，用于跨层传递，一对多

如何实现通知机制：

1. 内部维护一个map 表
key 为通知名字 
values 为数组，可以重复添加

### kvo
观察者模式的实现原理？ 
isa 混写实现，内部注册时，观察对象A的某属性，运行时，动态创建 NSKVONotifying_A集成于A,
将 A指针指向NSKVONotifying_A
重新写了set方法
在内部添加
willChangeValueForKey
[super setValue:Obj];
didChangeValueForKey


setter可以触发吗？
可以，直接调用setter方法

kvc 会触发kvo吗？
可以生效，内部会调用set方法

成员变量直接改呢？
不可以！不会触发kvo，但是可以添加willChange 和didChange 就可以生效了


为什么willChange 会触发KVO
内部会触发KVO回调，实现了NSKeyValueObserving协议


打印被观察对象类名，会输出什么呢？
为什么 .class 是 父类呢？因为内部没有实现，交给父类？

     po self.kvoBject.class  打印:TestKVObject
     object_getClassName(self.kvoBject)  打印:NSKVONotifying_TestKVObject


### kvc

ValueForKey
setValueForKey

违背面向对象，

getValueForKey:
是否有get方法， 实例变量是否存在，获取变量， 如果不存在，触发unfindKey 错误。
isKey，

实例变量:

数据结构
objc_object

实例方法，isa指向类对象，在类对象方法列表里查找
类方法，在元类对象方法列表里查找

cache_t 快速查找方法执行
可增量扩展的hash结构
是局部性原理的最佳应用

cache_t ,
bucket_t key: IMP

类对象，存储实力方法列表等信息
元类对象 存储类方法列表等信息



实例对象        类对象         元类对象
self.view ---> UIView ----> meta
元类对象，指向RootClass 
RootClass ssuper，指向RootClass


方法交换


动态添加方法
运行时才产生方法

+ (BOOL)resolveInstanceMethod:(SEL)sel {
    if ([NSStringFromSelector(sel) isEqualToString:@"test"]) {
        NSLog(@"resolveInstanceMethod");
        //动态添加方法
        Method haha = class_getInstanceMethod(self, @selector(hahaha));
        IMP imp = method_getImplementation(haha);
        class_addMethod(self, @selector(test), imp, "v@:");
        }
}


@dynamic



不能，runtime，   ivar 放在class_r_o


什么是BLock
匿名函数，函数及其上下文封装起来的对象

什么是代理：
提供了统一Api的一些方法调用：


多线程：
GCD

spin_lock

亮点项目：
表情包，发射器的统一；
断点下载

离职原因：
大环境不太好。组织内部调整，没转正的都不给转正了


Event 驱动

主线程的runLoop，通过什么

消息队列都有

NSTimer ， UIEvent ,autorelease
delayedPerform, CADisplayLink


source 输入源
