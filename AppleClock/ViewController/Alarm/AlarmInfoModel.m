//
//  AlarmInfoModel.m
//  AppleClock
//
//  Created by 杨春贵 on 2018/12/18.
//  Copyright © 2018 com.yangcg.learn.AppleClock. All rights reserved.
//

#import "AlarmInfoModel.h"

@implementation AlarmInfoModel

- (NSInteger)alarmDateInt {
    NSString *dateString = [self.alarmDateStr stringByReplacingOccurrencesOfString:@":" withString:@""];
    NSInteger dateInt = [dateString integerValue];
    return dateInt;
}

- (NSString *)explain {
    NSString *exStr = @"闹钟";
    for (EditAlarmCellModel *model in self.argumentModel) {
        if ([model.title isEqualToString:@"标签"]) {
            exStr = model.contentStr;
        }
    }
    return exStr;
}

@end
