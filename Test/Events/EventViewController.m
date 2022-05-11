//
//  EventViewController.m
//  Test
//
//  Created by 强王 on 2022/4/2.
//

#import "EventViewController.h"
#import "EventView.h"

@interface EventViewController ()

@property (nonatomic, strong) EventView *eView;
@end

@implementation EventViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.eView = [[EventView alloc] initWithFrame:CGRectMake(100, 100, 200, 200)];
    self.eView.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.eView];
    // Do any additional setup after loading the view.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"controller touchesBegan");
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
