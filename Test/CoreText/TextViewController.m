//
//  TextViewController.m
//  Test
//
//  Created by 强王 on 2022/1/25.
//

#import "TextViewController.h"
#import "TextShowView.h"

@interface TextViewController ()

@end

@implementation TextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    TextShowView *show = [[TextShowView alloc] initWithFrame:CGRectMake(0, 100, 400, 300)];
    [self.view addSubview:show];
}



@end
