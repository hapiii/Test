//
//  MethodForwardTarget.h
//  Test
//
//  Created by 强王 on 2022/3/31.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MethodForwardTarget : NSObject

- (void)test;
- (void)otherTest;

+ (void)logTest;

@end


@interface ChildMethodForwardTarget : MethodForwardTarget

+ (void)testAction;

@end

NS_ASSUME_NONNULL_END
