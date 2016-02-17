//
//  UIColor+HexValue.h
//  TestTabbar
//
//  Created by 林志成(平安科技移动开发三队健康及养老险开发组) on 16/2/16.
//  Copyright © 2016年 PingAn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (HexValue)

+ (UIColor *)jl_colorWithHexString:(NSString *)color;
+ (NSString *)jl_hexFromUIColor: (UIColor*) color;

@end
