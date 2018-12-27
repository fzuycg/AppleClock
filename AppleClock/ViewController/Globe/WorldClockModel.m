//
//  WorldClockModel.m
//  AppleClock
//
//  Created by 杨春贵 on 2018/12/14.
//  Copyright © 2018 com.yangcg.learn.AppleClock. All rights reserved.
//

#import "WorldClockModel.h"

@implementation WorldClockModel

- (NSString *)localDate {
    NSDate *date = [NSDate date];
    // 根据零时区的秒数偏移量创建
    NSTimeZone *zone = [NSTimeZone timeZoneForSecondsFromGMT:3600*(_timeZone-8)];
    NSInteger interval = [zone secondsFromGMTForDate: date];
    
    NSDate *localeDate = [date  dateByAddingTimeInterval: interval];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];//创建一个日期格式化器
    dateFormatter.dateFormat = @"hh:mm";//指定转date得日期格式化形式
    _localDate = [dateFormatter stringFromDate:localeDate];
    return _localDate;
}

- (NSString *)dateInfo {
    
    
    return _dateInfo;
}

@end
