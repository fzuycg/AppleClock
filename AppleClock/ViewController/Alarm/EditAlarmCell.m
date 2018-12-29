//
//  EditAlarmCell.m
//  AppleClock
//
//  Created by 杨春贵 on 2018/12/25.
//  Copyright © 2018 com.yangcg.learn.AppleClock. All rights reserved.
//

#import "EditAlarmCell.h"
#import "EditAlarmCellModel.h"

@interface EditAlarmCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIImageView *moreImageView;
@property (weak, nonatomic) IBOutlet UISwitch *againSwitch;

@end

@implementation EditAlarmCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)againSwitchAction:(id)sender {
    NSMutableDictionary *myDic = [NSMutableDictionary dictionary];
    [myDic setDictionary:self.dataDic];
    
    [myDic setValue:self.againSwitch.on ? @"1" : @"0" forKey:@"content"];
    
    if (self.switchClick) {
        self.switchClick(myDic);
    }
}

#pragma mark - setter
- (void)setDataDic:(NSDictionary *)dataDic {
    _dataDic = dataDic;
    EditAlarmCellModel *model = [[EditAlarmCellModel alloc] initWithDictionary:dataDic];
    self.titleLabel.text = model.title;
    BOOL isLast = [model.title isEqualToString:@"稍后提醒"];
    self.contentLabel.hidden = isLast;
    self.moreImageView.hidden = isLast;
    self.againSwitch.hidden = !isLast;
    
    self.contentLabel.text = model.content;
    self.againSwitch.on = model.isAgain;
}

@end
