//
//  EditAlarmController.m
//  AppleClock
//
//  Created by 杨春贵 on 2018/12/19.
//  Copyright © 2018 com.yangcg.learn.AppleClock. All rights reserved.
//

#import "EditAlarmController.h"
#import "AlarmDatePickerView.h"
#import "EditAlarmCell.h"
#import "AlarmInfoModel.h"
#import "EditAlarmCellModel.h"

@interface EditAlarmController ()<UITableViewDelegate, UITableViewDataSource, AlarmDatePickerViewDelegate>
@property (nonatomic, strong) AlarmDatePickerView *pickerView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSDate *alarmDate;
@property (nonatomic, strong) UIButton *deleteButton;
@property (nonatomic, strong) NSMutableArray<EditAlarmCellModel*> *cellModelArray;

@end

static NSString *cellId = @"EditAlarmCell";

@implementation EditAlarmController {
    NSString    *_alarmDateStr;     //时间
    NSString    *_explainStr;       //标签说明
    BOOL        _isAgain;           //是否稍后提醒
    NSMutableArray     *_repeatArray;      //重复日期
    
    BOOL        _isChange;  //是否是修改进入
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // 初始化默认数据
    self.alarmDate = [NSDate date];
    _explainStr = @"闹钟";
    _isAgain = YES;
}

- (void)createUI {
    // 根据indexPath判断是否是修改编辑
    _isChange = self.indexPath != nil;
    
    [self.view addSubview:self.pickerView];
    [self.view addSubview:self.tableView];
    self.deleteButton.hidden = !_isChange;;
}

- (IBAction)cancelButtonAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)saveButtonAction:(id)sender {
    AlarmInfoModel *model = [[AlarmInfoModel alloc] init];
    model.alarmDateStr = _alarmDateStr;
    model.explain = _explainStr;
    model.isOpen = YES;
    
    NSArray *array = [[NSUserDefaults standardUserDefaults] objectForKey:alarmInfoKey];
    NSMutableArray *dicArray = [NSMutableArray arrayWithArray:array];
    [dicArray addObject:model.toDictionary];
    [[NSUserDefaults standardUserDefaults] setObject:dicArray forKey:alarmInfoKey];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)deleteButtonAction {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark = setter
- (void)setAlarmDate:(NSDate *)alarmDate {
    _alarmDate = alarmDate;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    formatter.dateFormat = @"HH:mm";
    NSString *dateString = [formatter stringFromDate:alarmDate];
    _alarmDateStr = dateString;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    EditAlarmCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.isFirst = NO;
    cell.isLast = indexPath.row==3;
    cell.model = self.cellModelArray[indexPath.row];
    
//    cell.switchClick = ^(AlarmInfoModel *model) {
//        NSLog(@"点击了第%ld行", (long)indexPath.row);
//        NSLog(@"开关状态:%@", model.isOpen ? @"开" : @"关");
//        [self.modelArray replaceObjectAtIndex:indexPath.row withObject:model];
//    };
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

#pragma mark - UITableViewDelegate
// 点击cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark - AlarmDatePickerViewDelegate
- (void)datePickerResult:(NSDate *)alarmDate {
    self.alarmDate = alarmDate;
}


#pragma mark - Lazy
- (AlarmDatePickerView *)pickerView {
    if (!_pickerView) {
        _pickerView = [[AlarmDatePickerView alloc] initWithFrame:CGRectMake(0, kNavigationHEIGHT, kScreenWidth, 215)];
        _pickerView.delegate = self;
    }
    return _pickerView;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kNavigationHEIGHT+215, kScreenWidth, kScreenHeight-kNavigationHEIGHT-215)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = viewBgColor();
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.scrollEnabled = NO;
        [_tableView registerNib:[UINib nibWithNibName:cellId bundle:nil] forCellReuseIdentifier:cellId];
    }
    return _tableView;
}

- (UIButton *)deleteButton {
    if (!_deleteButton) {
        _deleteButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 44*5, kScreenWidth, 44)];
        [_deleteButton setTitle:@"删除" forState:UIControlStateNormal];
        [_deleteButton setTitleColor:redTextColor() forState:UIControlStateNormal];
        [_deleteButton setBackgroundColor:cellBgColor()];
        _deleteButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [_deleteButton addTarget:self action:@selector(deleteButtonAction) forControlEvents:UIControlEventTouchUpInside];
        _deleteButton.hidden = YES;
        [self.tableView addSubview:_deleteButton];
        
        //手动设置两条线
        UIView *topLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _deleteButton.frame.size.width, lineHeight)];
        topLine.backgroundColor = lineBgColor();
        [_deleteButton addSubview:topLine];
        
        UIView *bottomLine = [[UIView alloc] initWithFrame:CGRectMake(0, _deleteButton.frame.size.height-lineHeight, _deleteButton.frame.size.width, lineHeight)];
        bottomLine.backgroundColor = lineBgColor();
        [_deleteButton addSubview:bottomLine];
    }
    return _deleteButton;
}

- (NSMutableArray<EditAlarmCellModel *> *)cellModelArray {
    if (!_cellModelArray) {
        NSArray *titleArray = @[@"重复", @"标签", @"铃声", @"稍后提醒"];
        _cellModelArray = [NSMutableArray array];
        for (int i=0; i<4; i++) {
            EditAlarmCellModel *model = [[EditAlarmCellModel alloc] init];
            model.title = titleArray[i];
            [_cellModelArray addObject:model];
        }
    }
    return _cellModelArray;
}

@end
