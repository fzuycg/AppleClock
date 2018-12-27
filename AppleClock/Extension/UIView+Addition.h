//
//  UIView+Addition.h
//  AppleClock
//
//  Created by 杨春贵 on 2018/12/14.
//  Copyright © 2018 com.yangcg.learn.AppleClock. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (Addition)

@property (assign, nonatomic) CGFloat    top;
@property (assign, nonatomic) CGFloat    bottom;
@property (assign, nonatomic) CGFloat    left;
@property (assign, nonatomic) CGFloat    right;

@property (assign, nonatomic) CGFloat    x;
@property (assign, nonatomic) CGFloat    y;
@property (assign, nonatomic) CGPoint    origin;

@property (assign, nonatomic) CGFloat    centerX;
@property (assign, nonatomic) CGFloat    centerY;

@property (assign, nonatomic) CGFloat    width;
@property (assign, nonatomic) CGFloat    height;
@property (assign, nonatomic) CGSize     size;

@end

NS_ASSUME_NONNULL_END
