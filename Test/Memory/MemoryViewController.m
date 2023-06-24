//
//  MemoryViewController.m
//  Test
//
//  Created by wq on 2023/6/21.
//

#import "MemoryViewController.h"

@interface MemoryViewController ()

@property (nonatomic, copy) NSString *copTitle;
@property (nonatomic, strong) NSString *troTitle;

@end

@implementation MemoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    NSString *str = @"hello";
    NSMutableString *mstr = str.mutableCopy;
    
    self.copTitle = str;
    self.troTitle = mstr;
    //0x104dc1450 0x600003348630 0x104dc1450 0x600003348630
    NSLog(@"%p %p %p %p", str, mstr, self.copTitle, self.troTitle);
    NSLog(@"%@ %@ %@ %@", str, mstr, self.copTitle, self.troTitle);
    
    str = @"hello2";
    mstr = @"world".mutableCopy;
    
    
    NSLog(@"%p %p %p %p", str, mstr, self.copTitle, self.troTitle);
    NSLog(@"%@ %@ %@ %@", str, mstr, self.copTitle, self.troTitle);
    
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
