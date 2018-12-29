//
//  EditAlarmCellModel.m
//  AppleClock
//
//  Created by 杨春贵 on 2018/12/26.
//  Copyright © 2018 com.yangcg.learn.AppleClock. All rights reserved.
//

#import "EditAlarmCellModel.h"

@implementation EditAlarmCellModel

- (BOOL)isAgain {
    if ([self.title isEqualToString:@"稍后提醒"]) {
        NSInteger i = [self.content integerValue];
        if (i == 1) {
            return YES;
        }
    }
    return NO;
}

- (NSString *)content {
    if ([_title isEqualToString:@"重复"]) {
        NSString *conStr = @"永不";
        NSMutableString *mutStr = nil;
        NSString *startStr = @"周";
        
        if (_repeatArray.count==1) {
            startStr = @"每周";
        }
        
        for (NSString *num in _repeatArray) {
            [mutStr appendString:[NSString stringWithFormat:@" %@%@", startStr, [self zhFromNum:num]]];
        }
        if (_repeatArray.count>0) {
            conStr = mutStr;
        }
        return conStr;
    }
    return _content;
}

- (NSString *)zhFromNum:(NSString *)num {
    NSString *resultStr = @"";
    switch ([num integerValue]) {
        case 0:
            resultStr = @"日";
            break;
        case 1:
            resultStr = @"一";
            break;
        case 2:
            resultStr = @"二";
            break;
        case 3:
            resultStr = @"三";
            break;
        case 4:
            resultStr = @"四";
            break;
        case 5:
            resultStr = @"五";
            break;
        case 6:
            resultStr = @"六";
            break;
        default:
            resultStr = @"一";
            break;
    }
    return resultStr;
}

@end
