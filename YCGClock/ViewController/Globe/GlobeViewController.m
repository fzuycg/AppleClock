//
//  GlobeViewController.m
//  YCGClock
//
//  Created by 杨春贵 on 2018/11/22.
//  Copyright © 2018 com.yangcg.learn.Clock. All rights reserved.
//

#import "GlobeViewController.h"
#import "ClockView.h"
#import "WorldClockView.h"

@interface GlobeViewController ()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIBarButtonItem *addClockButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *editClockButton;

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) ClockView *clockView;
@property (nonatomic, strong) WorldClockView *worldClockView;

@end

@implementation GlobeViewController {
    BOOL _isClockImage;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.clockView startAnimation];
}

- (void)createUI {
    [self.view addSubview:self.scrollView];
    [self.view addSubview:self.pageControl];
    self.worldClockView.backgroundColor = [UIColor clearColor];
}

#pragma mark - Action

- (IBAction)editClockAction:(id)sender {
    
}

- (IBAction)addClockAction:(id)sender {
    
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (_scrollView.contentOffset.x >= kScreenWidth) {
        _pageControl.currentPage = 1;
    }else{
        _pageControl.currentPage = 0;
    }
    NSLog(@"X = %f", scrollView.contentOffset.x);
    
}


#pragma mark - Lazy
- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, kNavigationHEIGHT, kScreenWidth, kScreenHeight-kNavigationHEIGHT-kTabBarHeight)];
        _scrollView.contentSize = CGSizeMake(kScreenWidth * 2, kScreenHeight-kNavigationHEIGHT-kTabBarHeight);
        _scrollView.pagingEnabled = YES;
        
        _scrollView.delegate = self;
//        [_scrollView setContentOffset:CGPointMake(kScreenWidth, 0)];
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.bounces = NO;
    }
    return _scrollView;
}

- (UIPageControl *)pageControl {
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, kScreenHeight-120, kScreenWidth, 30)];
        _pageControl.currentPage = 0;
        _pageControl.numberOfPages = 2;
        _pageControl.pageIndicatorTintColor = [UIColor colorWithRed:128/255. green:128/255. blue:128/255. alpha:1.];
        _pageControl.currentPageIndicatorTintColor = [UIColor colorWithRed:255/255. green:149/255. blue:1/255. alpha:1.];
    }
    return _pageControl;
}

- (ClockView *)clockView {
    if (!_clockView) {
        _clockView = [[ClockView alloc] initWithFrame:CGRectMake(0, 0, 300, 300)];
        _clockView.center = CGPointMake(self.view.center.x, (kScreenHeight)/2-kNavigationHEIGHT);
        [_scrollView addSubview:_clockView];
    }
    return _clockView;
}

- (WorldClockView *)worldClockView {
    if (!_worldClockView) {
        _worldClockView = [[WorldClockView alloc] initWithFrame:CGRectMake(kScreenWidth, 0, kScreenWidth, _scrollView.frame.size.height)];
        [_scrollView addSubview:_worldClockView];
    }
    return _worldClockView;
}

@end
