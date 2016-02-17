//
//  JKYTabBar.h
//  TestTabbar
//
//  Created by 林志成(平安科技移动开发三队健康及养老险开发组) on 16/2/16.
//  Copyright © 2016年 PingAn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JKYTabBar : UITabBar

// 设置个性化中间按钮
- (void)setUpTabBarCenterButton:(void ( ^ _Nullable )(UIButton * _Nullable centerButton ))centerButtonBlock;

@end
