//
//  IndexViewController.m
//  Test
//
//  Created by 强王 on 2022/1/25.
//

#import "IndexViewController.h"

@interface IndexViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tb;
@property (nonatomic, strong) NSMutableArray <NSString *> *routers;
@end

@implementation IndexViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configUI];
   
}

- (void)configUI {
    
    UITableView *tb = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height * 2 / 3)];
    tb.delegate = self;
    tb.dataSource = self;
    [self.view addSubview:tb];
    self.tb = tb;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"1"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"1"];
    }
    cell.textLabel.text = self.routers[indexPath.row];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.routers.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Class className = NSClassFromString(self.routers[indexPath.row]);
    UIViewController *vc = [[className alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (NSMutableArray<NSString *> *)routers {
    if (!_routers) {
        _routers = @[@"TextViewController"].mutableCopy;
    }
    return _routers;
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    /*
     当 tb 数据源与cell行数不一致时，会报错
     
    self.routers = nil;
    [self.routers insertObject:@"123" atIndex:0];
    [self.tb insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
    [self.tb scrollsToTop];
     */
    
}

@end
