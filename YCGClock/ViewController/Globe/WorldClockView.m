//
//  WorldClockView.m
//  YCGClock
//
//  Created by 杨春贵 on 2018/12/3.
//  Copyright © 2018 com.yangcg.learn.Clock. All rights reserved.
//

#import "WorldClockView.h"
#import "WorldClockViewCell.h"

@interface WorldClockView () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

static NSString *cellId = @"WorldClockViewCell";

@implementation WorldClockView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self createUI];
    }
    return self;
}

- (void)createUI {
    [self addSubview:self.tableView];
    
    [self.tableView registerClass:[WorldClockViewCell class] forCellReuseIdentifier:cellId];
}

#pragma mark - UITableViewDelegate && UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WorldClockViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    cell.dateString = @"12:00";
    cell.locationString = @"北京";
    cell.jetLagString = @"今天，+0小时";
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 85;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}


#pragma mark - Lazy

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.bounds];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor blackColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

@end
