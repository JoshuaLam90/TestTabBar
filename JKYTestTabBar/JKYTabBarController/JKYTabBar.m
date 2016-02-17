//
//  JKYTabBar.m
//  TestTabbar
//
//  Created by 林志成(平安科技移动开发三队健康及养老险开发组) on 16/2/16.
//  Copyright © 2016年 PingAn. All rights reserved.
//

#import "JKYTabBar.h"
#import "JKYConfigMarco.h"

@interface JKYTabBar ()

@property (nonatomic, weak) UIButton *centerBtn;

@end

@implementation JKYTabBar

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        UIButton *centerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [self addSubview:centerBtn];
        self.centerBtn = centerBtn;
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat width = CGRectGetWidth(self.frame);
    CGFloat height = CGRectGetHeight(self.frame);
    
    // 设置发布按钮的frame
    _centerBtn.frame = CGRectMake(0, 0, _centerBtn.currentBackgroundImage.size.width, _centerBtn.currentBackgroundImage.size.height);
    
    CGFloat heightDifference = _centerBtn.currentBackgroundImage.size.height - self.frame.size.height;
    if (heightDifference < 0) {
        _centerBtn.center = CGPointMake(width * 0.5, height * 0.5);
    } else {
        CGPoint center = CGPointMake(width * 0.5, height * 0.5);
        center.y = center.y - heightDifference / 2.0;
        _centerBtn.center = center;
    }
    
    // 设置其他UITabBarButton的frame
    CGFloat buttonY = 0;
    CGFloat buttonW = width / 5.0;
    CGFloat buttonH = height;
    NSInteger index = 0;
    for (UIView *button in self.subviews) {
        if (![button isKindOfClass:[UIControl class]] || button == self.centerBtn) continue;
        
        CGFloat buttonX = buttonW * ((index > 1)?(index + 1):index);
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        index++;
    }
}

- (void)setUpTabBarCenterButton:(void ( ^ _Nullable )(UIButton * _Nullable centerButton ))centerButtonBlock
{
    centerButtonBlock(_centerBtn);
}

@end
