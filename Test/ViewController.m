//
//  ViewController.m
//  Test
//
//  Created by 强王 on 2022/1/21.
//

#import "ViewController.h"
#import "IndexViewController.h"
#import "AppDelegate.h"

@interface ViewController ()


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%@",self.view.backgroundColor);
    self.navigationBar.translucent = NO;
    IndexViewController *vc = [[IndexViewController alloc] init];
    [self pushViewController:vc animated:NO];
}

@end
