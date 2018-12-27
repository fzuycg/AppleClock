//
//  AlarmViewCell.h
//  AppleClock
//
//  Created by 杨春贵 on 2018/12/18.
//  Copyright © 2018 com.yangcg.learn.AppleClock. All rights reserved.
//

#import "BaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@class AlarmInfoModel;

typedef void (^SwitchClick) (AlarmInfoModel *);

@interface AlarmViewCell : BaseTableViewCell

@property (nonatomic, strong) AlarmInfoModel *model;

@property (nonatomic, assign) BOOL isEditing;

@property(nonatomic, copy) SwitchClick switchClick;

@end

NS_ASSUME_NONNULL_END
