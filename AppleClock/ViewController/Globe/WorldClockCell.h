//
//  WorldClockCell.h
//  AppleClock
//
//  Created by 杨春贵 on 2018/12/13.
//  Copyright © 2018 com.yangcg.learn.AppleClock. All rights reserved.
//

#import "BaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN
@class WorldClockModel;

@interface WorldClockCell : BaseTableViewCell

@property (nonatomic, strong) WorldClockModel *model;

@property (nonatomic, assign) BOOL isEditing;

@end

NS_ASSUME_NONNULL_END
