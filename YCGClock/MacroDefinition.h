//
//  MacroDefinition.h
//  YCGClock
//
//  Created by 杨春贵 on 2018/12/3.
//  Copyright © 2018 com.yangcg.learn.Clock. All rights reserved.
//

#ifndef MacroDefinition_h
#define MacroDefinition_h

//-------------------设备尺寸------------------------
//NavBar高度
#define kStatusBarHEIGHT   [[UIApplication sharedApplication] statusBarFrame].size.height
#define kNavigationBarHEIGHT 44

#define kNavigationHEIGHT (kStatusBarHEIGHT+kNavigationBarHEIGHT)

#define kScreenBounds  [UIScreen mainScreen].bounds
#define kScreenHeight  ([[UIScreen mainScreen] bounds].size.height)
#define kScreenWidth   ([[UIScreen mainScreen] bounds].size.width)

//这个有隐患，隐藏状态栏的情况下statusBar高度为0
//#define kIs_iPhoneX ([[UIApplication sharedApplication] statusBarFrame].size.height==44 ? YES : NO)
#define kIsIPhoneX ((kScreenHeight>=812) ? YES : NO)

#define kTabBarHeight ([[UIApplication sharedApplication] statusBarFrame].size.height>20?83:49)

#endif /* MacroDefinition_h */
