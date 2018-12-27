//
//  EditAlarmCellModel.h
//  AppleClock
//
//  Created by 杨春贵 on 2018/12/26.
//  Copyright © 2018 com.yangcg.learn.AppleClock. All rights reserved.
//

#import "Jastor.h"

NS_ASSUME_NONNULL_BEGIN

@interface EditAlarmCellModel : Jastor
// 标题
@property (nonatomic, strong) NSString *title;
// 内容
@property (nonatomic, strong) NSString *contentStr;

// 稍后提醒
@property (nonatomic, assign) BOOL isAgain;
// 重复方式
@property (nonatomic, strong) NSMutableArray *repeatArray;
// 铃声
//@property (nonatomic, strong) NSString *ringName;

@end

NS_ASSUME_NONNULL_END
