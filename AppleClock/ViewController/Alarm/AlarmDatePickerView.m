//
//  AlarmDatePickerView.m
//  AppleClock
//
//  Created by 杨春贵 on 2018/12/20.
//  Copyright © 2018 com.yangcg.learn.AppleClock. All rights reserved.
//

#import "AlarmDatePickerView.h"


@interface AlarmDatePickerView () <UITextFieldDelegate>
@property (nonatomic, strong) UIDatePicker *datePicker;

@end

@implementation AlarmDatePickerView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self createUI];
    }
    return self;
}

- (void)createUI {
    self.backgroundColor = [UIColor clearColor];
    self.clipsToBounds = YES;
    [self addSubview:self.datePicker];
    
    UIView *topLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, lineHeight)];
    topLine.backgroundColor = lineBgColor();
    [self addSubview:topLine];
    
    UIView *bottomLine = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height-lineHeight, self.frame.size.width, lineHeight)];
    bottomLine.backgroundColor = lineBgColor();
    [self addSubview:bottomLine];
}


#pragma mark - 时间选择器选择结束
- (void)dataPickerChanged:(UIDatePicker *)datePicker {
    if (self.delegate && [self.delegate respondsToSelector:@selector(datePickerResult:)]) {
        [self.delegate datePickerResult:datePicker.date];
    }
}

#pragma mark - Lazy
- (UIDatePicker *)datePicker {
    if (!_datePicker) {
        _datePicker = [[UIDatePicker alloc] init];
        _datePicker.frame = self.bounds;
        _datePicker.backgroundColor = viewBgColor();
        [_datePicker setValue:whiteTextColor() forKey:@"textColor"];
        _datePicker.locale = [NSLocale localeWithLocaleIdentifier:@"en_GB"];
        //24小时制
        _datePicker.datePickerMode = UIDatePickerModeTime;
        //监听变化
        [_datePicker addTarget:self action:@selector(dataPickerChanged:) forControlEvents:UIControlEventValueChanged];
        
        //手动设置两条线
        UIView *topLine = [[UIView alloc] initWithFrame:CGRectMake(0, (_datePicker.frame.size.height-35)/2, _datePicker.frame.size.width, lineHeight)];
        topLine.backgroundColor = lineBgColor();
        [_datePicker addSubview:topLine];
        
        UIView *bottomLine = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(topLine.frame)+34, self.frame.size.width, lineHeight)];
        bottomLine.backgroundColor = lineBgColor();
        [_datePicker addSubview:bottomLine];
    }
    return _datePicker;
}


@end
