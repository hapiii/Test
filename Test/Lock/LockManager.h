//
//  LockManager.h
//  Test
//
//  Created by wq on 2022/5/11.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LockManager : NSObject

- (void)addMoney:(NSInteger)count;

+ (void)lockHandle:(void(^)(void))handle;
@end

NS_ASSUME_NONNULL_END
