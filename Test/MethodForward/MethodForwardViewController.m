//
//  MethodForwardViewController.m
//  Test
//
//  Created by 强王 on 2022/3/31.
//

#import "MethodForwardViewController.h"
#import "MethodForwardTarget.h"

@interface MethodForwardViewController ()

@end

@implementation MethodForwardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    MethodForwardTarget *target = [[MethodForwardTarget alloc] init];
    [target test];
    // Do any additional setup after loading the view.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [ChildMethodForwardTarget testAction];
}

@end
