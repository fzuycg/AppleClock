//
//  AddGlobeDateViewController.m
//  AppleClock
//
//  Created by 杨春贵 on 2019/2/21.
//  Copyright © 2019 com.yangcg.learn.AppleClock. All rights reserved.
//

#import "AddGlobeDateViewController.h"

@interface AddGlobeDateViewController ()
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation AddGlobeDateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (IBAction)cancelButtonAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - Lazy
- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 110, kScreenWidth, kScreenHeight-110)];
    }
    return _tableView;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
