#import <UIKit/UIKit.h>


@protocol IndexedTableViewDataSource <NSObject>

// 获取一个tableview的字母索引条数据的方法
- (NSArray <NSString *> *)indexTitlesForIndexTableView:(UITableView *)tableView;

@end

@interface IndexedTableView : UITableView

@property (nonatomic, weak) id <IndexedTableViewDataSource> indexedDataSource;

@end
