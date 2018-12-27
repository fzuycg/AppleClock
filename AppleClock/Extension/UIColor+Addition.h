//
//  UIColor+Addition.h
//  AppleClock
//
//  Created by 杨春贵 on 2018/12/14.
//  Copyright © 2018 com.yangcg.learn.AppleClock. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (Addition)

+ (UIColor *)colorWithARGBString:(NSString *)argbString;
+ (UIColor *)colorWithHexString:(NSString *)color;

@end

NS_ASSUME_NONNULL_END
