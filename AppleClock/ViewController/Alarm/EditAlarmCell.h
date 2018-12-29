//
//  EditAlarmCell.h
//  AppleClock
//
//  Created by 杨春贵 on 2018/12/25.
//  Copyright © 2018 com.yangcg.learn.AppleClock. All rights reserved.
//

#import "BaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

typedef void (^SwitchClick) (NSDictionary *);

@interface EditAlarmCell : BaseTableViewCell

@property (nonatomic, strong) NSDictionary *dataDic;

@property(nonatomic, copy) SwitchClick switchClick;

@end

NS_ASSUME_NONNULL_END
