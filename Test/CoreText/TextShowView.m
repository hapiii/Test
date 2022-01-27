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
    
    
     
    CTLineRef line = CTLineCreateWithAttributedString(attrString);
     
    // Set text position and draw the line into the graphics context
    CGContextSetTextPosition(context, 0, 10);
    CTLineDraw(line, context);
    CFRelease(line);
    
    CFArrayRef lines = CTFrameGetLines(frame);
    CFArrayGetCount(lines);
    CTFrameGetLineOrigins(frame, CFRange, <#CGPoint * _Nonnull origins#>)

   
    
    // 在给定的frame绘制上下文
    CTFrameDraw(frame, context);
    
    CGColorSpaceRelease(rgbColorSpace);
    CFRelease(attrString);
    CFRelease(frame);
    CFRelease(path);
    CFRelease(framesetter);
    
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
