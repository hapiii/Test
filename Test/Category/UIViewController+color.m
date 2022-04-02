//
//  UIViewController+color.m
//  Test
//
//  Created by 强王 on 2022/3/31.
//

#import "UIViewController+color.h"
#import <objc/runtime.h>

@implementation UIViewController (color)

+ (void)load {
    Method m1 = class_getInstanceMethod(self, @selector(viewDidLoad));
    Method m2 = class_getInstanceMethod(self, @selector(wq_viewDidLoad));
    method_exchangeImplementations(m1, m2);
    
}

- (void)wq_viewDidLoad {
    [self wq_viewDidLoad];
    //self.view.backgroundColor = [UIColor whiteColor];
    
}

@end
