//
//  WorldClockModel.h
//  AppleClock
//
//  Created by 杨春贵 on 2018/12/14.
//  Copyright © 2018 com.yangcg.learn.AppleClock. All rights reserved.
//

#import "Jastor.h"

NS_ASSUME_NONNULL_BEGIN

@interface WorldClockModel : Jastor
// 城市（拼音）
@property (nonatomic, strong) NSString *cityNamePY;
// 城市（英文）
@property (nonatomic, strong) NSString *cityNameEN;
// 城市
@property (nonatomic, strong) NSString *cityName;
// 国家
@property (nonatomic, strong) NSString *country;
// 时区
@property (nonatomic, assign) NSInteger timeZone;

#pragma mark - 处理过后的数据
// 时差（北京时间为基准）
//@property (nonatomic, assign) NSInteger jetLag;
// 当地时间
@property (nonatomic, strong) NSString *localDateStr;
// 对应的信息
@property (nonatomic, strong) NSString *dateInfoStr;

@end

NS_ASSUME_NONNULL_END
