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
    [super touchesBegan:touches withEvent:event];
    NSLog(@"view touchesBegan %@", self.name);
    /*
     实验结果:
     view 未实现touchBegin，会传递给 下层View--> controller 直到响应
     面试题：
     1. VC 上放一个view。都实现touchesBegan，哪一个会响应？ 为什么.
     2. 把view 的 userInteractionEnabled 关掉呢?
     
     3. 如何让他们两个全部响应touchesBegan呢？
     在view内部调用 super touchesBegan
     内部会触发nextResponder touchBegan
     
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
