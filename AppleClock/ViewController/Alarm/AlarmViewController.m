//
//  AlarmViewController.m
//  AppleClock
//
//  Created by 杨春贵 on 2018/12/13.
//  Copyright © 2018 com.yangcg.learn.AppleClock. All rights reserved.
//

#import "AlarmViewController.h"
#import "UIColor+Addition.h"
#import "AlarmInfoModel.h"
#import "AlarmViewCell.h"
#import "EditAlarmController.h"

@interface AlarmViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIBarButtonItem *editButton;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray<AlarmInfoModel*> *modelArray;
@property (nonatomic, assign) BOOL isEditing;

@end

static NSString *cellId = @"AlarmViewCell";

@implementation AlarmViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self getAlarmInfoData];
    [self createUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self getAlarmInfoData];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    self.isEditing = NO;
    [self.tableView setEditing:NO animated:NO];
    
    // 在关闭页面的时候做数据存储
}

- (void)createUI {
    [self.view addSubview:self.tableView];
}

// 获取数据
- (void)getAlarmInfoData {
    [self.modelArray removeAllObjects];
    NSArray *infoArray = [[NSUserDefaults standardUserDefaults] objectForKey:alarmInfoKey];
    for (NSDictionary *dic in infoArray) {
        AlarmInfoModel *model = [[AlarmInfoModel alloc] initWithDictionary:dic];
        [self.modelArray addObject:model];
    }
    [self sortData];
    
    [self.tableView reloadData];
}

#pragma mark - Action
- (IBAction)editButtonAction:(id)sender {
    [self.tableView setEditing:!self.tableView.isEditing animated:YES];
    self.isEditing = self.tableView.isEditing;
}

#pragma mark - setter
- (void)setIsEditing:(BOOL)isEditing {
    _isEditing = isEditing;
    [self.editButton setTitle:isEditing ? @"完成" : @"编辑"];
    // 获取当前视图下的所有cell
    for (AlarmViewCell *cell in [self.tableView visibleCells]) {
        cell.isEditing = isEditing;
    }
    
    //编辑结束，存储数据
    if (!isEditing) {
        NSMutableArray *dicArray = [NSMutableArray array];
        for (AlarmInfoModel *model in self.modelArray) {
            [dicArray addObject:model.toDictionary];
        }
        
        [[NSUserDefaults standardUserDefaults] setObject:dicArray forKey:alarmInfoKey];
    }
}


#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.modelArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AlarmViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    cell.model = self.modelArray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.isEditing = self.isEditing;
    cell.isFirst = indexPath.row==0;
    cell.isLast = indexPath.row == self.modelArray.count-1;
    cell.switchClick = ^(AlarmInfoModel *model) {
        NSLog(@"点击了第%ld行", (long)indexPath.row);
        NSLog(@"开关状态:%@", model.isOpen ? @"开" : @"关");
        [self.modelArray replaceObjectAtIndex:indexPath.row withObject:model];
    };
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 95;
}

#pragma mark - UITableViewDelegate
// 点击cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.isEditing) {
        UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        EditAlarmController *vc = [story instantiateViewControllerWithIdentifier:@"EditAlarmVC"];
        vc.modelArray = self.modelArray;
        vc.indexPath = indexPath;
        
        UINavigationController *nav = [story instantiateViewControllerWithIdentifier:@"EditAlarmNav"];
        [nav addChildViewController:vc];
        [self presentViewController:nav animated:YES completion:nil];
    }
}

// 是否可以左滑操作
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

// 定义编辑样式
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}

// 开始编辑
- (void)tableView:(UITableView *)tableView willBeginEditingRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.editButton setTitle:@"完成"];
}

// 结束编辑
- (void)tableView:(UITableView *)tableView didEndEditingRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.editButton setTitle:@"编辑"];
}

// 进入编辑模式之后，点击进行操作
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.modelArray removeObjectAtIndex:indexPath.row];
    [self.tableView reloadData];
}

// 修改编辑按钮文字
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"删除";
}


// iOS11之后的新方法，可以设置image和title等，还自带动画效果
- (UISwipeActionsConfiguration *)tableView:(UITableView *)tableView trailingSwipeActionsConfigurationForRowAtIndexPath:(NSIndexPath *)indexPath  API_AVAILABLE(ios(11.0)){
    
    UIContextualAction *deleteAction = [UIContextualAction contextualActionWithStyle:UIContextualActionStyleDestructive title:@"删除" handler:^(UIContextualAction * _Nonnull action, __kindof UIView * _Nonnull sourceView, void (^ _Nonnull completionHandler)(BOOL)) {
        // 删除数据
        [self.modelArray removeObjectAtIndex:indexPath.row];
        
        completionHandler(YES);
        [self.tableView reloadData];
    }];
    
//    deleteAction.image = [UIImage imageNamed:@""];
//    deleteAction.backgroundColor = [UIColor redColor];
    
    UISwipeActionsConfiguration *config  = [UISwipeActionsConfiguration configurationWithActions:@[deleteAction]];
    return config;
}

#pragma mark - 对数据做排序
- (void)sortData {
//    NSLog(@"start = %@", self.modelArray);
    
    // 对数据根据时间进行排序
    NSArray<AlarmInfoModel*>* tempArr = [self.modelArray sortedArrayUsingComparator:^NSComparisonResult(AlarmInfoModel *obj1, AlarmInfoModel *obj2) {
        if(obj1.alarmDateInt < obj2.alarmDateInt){
            return NSOrderedAscending;
        }
        if(obj1.alarmDateInt > obj2.alarmDateInt){
            return NSOrderedDescending;
        }
        return NSOrderedSame;
    }];
    
    [self.modelArray removeAllObjects];
    [self.modelArray addObjectsFromArray:tempArr];
    
//    NSLog(@"end = %@", self.modelArray);
}


#pragma mark - Lazy
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor colorWithARGBString:@"#0d0d0d"];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerNib:[UINib nibWithNibName:cellId bundle:nil] forCellReuseIdentifier:cellId];
        _tableView.allowsSelectionDuringEditing = YES;//允许编辑模式支持点击
    }
    return _tableView;
}

- (NSMutableArray<AlarmInfoModel *> *)modelArray {
    if (!_modelArray) {
        _modelArray = [NSMutableArray array];
    }
    return _modelArray;
}

@end
