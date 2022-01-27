//
//  ViewController.m
//  Test
//
//  Created by 强王 on 2022/1/21.
//

#import "ViewController.h"
#import "IndexViewController.h"

@interface ViewController ()


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self pushViewController:[IndexViewController new] animated:NO];
}

@end
