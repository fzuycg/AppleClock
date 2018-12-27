//
//  AlarmDatePickerView.h
//  AppleClock
//
//  Created by 杨春贵 on 2018/12/20.
//  Copyright © 2018 com.yangcg.learn.AppleClock. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

//#define D_yyyyMMddHHmmss    @"yyyy-MM-dd HH:mm:ss"      //时间标准模式——1.年-月-日 小时:分钟:秒钟
//#define D_yyyyMMddHHmm      @"yyyy-MM-dd HH:mm"         //时间标准模式——2.年-月-日 小时:分钟
//#define D_MMddHHmm          @"MM-dd HH:mm"              //时间标准模式-—3.月/日 小时:分钟
//#define D_yyyyMMdd          @"yyyy年MM月dd日"            //时间标准模式——4.年月日
//#define D_yyyy_MM_dd        @"yyyy-MM-dd"               //时间标准模式——5.年-月-日
//#define D_HHmm              @"HH:mm"                    //时间标准模式——6.小时:分钟

@protocol AlarmDatePickerViewDelegate <NSObject>

- (void)datePickerResult:(NSDate *)alarmDate;

@end

@interface AlarmDatePickerView : UIView
@property (nonatomic, weak) id<AlarmDatePickerViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
