//
//  WorldClockCell.m
//  AppleClock
//
//  Created by 杨春贵 on 2018/12/13.
//  Copyright © 2018 com.yangcg.learn.AppleClock. All rights reserved.
//

#import "WorldClockCell.h"
#import "WorldClockModel.h"

@interface WorldClockCell ()
@property (nonatomic, strong) UILabel *currentDateLabel;
@property (nonatomic, strong) UILabel *cityNameLabel;
@property (nonatomic, strong) UILabel *jetLagLabel;

@end

@implementation WorldClockCell

- (void)layoutSubviews {
    [super layoutSubviews];
        
    self.currentDateLabel.frame = CGRectMake(self.frame.size.width-150-contentEdge, (self.frame.size.height-46)/2, 150, 46);
    self.jetLagLabel.frame = CGRectMake(contentEdge, (self.frame.size.height-26-14-2)/2, self.frame.size.width-contentEdge*2-150-2, 14);
    self.cityNameLabel.frame = CGRectMake(contentEdge, CGRectGetMaxY(_jetLagLabel.frame)+2, self.frame.size.width-contentEdge*2-150-2, 26);
    
    // 对于还没有渲染的部分，滚动之后回再执行到这里
    self.currentDateLabel.hidden = self.isEditing;
}

#pragma mark - setter
- (void)setModel:(WorldClockModel *)model {
    _model = model;
    self.cityNameLabel.text = model.cityName;
    self.jetLagLabel.text = [NSString stringWithFormat:@"今天，%ld小时", (long)model.timeZone-8];
    self.currentDateLabel.text = model.localDate;
}

- (void)setIsEditing:(BOOL)isEditing {
    _isEditing = isEditing;
    self.currentDateLabel.hidden = isEditing;
}

#pragma mark - Lazy
- (UILabel *)currentDateLabel {
    if (!_currentDateLabel) {
        _currentDateLabel = [[UILabel alloc] init];
        _currentDateLabel.font = [UIFont systemFontOfSize:46];
        [_currentDateLabel setTextColor:whiteTextColor()];
        _currentDateLabel.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:_currentDateLabel];
    }
    return _currentDateLabel;
}

- (UILabel *)jetLagLabel {
    if (!_jetLagLabel) {
        _jetLagLabel = [[UILabel alloc] init];
        _jetLagLabel.font = [UIFont systemFontOfSize:14];
        [_jetLagLabel setTextColor:grayTextColor()];
        // 编辑模式下内容需要向右移动的需要把控件添加到cell的contentView上面
        [self.contentView addSubview:_jetLagLabel];
    }
    return _jetLagLabel;
}

- (UILabel *)cityNameLabel {
    if (!_cityNameLabel) {
        _cityNameLabel = [[UILabel alloc] init];
        _cityNameLabel.font = [UIFont systemFontOfSize:26];
        [_cityNameLabel setTextColor:whiteTextColor()];
        [self.contentView addSubview:_cityNameLabel];
    }
    return _cityNameLabel;
}

@end
