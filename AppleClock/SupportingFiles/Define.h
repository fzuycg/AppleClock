//
//  Define.h
//  AppleClock
//
//  Created by 杨春贵 on 2018/12/13.
//  Copyright © 2018 com.yangcg.learn.AppleClock. All rights reserved.
//

#import <UIKit/UIKit.h>

#ifndef Define_h
#define Define_h

//-------------------设备尺寸------------------------
//NavBar高度
#define kStatusBarHEIGHT   [[UIApplication sharedApplication] statusBarFrame].size.height
#define kNavigationBarHEIGHT 44
#define kNavigationHEIGHT (kStatusBarHEIGHT+kNavigationBarHEIGHT)

#define kScreenBounds  [UIScreen mainScreen].bounds
#define kScreenHeight  ([[UIScreen mainScreen] bounds].size.height)
#define kScreenWidth   ([[UIScreen mainScreen] bounds].size.width)

#define kIsIPhoneX ((kScreenHeight>=812) ? YES : NO)

#define kTabBarHeight ([[UIApplication sharedApplication] statusBarFrame].size.height>20?83:49)

//-----------------通用参数------------------------
static const CGFloat contentEdge = 16; //内容边距
static const CGFloat lineHeight = 0.5; //线条高度

FOUNDATION_EXPORT UIColor *viewBgColor(void);
FOUNDATION_EXPORT UIColor *cellBgColor(void);
FOUNDATION_EXPORT UIColor *lineBgColor(void);
FOUNDATION_EXPORT UIColor *whiteTextColor(void);
FOUNDATION_EXPORT UIColor *grayTextColor(void);
FOUNDATION_EXPORT UIColor *redTextColor(void);


static NSString *alarmInfoKey = @"AlarmInfoKey";


#endif /* Define_h */
