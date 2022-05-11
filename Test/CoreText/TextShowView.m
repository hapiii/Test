//
//  TextShowView.m
//  Test
//
//  Created by 强王 on 2022/1/25.
//

#import "TextShowView.h"
#import <CoreText/CoreText.h>

@implementation TextShowView

- (void)drawRect:(CGRect)rect {
    // 1.获取绘制上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // 2.翻转坐标系 对于底层绘制引擎来说左下角是（0，0），对于上层UIKit来说左上是（0，0）点
    CGContextTranslateCTM(context, 0, self.bounds.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
    
    // 3.创建矩形的路径 指定文字的绘制范围
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, self.bounds);
    
    
    CFStringRef textString = CFSTR("Hello, World! I know nothing in the world that has as much power as a word. Sometimes I write one, and I look at it, until it begins to shine.");
    //创建一个最大长度为0的可变属性字符串
    CFMutableAttributedStringRef attrString =
    CFAttributedStringCreateMutable(kCFAllocatorDefault, 0);
    // 将textString复制到新创建的attrString中
    CFAttributedStringReplaceString (attrString, CFRangeMake(0, 0),
                                     textString);
    
    // 占位符代理回调
    CTRunDelegateCallbacks callBacks;
    memset(&callBacks,0,sizeof(CTRunDelegateCallbacks));
    callBacks.version = kCTRunDelegateCurrentVersion;
    callBacks.getAscent = ascentCallBacks;
    callBacks.getDescent = descentCallBacks;
    callBacks.getWidth = widthCallBacks;
    
    
    /// 插入富文本
    NSDictionary *info = @{@"w":@130, @"h":@50};
    CTRunDelegateRef delegate = CTRunDelegateCreate(& callBacks, (__bridge void *)info);
    unichar placeHolder = 0xFFFC;
    NSString * placeHolderStr = [NSString stringWithCharacters:&placeHolder length:1];
    NSMutableAttributedString * placeHolderAttrStr = [[NSMutableAttributedString alloc] initWithString:placeHolderStr];
    CFAttributedStringSetAttribute((CFMutableAttributedStringRef)placeHolderAttrStr, CFRangeMake(0, 1), kCTRunDelegateAttributeName, delegate);
    CFRelease(delegate);
    [(__bridge NSMutableAttributedString *)attrString insertAttributedString:placeHolderAttrStr atIndex:2];
    
    
    
    // 创建一个将添加到attrString的颜色属性。
    CGColorSpaceRef rgbColorSpace = CGColorSpaceCreateDeviceRGB();
    CGFloat components[] = { 1.0, 0.0, 0.0, 0.8 };
    CGColorRef red = CGColorCreate(rgbColorSpace, components);
    
    
    // 将前12个字符的颜色设置为红色.
    CFAttributedStringSetAttribute(attrString, CFRangeMake(0, CFStringGetLength(textString)),
                                   kCTForegroundColorAttributeName, red);
    
    
    
    // 使用属性字符串创建framesetter。
    CTFramesetterRef framesetter =
    CTFramesetterCreateWithAttributedString(attrString);
    
    // 创建一个frame
    CTFrameRef frame = CTFramesetterCreateFrame(framesetter,
                                                CFRangeMake(0, 0), path, NULL);
    
    
    /*
    CTLineRef line = CTLineCreateWithAttributedString(attrString);
    CGContextSetTextPosition(context, 0, 10);
    CTLineDraw(line, context);
    CFRelease(line);
    */
    NSInteger numberOfLines = 1;
    CFArrayRef lines = CTFrameGetLines(frame);
    CFIndex lineCount = CFArrayGetCount(lines);
    
    // 绘制图片
    CGPoint origins[lineCount];
    CTFrameGetLineOrigins(frame, CFRangeMake(0, 0), origins);
    
    for (int i = 0; i < lineCount; i++) {
        CTLineRef lineRef = CFArrayGetValueAtIndex(lines, i);
        CFArrayRef runs = CTLineGetGlyphRuns(lineRef);
        CFIndex runCount = CFArrayGetCount(runs);
        for (int j = 0; j < runCount; j++) {
            CTRunRef runRef = CFArrayGetValueAtIndex(runs, j);
            NSDictionary *attributes = (id)CTRunGetAttributes(runRef);
            if (!attributes) {
                continue;
            }
            // 附件
            CTRunDelegateRef delegateRef = (__bridge CTRunDelegateRef)[attributes valueForKey:(id)kCTRunDelegateAttributeName];
            if (delegateRef) {
                CGPoint origin = origins[i];
                id info = (id)CTRunDelegateGetRefCon(delegateRef);
                if ([info isKindOfClass:[NSDictionary class]]) {
                    CGFloat w = [info[@"w"] doubleValue];
                    CGFloat h = [info[@"h"] doubleValue];
                    CGFloat offset_x = CTLineGetOffsetForStringIndex(lineRef, CTRunGetStringRange(runRef).location, NULL);
                    UIImage *image = [UIImage imageNamed:@"1"];
                    if (image) {
                        CGRect drawRect = CGRectMake(origin.x + offset_x, origin.y, w, h);
                        CGContextDrawImage(context, drawRect, image.CGImage);
                    } else {
                        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
                        [button setBackgroundColor:[UIColor redColor]];
                        [button setTitle:@"我是按钮" forState:UIControlStateNormal];
                        button.frame = CGRectMake(origin.x + offset_x, rect.size.height - origin.y - h, w, h);
                        [self addSubview:button];
                    }
                }
            }
        }
    }
    
    
    
    NSInteger count = numberOfLines == 0 ? lineCount : numberOfLines;
       if (count > lineCount) count = lineCount;
    // 判断是否需要展示截断符，小于总行数都需要展示截断符。
    BOOL needShowTruncation = count < lineCount;
    
    for (int i = 0; i < count; i++) {
           CTLineRef lineRef = CFArrayGetValueAtIndex(lines, i);
           CFRange range = CTLineGetStringRange(lineRef);
           CGPoint origin = origins[i];
           // 一旦我们通过CTLineDraw绘制文字后，那么需要我们自己来设置行的位置，否则都位于最底下显示。
           CGContextSetTextPosition(context, origin.x, origin.y);
           
           if (i == 0 && needShowTruncation) {
               NSMutableAttributedString *drawLineString = [[NSMutableAttributedString alloc] initWithAttributedString:[(__bridge  NSMutableAttributedString *)attrString attributedSubstringFromRange:NSMakeRange(range.location, range.length)]];
               
               NSAttributedString *truncationTokenText = [[NSAttributedString alloc] initWithString:@"...点我展开" attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15], NSForegroundColorAttributeName: [UIColor brownColor]}];
               // 这两行可以控制截断符的位置是在开头，还是在中间，还是在结尾
               CTLineTruncationType type = kCTLineTruncationMiddle;
               [drawLineString appendAttributedString:truncationTokenText];
               
               CTLineRef drawLineRef = CTLineCreateWithAttributedString((__bridge CFAttributedStringRef)drawLineString);
               CTLineRef tokenLineRef = CTLineCreateWithAttributedString((__bridge CFAttributedStringRef)truncationTokenText);
               // 创建带有截断符的行
               CTLineRef truncationLineRef = CTLineCreateTruncatedLine(drawLineRef, rect.size.width, type, tokenLineRef);
               CFRelease(drawLineRef);
               CFRelease(tokenLineRef);
               // 绘制
               CTLineDraw(truncationLineRef, context);
           } else {
               CTLineDraw(lineRef, context);
           }
       }

    // 在给定的frame绘制上下文
    //CTFrameDraw(frame, context);
    
    CGColorSpaceRelease(rgbColorSpace);
    CFRelease(attrString);
    CFRelease(frame);
    CFRelease(path);
    CFRelease(framesetter);
    
}

static CGFloat ascentCallBacks(void * ref)
{
    return [(NSNumber *)[(__bridge NSDictionary *)ref valueForKey:@"h"] floatValue];
}
static CGFloat descentCallBacks(void * ref)
{
    return 0;
}
static CGFloat widthCallBacks(void * ref)
{
    return [(NSNumber *)[(__bridge NSDictionary *)ref valueForKey:@"w"] floatValue];
}



/*
 NSDictionary *fontAttributes =
 [NSDictionary dictionaryWithObjectsAndKeys:
 @"Courier", (NSString *)kCTFontFamilyNameAttribute,
 @"Bold", (NSString *)kCTFontStyleNameAttribute,
 [NSNumber numberWithFloat:31.0],
 (NSString *)kCTFontSizeAttribute,
 nil];
 
 CFStringRef string;
 CTFontDescriptorRef descriptor =
 CTFontDescriptorCreateWithAttributes((CFDictionaryRef)fontAttributes);
 CTFontRef font = CTFontCreateWithFontDescriptor(descriptor, 0.0, NULL);
 
 CFStringRef keys[] = { kCTFontAttributeName };
 CFTypeRef values[] = { font };
 
 CFDictionaryRef attributes =
 CFDictionaryCreate(kCFAllocatorDefault, (const void**)&keys,
 (const void**)&values, sizeof(keys) / sizeof(keys[0]),
 &kCFTypeDictionaryKeyCallBacks,
 &kCFTypeDictionaryValueCallBacks);
 
 
 CFRelease(string);
 CFRelease(attributes);
 */

@end
