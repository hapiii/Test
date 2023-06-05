//
//  NSString+add.m
//  Test
//
//  Created by wq on 2022/7/11.
//

#import "NSString+add.h"

@implementation NSString (add)

- (BOOL)isStringEmpty
{
    if (self == nil || [self length] == 0 || [self isEqualToString:@"null"])
    {
        return YES;
    }
    NSString* ts = [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if ([ts length] == 0)
    {
        return YES;
    }
    return NO;
}

@end
