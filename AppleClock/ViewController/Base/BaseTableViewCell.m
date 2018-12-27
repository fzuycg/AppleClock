//
//  BaseTableViewCell.m
//  AppleClock
//
//  Created by 杨春贵 on 2018/12/25.
//  Copyright © 2018 com.yangcg.learn.AppleClock. All rights reserved.
//

#import "BaseTableViewCell.h"

@interface BaseTableViewCell ()
@property (nonatomic, strong) UIView *topLine;
@property (nonatomic, strong) UIView *bottomLine;
@property (nonatomic, strong) UIView *lastBottomLine;

@end

@implementation BaseTableViewCell

- (void)layoutSubviews {
    [super layoutSubviews];
    self.backgroundColor = cellBgColor();
    
    self.topLine.frame = CGRectMake(0, 0, kScreenWidth, lineHeight);
    self.bottomLine.frame = CGRectMake(contentEdge, self.frame.size.height-0.5, kScreenWidth-contentEdge, lineHeight);
    self.lastBottomLine.frame = CGRectMake(0, self.frame.size.height-lineHeight, kScreenWidth, lineHeight);
    // 分割线
    self.topLine.hidden = !self.isFirst;
    self.bottomLine.hidden = self.isLast;
    self.lastBottomLine.hidden = !self.isLast;
}

#pragma mark - Lazy
- (UIView *)topLine {
    if (!_topLine) {
        _topLine = [[UIView alloc] initWithFrame:CGRectZero];
        _topLine.backgroundColor = lineBgColor();
        [self addSubview:_topLine];
        _topLine.hidden = YES;
    }
    return _topLine;
}

- (UIView *)bottomLine {
    if (!_bottomLine) {
        _bottomLine = [[UIView alloc] initWithFrame:CGRectZero];
        _bottomLine.backgroundColor = lineBgColor();
        [self.contentView addSubview:_bottomLine];
    }
    return _bottomLine;
}

- (UIView *)lastBottomLine {
    if (!_lastBottomLine) {
        _lastBottomLine = [[UIView alloc] initWithFrame:CGRectZero];
        _lastBottomLine.backgroundColor = lineBgColor();
        [self addSubview:_lastBottomLine];
    }
    return _lastBottomLine;
}

@end
