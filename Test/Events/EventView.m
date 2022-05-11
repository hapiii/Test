//
//  EventView.m
//  Test
//
//  Created by 强王 on 2022/4/2.
//

#import "EventView.h"

@implementation EventView


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
        label.text = @"hello";
        [self addSubview:label];
    }
    return self;
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"view touchesBegan");
    /*
     实验结果:
     view 未实现touchBegin，会传递给 下层View--> controller 直到响应
     */
}


- (void)displayLayer:(CALayer *)layer {
    NSLog(@"这里异步绘制 子线程作位图生成");
    /*
     setContents
     */
    
}

- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx {
    
}



@end
