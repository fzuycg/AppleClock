//
//  ChangeAIManager.h
//  AppleClock
//
//  Created by 杨春贵 on 2018/12/13.
//  Copyright © 2018 com.yangcg.learn.AppleClock. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 替换桌面图标
 */
@interface ChangeAIManager : NSObject

+ (instancetype)sharedInstance;

/**
 是否支持更换图标
 */
- (BOOL)isSuportChangeAppIcon;

/**
 更换图标
 
 @param iconName 图标名（需要提前配置好）
 */
- (void)changeAppIcon:(NSString *)iconName;

/**
 更换时不进行提示
 */
- (void)runtimeReplaceAlert;

@end

NS_ASSUME_NONNULL_END
