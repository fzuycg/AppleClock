//
//  WorldClockViewCell.m
//  YCGClock
//
//  Created by 杨春贵 on 2018/12/6.
//  Copyright © 2018 com.yangcg.learn.Clock. All rights reserved.
//

#import "WorldClockViewCell.h"

@interface WorldClockViewCell ()

@property (nonatomic, strong) UILabel *currentDateLabel;
@property (nonatomic, strong) UILabel *locationLabel;
@property (nonatomic, strong) UILabel *jetLagLabel;

@end

@implementation WorldClockViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createUI];
    }
    return self;
}

- (void)createUI {
    self.backgroundColor = [UIColor clearColor];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.currentDateLabel.frame = CGRectMake(self.frame.size.width-150-18, (self.frame.size.height-50)/2, 150, 50);
    self.jetLagLabel.frame = CGRectMake(18, (self.frame.size.height-30-14-2)/2, self.frame.size.width-18*2-150-2, 14);
    self.locationLabel.frame = CGRectMake(18, _jetLagLabel.frame.origin.y+_jetLagLabel.frame.size.height+2, self.frame.size.width-18*2-150-2, 30);
}

#pragma mark - setter
- (void)setDateString:(NSString *)dateString {
    _dateString = dateString;
    self.currentDateLabel.text = dateString;
}

- (void)setLocationString:(NSString *)locationString {
    _locationString = locationString;
    self.locationLabel.text = locationString;
}

- (void)setJetLagString:(NSString *)jetLagString {
    _jetLagString = jetLagString;
    self.jetLagLabel.text = jetLagString;
}

#pragma mark - Lazy
- (UILabel *)currentDateLabel {
    if (!_currentDateLabel) {
        _currentDateLabel = [[UILabel alloc] init];
        _currentDateLabel.font = [UIFont systemFontOfSize:50];
        [_currentDateLabel setTextColor:[UIColor whiteColor]];
        _currentDateLabel.textAlignment = NSTextAlignmentRight;
        [self addSubview:_currentDateLabel];
    }
    return _currentDateLabel;
}

- (UILabel *)jetLagLabel {
    if (!_jetLagLabel) {
        _jetLagLabel = [[UILabel alloc] init];
        _jetLagLabel.font = [UIFont systemFontOfSize:14];
        [_jetLagLabel setTextColor:[UIColor whiteColor]];
        [self addSubview:_jetLagLabel];
    }
    return _jetLagLabel;
}

- (UILabel *)locationLabel {
    if (!_locationLabel) {
        _locationLabel = [[UILabel alloc] init];
        _locationLabel.font = [UIFont systemFontOfSize:30];
        [_locationLabel setTextColor:[UIColor whiteColor]];
        [self addSubview:_locationLabel];
    }
    return _locationLabel;
}

@end
