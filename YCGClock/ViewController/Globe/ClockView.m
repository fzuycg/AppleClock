//
//  ClockView.m
//  YCGClock
//
//  Created by 杨春贵 on 2018/11/30.
//  Copyright © 2018 com.yangcg.learn.Clock. All rights reserved.
//

#import "ClockView.h"
#import <POP.h>
#import "ClockHandView.h"

@interface ClockView ()<POPAnimationDelegate>

@property (nonatomic, strong) ClockHandView *hourHand;
@property (nonatomic, strong) ClockHandView *minuteHand;
@property (nonatomic, strong) ClockHandView *secondHand;
@property (nonatomic, strong) UIImageView *midImageView;
@property (nonatomic, strong) NSTimer *timer;

@end

@implementation ClockView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self createUI];
        [self buildTimer];
        [self updateClockHand];
    }
    return self;
}

- (void)createUI {
    //表盘
    UIImageView *clockBack = [[UIImageView alloc] initWithFrame:self.bounds];
    clockBack.contentMode = UIViewContentModeScaleAspectFit;
    clockBack.image = [UIImage imageNamed:@"clock_back"];
    [self addSubview:clockBack];
    
    //时间位置
    CGFloat hourH = self.bounds.size.width * 0.07;
    CGFloat hourSpace = self.bounds.size.height * 0.2;
    UIImageView *hour12 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"clock_hour_12"]];
    hour12.frame = CGRectMake(0, 0, hourH, hourH);
    hour12.center = CGPointMake(self.bounds.size.width/2.0f, hourSpace);
    [self addSubview:hour12];
    
    UIImageView *hour3 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"clock_hour_3"]];
    hour3.frame = CGRectMake(0, 0, hourH, hourH);
    hour3.center = CGPointMake(self.bounds.size.width - hourSpace, self.bounds.size.height/2.0f);
    [self addSubview:hour3];
    
    //计算数据
    CGFloat midHeight = self.bounds.size.height*0.15;
    CGFloat hourHandHeight = self.bounds.size.height*0.44;
    CGFloat minuteHandHeight = self.bounds.size.height*0.59;
    CGFloat secondHandHeight = self.bounds.size.height*0.65;
    CGPoint handCenter = CGPointMake(self.bounds.size.width/2.0f, self.bounds.size.height/2.0f);
    
    //中间原点
    UIImageView *midImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, midHeight, midHeight)];
    midImageView.center = handCenter;
    midImageView.contentMode = UIViewContentModeScaleAspectFit;
    midImageView.image = [UIImage imageNamed:@"clock_mid"];
    [self addSubview:midImageView];
    self.midImageView = midImageView;
    
    //时针
    ClockHandView *hourHand = [[ClockHandView alloc] initWithFrame:CGRectMake(0, 0, hourHandHeight, hourHandHeight)];
    hourHand.center = handCenter;
    hourHand.handImage = [UIImage imageNamed:@"clock_hourHand"];
    hourHand.shadowImage = [UIImage imageNamed:@"clock_hourHand_shadow"];
    [self addSubview:hourHand];
    self.hourHand = hourHand;
    
    //分针
    ClockHandView *minuteHand = [[ClockHandView alloc] initWithFrame:CGRectMake(0, 0, minuteHandHeight, minuteHandHeight)];
    minuteHand.center = handCenter;
    minuteHand.handImage = [UIImage imageNamed:@"clock_minuteHand"];
    minuteHand.shadowImage = [UIImage imageNamed:@"clock_minuteHand_shadow"];
    [self addSubview:minuteHand];
    self.minuteHand = minuteHand;
    
    //秒针
    ClockHandView *secondHand = [[ClockHandView alloc] initWithFrame:CGRectMake(0, 0, secondHandHeight, secondHandHeight)];
    secondHand.center = handCenter;
    secondHand.handImage = [UIImage imageNamed:@"clock_secondHand"];
    secondHand.shadowImage = [UIImage imageNamed:@"clock_secondHand_shadow"];
    [self addSubview:secondHand];
    self.secondHand = secondHand;
    
}

///定时器
- (void)buildTimer {
    __weak typeof (self)weakSelf = self;
    if (@available(iOS 10.0, *)) {
        self.timer = [NSTimer timerWithTimeInterval:1.0 repeats:YES block:^(NSTimer * _Nonnull timer) {
            [weakSelf updateClockHand];
        }];
    } else {
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:weakSelf selector:@selector(updateClockHand) userInfo:nil repeats:YES];
    }
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

///更新指针位置
- (void)updateClockHand {
    //获取时间
    NSDateComponents *dateComponents = [[NSCalendar currentCalendar] components:NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond fromDate:[NSDate date]];
    
    //时针动画
    CGFloat hourAngle = (dateComponents.hour + dateComponents.minute/60.0f) * M_PI*2/12.0f;
    POPBasicAnimation *hourPop = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerRotation];
    hourPop.fromValue = @(hourAngle);
    hourPop.toValue = @(hourAngle);
    [_hourHand.layer pop_addAnimation:hourPop forKey:@"hourPop"];
    
    //分针动画
    CGFloat minuteAngle = (dateComponents.minute + dateComponents.second/60.0f) * M_PI*2/60.0f;
    POPBasicAnimation *minitePop = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerRotation];
    minitePop.fromValue = @(minuteAngle);
    minitePop.toValue = @(minuteAngle);
    [_minuteHand.layer pop_addAnimation:minitePop forKey:@"minitePop"];
    
    //秒针动画
    CGFloat secondAngle = dateComponents.second * M_PI*2/60.0f;
    CGFloat lastSecondAngle = (dateComponents.second - 1) * M_PI*2/60.0f;
    POPSpringAnimation *secondpop = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerRotation];
    secondpop.springBounciness = 10;//回弹力
    secondpop.springSpeed = 20;//速度
    secondpop.fromValue = @(lastSecondAngle);
    secondpop.toValue = @(secondAngle);
    [_secondHand.layer pop_addAnimation:secondpop forKey:@"secondpop"];
    
}

- (void)startAnimation {
    //获取时间
    NSDateComponents *dateComponents = [[NSCalendar currentCalendar] components:NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond fromDate:[NSDate date]];
    
    //时针动画
    CGFloat hourAngle = (dateComponents.hour + dateComponents.minute/60.0f) * M_PI*2/12.0f;
    POPBasicAnimation *hourPop = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerRotation];
    hourPop.fromValue = @(hourAngle - M_PI_4);
    hourPop.toValue = @(hourAngle);
    hourPop.duration = 1;
    [_hourHand.layer pop_addAnimation:hourPop forKey:@"hourPop"];
    [_hourHand pop_addAnimation:[self viewAlphaPop] forKey:@"viewAlphaPop"];
    
    //分针动画
    CGFloat minuteAngle = (dateComponents.minute + dateComponents.second/60.0f) * M_PI*2/60.0f;
    POPBasicAnimation *minitePop = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerRotation];
    minitePop.fromValue = @(minuteAngle - M_PI_4 * 2);
    minitePop.toValue = @(minuteAngle);
    minitePop.duration = 1.25;
    [_minuteHand.layer pop_addAnimation:minitePop forKey:@"minitePop"];
    [_minuteHand pop_addAnimation:[self viewAlphaPop] forKey:@"viewAlphaPop"];
    
    //秒针动画
    CGFloat secondPopDuration = 1.5;
    CGFloat secondAngle = (dateComponents.second + 1) * M_PI*2/60.0f;
    POPBasicAnimation *secondPop = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerRotation];
    secondPop.fromValue = @(secondAngle - M_PI_4 * 3);
    secondPop.toValue = @(secondAngle);
    secondPop.duration = secondPopDuration;
    secondPop.delegate = self;
    [_secondHand.layer pop_addAnimation:secondPop forKey:@"secondPop"];
    [_secondHand pop_addAnimation:[self viewAlphaPop] forKey:@"viewAlphaPop"];
    
    [_midImageView pop_addAnimation:[self viewAlphaPop] forKey:@"viewAlphaPop"];
}

//透明度动画
- (POPBasicAnimation *)viewAlphaPop {
    POPBasicAnimation *viewAlphaPop = [POPBasicAnimation animationWithPropertyNamed:kPOPViewAlpha];
    viewAlphaPop.fromValue = @(0);
    viewAlphaPop.toValue = @(1);
    viewAlphaPop.duration = 1;
    return viewAlphaPop;
}

#pragma mark - POPAnimatorDelegate
//开始动画期间，不执行刷新方法
- (void)pop_animationDidStart:(POPAnimation *)anim {
    [_timer setFireDate:[NSDate distantFuture]];
}

- (void)pop_animationDidStop:(POPAnimation *)anim finished:(BOOL)finished {
    [_timer setFireDate:[NSDate dateWithTimeIntervalSinceNow:0.5]];
}

@end
