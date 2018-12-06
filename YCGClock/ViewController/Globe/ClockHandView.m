//
//  ClockHandView.m
//  YCGClock
//
//  Created by 杨春贵 on 2018/11/30.
//  Copyright © 2018 com.yangcg.learn.Clock. All rights reserved.
//

#import "ClockHandView.h"

@interface ClockHandView ()

@property (nonatomic, strong) UIImageView *handImageView;

@property (nonatomic, strong) UIImageView *shadowImageView;

@end

@implementation ClockHandView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self createUI];
    }
    return self;
}

- (void)createUI {
    //时针
    UIImageView *handImageView = [[UIImageView alloc] initWithFrame:self.bounds];
    handImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:handImageView];
    self.handImageView = handImageView;
    
    //时针阴影
    UIImageView *shadowImageView = [[UIImageView alloc] initWithFrame:self.bounds];
    shadowImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:shadowImageView];
    self.shadowImageView = shadowImageView;
}

#pragma mark - setter
- (void)setHandImage:(UIImage *)handImage {
    _handImage = handImage;
    self.handImageView.image = handImage;
}

- (void)setShadowImage:(UIImage *)shadowImage {
    _shadowImage = shadowImage;
    self.shadowImageView.image = shadowImage;
}


@end
