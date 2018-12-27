//
//  EditAlarmController.h
//  AppleClock
//
//  Created by 杨春贵 on 2018/12/19.
//  Copyright © 2018 com.yangcg.learn.AppleClock. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN
@class AlarmInfoModel;

@interface EditAlarmController : BaseViewController
@property (nonatomic, strong) NSMutableArray<AlarmInfoModel*> *modelArray;
@property (nonatomic, strong) NSIndexPath *indexPath;

@end

NS_ASSUME_NONNULL_END
