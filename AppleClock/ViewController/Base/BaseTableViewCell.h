//
//  BaseTableViewCell.h
//  AppleClock
//
//  Created by 杨春贵 on 2018/12/25.
//  Copyright © 2018 com.yangcg.learn.AppleClock. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseTableViewCell : UITableViewCell

@property (nonatomic, assign) BOOL isFirst;
@property (nonatomic, assign) BOOL isLast;

@end

NS_ASSUME_NONNULL_END
