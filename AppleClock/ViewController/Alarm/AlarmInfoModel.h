//
//  AlarmInfoModel.h
//  AppleClock
//
//  Created by 杨春贵 on 2018/12/18.
//  Copyright © 2018 com.yangcg.learn.AppleClock. All rights reserved.
//

#import "Jastor.h"
#import "EditAlarmCellModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface AlarmInfoModel : Jastor
// 闹钟时间
@property (nonatomic, strong) NSString *alarmDateStr;
// 说明
@property (nonatomic, strong) NSString *explain;
// 是否开启
@property (nonatomic, assign) BOOL isOpen;
// 参数
@property (nonatomic, strong) NSMutableArray<EditAlarmCellModel*> *argumentModel;


#pragma mark - 处理过的数据(用于排序)
@property (nonatomic, assign) NSInteger alarmDateInt;

@end

NS_ASSUME_NONNULL_END
