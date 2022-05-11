//
//  TestKVOViewController.m
//  Test
//
//  Created by 强王 on 2022/3/30.
//

#import "TestKVOViewController.h"
#import "TestKVObject.h"

@interface TestKVOViewController ()

@property (nonatomic, strong) TestKVObject *kvoBject;
@end

@implementation TestKVOViewController

- (void)viewDidLoad {
    Class cl = self.class;
    [super viewDidLoad];
    self.kvoBject = [[TestKVObject alloc] init];
   
    self.kvoBject.testString = @"你好";
    NSArray<TestKVObject *> *arr = @[self.kvoBject];
    NSArray<TestKVObject *> *arr2 = arr.copy;
    arr2.firstObject.testString = @"hello";
    NSMutableArray<TestKVObject *> *arr3 = arr.mutableCopy;
    arr3.firstObject.testString = @"world";
    
    NSLog(@"%@-%@-%@",self.kvoBject.testString, arr2.firstObject.testString, arr3.firstObject.testString);
    
    [self.kvoBject addObserver:self forKeyPath:@"numberValue" options:NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew context:nil];
    // Do any additional setup after loading the view.
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"testString"]) {
        NSLog(@"value change%@",object);
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"%s",object_getClassName(self.kvoBject));
    NSString *str = [NSString stringWithFormat:@"%@+=1",self.kvoBject.testString];
    //[self.kvoBject setValue:str forKey:@"testString"];
    [self.kvoBject change];
    NSLog(@"%s",object_getClassName(self.kvoBject));
    
    [TestKVObject sayHello];
    /*
     po self.kvoBject.class TestKVObject
     object_getClassName(self.kvoBject)  NSKVONotifying_TestKVObject
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
