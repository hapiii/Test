//
//  CategoryObject+AMethod.m
//  Test
//
//  Created by 强王 on 2022/3/30.
//
#import <Foundation/Foundation.h>
#import "CategoryObject+AMethod.h"
#import <objc/runtime.h>

@implementation CategoryObject (AMethod)

- (void)aMethod {
    NSLog(@"aMethod called");
}

- (NSString *)categoryProperty {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setCategoryProperty:(NSString *)categoryProperty {
    objc_setAssociatedObject(self, @selector(categoryProperty), categoryProperty, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
