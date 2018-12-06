//
//  WorldClockViewCell.h
//  YCGClock
//
//  Created by 杨春贵 on 2018/12/6.
//  Copyright © 2018 com.yangcg.learn.Clock. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WorldClockViewCell : UITableViewCell

@property (nonatomic, strong) NSString *dateString;
@property (nonatomic, strong) NSString *locationString;
@property (nonatomic, strong) NSString *jetLagString;

@end

NS_ASSUME_NONNULL_END
