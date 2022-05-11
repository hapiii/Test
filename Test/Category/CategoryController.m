//
//  CategoryController.m
//  Test
//
//  Created by 强王 on 2022/3/30.
//

#import "CategoryController.h"
#import "CategoryObject.h"
//#import "CategoryObject+AMethod.h"
@interface CategoryController ()

@end


@interface UIView ()
@property (nonatomic, strong) UIView *nodeView;
@end

@implementation CategoryController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.nodeView = [[UIView alloc] init];
    self.view.nodeView.frame = CGRectMake(0, 0, 200, 200);
    self.view.nodeView.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.view.nodeView];
    // Do any additional setup after loading the view.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    CategoryObject *obj = [[CategoryObject alloc] init];
    SEL selector = NSSelectorFromString(@"aMethod");
    [obj performSelector:selector];
    /*
      category
     不管有没有引入头文件，分类的方法都是可以被触发的
     */
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
