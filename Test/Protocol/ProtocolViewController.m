//
//  ProtocolViewController.m
//  Test
//
//  Created by 强王 on 2022/4/8.
//

#import "ProtocolViewController.h"
#import "ProtocolModel.h"

@interface ProtocolAView : UIView <ProtocolModel>

@end

@implementation ProtocolAView


//synthesize,合成变量
@synthesize name;

@end

@interface ProtocolViewController ()

@property (nonatomic, strong) ProtocolAView *v;
@end

@implementation ProtocolViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.v = [[ProtocolAView alloc] init];
    self.v.frame = CGRectMake(100, 100, 100, 100);
    self.v.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.v];
    // Do any additional setup after loading the view.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"%@",self.v.name);
    self.v.name = @"nihao1";
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
