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
@property (nonatomic, strong) NSMutableArray *cellDataArray;

@end

static NSString *cellId = @"EditAlarmCell";

@implementation EditAlarmController {
    NSString    *_alarmDateStr;     //时间
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // 初始化默认时间
    self.alarmDate = [NSDate date];
    // 获取数据
    [self readData];
    // 创建界面
    [self createUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

- (void)createUI {
    [self.view addSubview:self.pickerView];
    [self.view addSubview:self.tableView];
    self.deleteButton.hidden = self.indexPath == nil;
    
    [self.pickerView setDefualtDate:self.alarmDate];
}

- (void)readData {
    if (self.indexPath) {
        AlarmInfoModel *infoModel = self.modelArray[self.indexPath.row];
        NSArray *array = infoModel.argumentDic[argumentDicKey];
        [self.cellDataArray removeAllObjects];
        [self.cellDataArray addObjectsFromArray:array];
        
        self.alarmDate = [self stringConversionNSDate:infoModel.alarmDateStr];
    }
}

/**
 时间字符串转NSDate
 */
- (NSDate *)stringConversionNSDate:(NSString *)dateStr {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH:mm"];
    NSDate *datestr = [dateFormatter dateFromString:dateStr];
    return datestr;
}

- (IBAction)cancelButtonAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)saveButtonAction:(id)sender {
    AlarmInfoModel *model = [[AlarmInfoModel alloc] init];
    model.alarmDateStr = _alarmDateStr;
    model.isOpen = YES;
    model.argumentDic = @{argumentDicKey: self.cellDataArray};
    
    if (self.indexPath) {
        [self.modelArray replaceObjectAtIndex:self.indexPath.row withObject:model];
    }else{
        [self.modelArray addObject:model];
    }
    
    [self saveDataForCache];
}

- (void)deleteButtonAction {
    [self.modelArray removeObjectAtIndex:self.indexPath.row];
    [self saveDataForCache];
}

/**
 保存数据到缓存并退出界面
 */
- (void)saveDataForCache {
    NSMutableArray *dicArray = [NSMutableArray array];
    for (AlarmInfoModel *model in self.modelArray) {
        [dicArray addObject:model.toDictionary];
    }
    [[NSUserDefaults standardUserDefaults] setObject:dicArray forKey:alarmInfoKey];
    
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
    NSDictionary *dic = self.cellDataArray[indexPath.row];
    cell.dataDic = dic;
    
    if (indexPath.row==3) {
        cell.switchClick = ^(NSDictionary *dic) {
            NSLog(@"开关状态：%@", dic[@"content"]);
            [self.cellDataArray replaceObjectAtIndex:indexPath.row withObject:dic];
        };
    }
    
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

- (NSMutableArray *)cellDataArray {
    if (!_cellDataArray) {
        NSArray *titleArray = @[@"重复", @"标签", @"铃声", @"稍后提醒"];
        NSArray *contentArray = @[@"从不", @"闹钟", @"默认", @"1"];
        _cellDataArray = [NSMutableArray array];
        for (int i=0; i<4; i++) {
            NSDictionary *dic = @{
                                  @"title": titleArray[i],
                                  @"content": contentArray[i]
                                  };
            [_cellDataArray addObject:dic];
        }
    }
    return _cellDataArray;
}

- (NSMutableArray<AlarmInfoModel *> *)modelArray {
    if (!_modelArray) {
        _modelArray = [NSMutableArray array];
    }
    return _modelArray;
}

@end
