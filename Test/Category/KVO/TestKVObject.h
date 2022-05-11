//
//  TestKVObject.h
//  Test
//
//  Created by 强王 on 2022/3/30.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TestKVObject : NSObject

@property (nonatomic, copy) NSString *testString;

@property (nonatomic, assign) NSInteger numberValue;
- (void)change;

+ (void)sayHello;
@end

NS_ASSUME_NONNULL_END
