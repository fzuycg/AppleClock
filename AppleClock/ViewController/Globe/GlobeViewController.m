//
//  GlobeViewController.m
//  AppleClock
//
//  Created by 杨春贵 on 2018/12/13.
//  Copyright © 2018 com.yangcg.learn.AppleClock. All rights reserved.
//

#import "GlobeViewController.h"
#import "WorldClockCell.h"
#import "WorldClockModel.h"

@interface GlobeViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIBarButtonItem *editButton;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray<WorldClockModel*> *dataArray;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) BOOL isEditing;

@end

static NSString *cellId = @"WorldClockCell";

@implementation GlobeViewController {
    NSString *_oldMinuteStr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self readPlist];
    [self createUI];
    [self buildTimer];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self.tableView setEditing:NO animated:NO];
    self.isEditing = NO;
}

- (void)readPlist {
    NSDictionary *dataDict = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"TimeZone" ofType:@"plist"]];
    NSArray *array = [NSArray arrayWithArray:dataDict[@"A"]];
    for (NSDictionary *dic in array) {
        WorldClockModel *model = [[WorldClockModel alloc] initWithDictionary:dic];
        [self.dataArray addObject:model];
    }
}

- (void)createUI {
    [self.view addSubview:self.tableView];
}

// 定时器
- (void)buildTimer {
    __weak typeof (self)weakSelf = self;
    if (@available(iOS 10.0, *)) {
        self.timer = [NSTimer timerWithTimeInterval:1.0 repeats:YES block:^(NSTimer * _Nonnull timer) {
            [weakSelf updateTime];
        }];
    } else {
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:weakSelf selector:@selector(updateTime) userInfo:nil repeats:YES];
    }
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

// 刷新页面时间
- (void)updateTime {
    NSDate *date = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];//创建一个日期格式化器
    dateFormatter.dateFormat = @"mm";//指定转date得日期格式化形式
    NSString *dateString = [dateFormatter stringFromDate:date];
    
    // 分钟变了才刷新
    if (![_oldMinuteStr isEqualToString:dateString]) {
        _oldMinuteStr = dateString;
        [self.tableView reloadData];
    }
}

#pragma mark - Action
- (IBAction)editButtonAction:(id)sender {
    [self.tableView setEditing:!self.tableView.isEditing animated:YES];
    self.isEditing = self.tableView.isEditing;
}

- (IBAction)addButtonAction:(id)sender {
    
}

#pragma mark - setter
- (void)setIsEditing:(BOOL)isEditing {
    _isEditing = isEditing;
    [self.editButton setTitle:isEditing ? @"完成" : @"编辑"];
    // 获取当前视图下的所有cell
    for (WorldClockCell *cell in [self.tableView visibleCells]) {
        cell.isEditing = isEditing;
    }
    
    // 编辑结束，持久化数据
    if (!isEditing) {
        
    }
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WorldClockCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    cell.model = self.dataArray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.isEditing = self.isEditing;//这里设置主要是针对未渲染的部分
    cell.isFirst = indexPath.row==0;
    cell.isLast = indexPath.row == self.dataArray.count-1;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 86;
}

#pragma mark - UITableViewDelegate
// 点击cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

// 是否可以移动
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

// 移动数据处理
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    //修改数据源
    [self.dataArray exchangeObjectAtIndex:sourceIndexPath.row withObjectAtIndex:destinationIndexPath.row];
    //让表视图对应的行进行移动
    [tableView exchangeSubviewAtIndex:sourceIndexPath.row withSubviewAtIndex:destinationIndexPath.row];
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
    [self.dataArray removeObjectAtIndex:indexPath.row];
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
        [self.dataArray removeObjectAtIndex:indexPath.row];
        
        completionHandler(YES);
        [self.tableView reloadData];
    }];
    
//    deleteAction.image = [UIImage imageNamed:@""];
//    deleteAction.backgroundColor = [UIColor redColor];
    
    UISwipeActionsConfiguration *config  = [UISwipeActionsConfiguration configurationWithActions:@[deleteAction]];
    return config;
}

#pragma mark - Lazy
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = viewBgColor();
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[WorldClockCell class] forCellReuseIdentifier:cellId];
    }
    return _tableView;
}

- (NSMutableArray<WorldClockModel *> *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

@end
