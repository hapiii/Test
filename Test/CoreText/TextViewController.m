//
//  TextViewController.m
//  Test
//
//  Created by 强王 on 2022/1/25.
//

#import "TextViewController.h"
#import "TextShowView.h"
#import <Masonry/Masonry.h>

@interface TextViewController ()

@end

@implementation TextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    TextShowView *show = [[TextShowView alloc] initWithFrame:CGRectMake(0, 100, 400, 300)];
    [self.view addSubview:show];
    
    UIView *view = UIView.new;
    view.backgroundColor = [UIColor purpleColor];
    //[self.view addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.equalTo(@(100));
    make.top.equalTo(@(100));
    make.width.equalTo(@(200));
    make.height.equalTo(@(100));
    }];
    
}

- (void)dealloc {
    NSLog(@"dealloc");
}


@end
