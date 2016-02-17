//
//  JKYCenterPopView.m
//  TestTabbar
//
//  Created by 林志成(平安科技移动开发三队健康及养老险开发组) on 16/2/17.
//  Copyright © 2016年 PingAn. All rights reserved.
//

#import "JKYCenterPopView.h"



@implementation JKYCenterPopView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:[self returnNormalButton]];
        [self addSubview:[self returnNormalButton]];
        
    }
    return self;
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat width = CGRectGetWidth(self.frame);
    CGFloat height = CGRectGetHeight(self.frame);
    CGFloat marginX = (width - self.subviews.count * 44.0) / 3.0;
    for (NSInteger i = 0; i < self.subviews.count; i++) {
        
        UIButton *btn = self.subviews[i];
        if (![btn isKindOfClass:[UIButton class]]) return;
        btn.center = CGPointMake(0, height * 0.5);
        CGRect frame = btn.frame;
        frame.origin.x = marginX * (i + 1) + 44.0 * i;
        btn.frame = frame;
    }
}

- (UIButton *)returnNormalButton
{
    CGFloat width = 44.0;
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, width, width);
    btn.backgroundColor = [UIColor lightGrayColor];
    btn.layer.cornerRadius = width * 0.5;
    btn.layer.masksToBounds = YES;
    
    return btn;
}

@end
