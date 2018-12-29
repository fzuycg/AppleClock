//
//  StopwatchViewController.m
//  AppleClock
//
//  Created by 杨春贵 on 2018/12/13.
//  Copyright © 2018 com.yangcg.learn.AppleClock. All rights reserved.
//

#import "StopwatchViewController.h"
#import "Reachability.h"

@interface StopwatchViewController ()

@end

@implementation StopwatchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // Reachability使用了通知，当网络状态发生变化时发送通知kReachabilityChangedNotification
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(appReachabilityChanged:)
                                                 name:kReachabilityChangedNotification
                                               object:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    int i = [self getNetStatus];
    if (i==2) {
        NSLog(@"蜂窝数据");
    }else if (i == 1){
        NSLog(@"WIFI");
    }else{
        NSLog(@"其他");
    }
}

- (int)getNetStatus {
    
    
    
    NSString *stateString = nil;
    int netStatusNumber = 0;
    switch ([[Reachability reachabilityForInternetConnection] currentReachabilityStatus]) {
            
        case NotReachable: {
            
            stateString = @"无网络";
            netStatusNumber = 0;
        }
            break;
        case ReachableViaWWAN: {
            
            stateString = @"蜂窝数据";
            netStatusNumber = 2;
        }
            break;
        case ReachableViaWiFi: {
            
            stateString = @"WIFI";
            netStatusNumber = 1;
        }
            break;
        default: {
            
            stateString = @"不可识别的网络";
            netStatusNumber = -1;
        }
            break;
    }
    return netStatusNumber;
}

- (void)appReachabilityChanged:(NSNotification *)notification {
    NSLog(@"网络发生变化");
}



/// 取消通知
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kReachabilityChangedNotification object:nil];
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
