//
//  AlarmInfoModel.m
//  AppleClock
//
//  Created by 杨春贵 on 2018/12/18.
//  Copyright © 2018 com.yangcg.learn.AppleClock. All rights reserved.
//

#import "AlarmInfoModel.h"
#import "EditAlarmCellModel.h"

@implementation AlarmInfoModel

- (NSInteger)alarmDateInt {
    NSString *dateString = [self.alarmDateStr stringByReplacingOccurrencesOfString:@":" withString:@""];
    NSInteger dateInt = [dateString integerValue];
    return dateInt;
}

- (NSString *)explain {
    NSString *exStr = @"闹钟";
    NSArray *array = self.argumentDic[argumentDicKey];
    for (NSDictionary *dic in array) {
        EditAlarmCellModel *model = [[EditAlarmCellModel alloc] initWithDictionary:dic];
        if ([model.title isEqualToString:@"标签"]) {
            exStr = model.content;
        }
    }
    return exStr;
}

@end
