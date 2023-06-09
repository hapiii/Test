//
//  EventViewController.m
//  Test
//
//  Created by 强王 on 2022/4/2.
//

#import "EventViewController.h"
#import "EventView.h"
#import "TestObject.h"
@interface EventViewController ()

@property (nonatomic, strong) EventView *eView;
@end

@implementation EventViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.eView = [[EventView alloc] initWithFrame:CGRectMake(0, 0, 300, 300)];
    self.eView.name = @"A";
    self.eView.backgroundColor = [UIColor redColor];
    //self.eView.userInteractionEnabled = NO;
    [self.view addSubview:self.eView];
    
    EventView *bView = [[EventView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    bView.name = @"B";
    bView.backgroundColor = [UIColor greenColor];
    //self.eView.userInteractionEnabled = NO;
    [self.eView addSubview:bView];
    
    UIView *cView = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 200, 200)];
    //cView.name = @"C";
    cView.backgroundColor = [UIColor blueColor];
    //self.eView.userInteractionEnabled = NO;
    [self.eView addSubview:cView];
    
    
    // Do any additional setup after loading the view.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"controller touchesBegan");
    //[TestObject  test];
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
