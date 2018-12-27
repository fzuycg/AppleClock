//
//  EditAlarmCell.h
//  AppleClock
//
//  Created by 杨春贵 on 2018/12/25.
//  Copyright © 2018 com.yangcg.learn.AppleClock. All rights reserved.
//

#import "BaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN
@class EditAlarmCellModel;

@interface EditAlarmCell : BaseTableViewCell
@property (nonatomic, strong) EditAlarmCellModel *model;

@end

NS_ASSUME_NONNULL_END
