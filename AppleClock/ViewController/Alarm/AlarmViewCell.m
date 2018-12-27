//
//  AlarmViewCell.m
//  AppleClock
//
//  Created by 杨春贵 on 2018/12/18.
//  Copyright © 2018 com.yangcg.learn.AppleClock. All rights reserved.
//

#import "AlarmViewCell.h"
#import "AlarmInfoModel.h"

@interface AlarmViewCell ()
@property (weak, nonatomic) IBOutlet UISwitch *switchButton;
@property (weak, nonatomic) IBOutlet UIImageView *alarmMoreImageView;
@property (weak, nonatomic) IBOutlet UILabel *alarmDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *explainLabel;

@end

@implementation AlarmViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.backgroundColor = cellBgColor();
}

- (IBAction)switchButtonAction:(id)sender {
    self.model.isOpen = self.switchButton.on;
    if (self.switchClick) {
        self.switchClick(self.model);
    }
    [self changeTextColorStr:self.model.isOpen ? whiteTextColor() : grayTextColor()];
}

- (void)changeTextColorStr:(UIColor *)color {
    [self.alarmDateLabel setTextColor:color];
    [self.explainLabel setTextColor:color];
}

#pragma mark - setter
- (void)setModel:(AlarmInfoModel *)model {
    _model = model;
    self.switchButton.on = model.isOpen;
    self.alarmDateLabel.text = model.alarmDateStr;
    self.explainLabel.text = model.explain;
    
    [self changeTextColorStr:model.isOpen ? whiteTextColor() : grayTextColor()];
}


- (void)setIsEditing:(BOOL)isEditing {
    _isEditing = isEditing;
    self.switchButton.hidden = isEditing;
    self.alarmMoreImageView.hidden = !isEditing;
}
@end
