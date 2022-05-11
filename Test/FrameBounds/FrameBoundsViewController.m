//
//  FrameBoundsViewController.m
//  Test
//
//  Created by 强王 on 2022/4/7.
//

#import "FrameBoundsViewController.h"

@interface FrameBoundsViewController ()

@property (nonatomic, strong) UIView *aView;
@property (nonatomic, strong) UIView *bView;

@end

@implementation FrameBoundsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.aView = [[UIView alloc] init];
    self.aView.frame = CGRectMake(100, 100, 100, 100);
    self.aView.backgroundColor = [UIColor redColor];
    
    self.bView = [[UIView alloc] init];
    self.bView.frame = CGRectMake(50, 50, 50, 50);
    self.bView.backgroundColor = [UIColor purpleColor];
    
    [self.view addSubview:self.aView];
    [self.aView addSubview:self.bView];
    
     
    // Do any additional setup after loading the view.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    self.aView.bounds = CGRectMake(self.aView.bounds.origin.x + 10, 0, self.aView.bounds.size.width, self.aView.bounds.size.height);
    NSLog(@"ddd");
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
