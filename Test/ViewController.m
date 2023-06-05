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
    self.view.backgroundColor = [UIColor whiteColor];
    NSLog(@"%@",self.view.backgroundColor);
    self.navigationBar.translucent = NO;
    IndexViewController *vc = [[IndexViewController alloc] init];
    [self pushViewController:vc animated:NO];
    
    NSLog(@"1");
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSLog(@"2");
        [self performSelector:@selector(loadBigImage) withObject:nil afterDelay:1];
        NSLog(@"3");
    });
    NSLog(@"4");
}

- (void)loadBigImage {
    NSLog(@"5");
}


@end
