//
//  JKYTabBarController.m
//  TestTabbar
//
//  Created by 林志成(平安科技移动开发三队健康及养老险开发组) on 16/2/16.
//  Copyright © 2016年 PingAn. All rights reserved.
//

#import "JKYTabBarController.h"
#import "JKYConfigMarco.h"
#import "UIColor+HexValue.h"
#import "JKYTabBar.h"
#import "JKYCenterPopView.h"

#warning 此处添加子控制器头文件
#import "TestNavigationController.h"

@interface JKYTabBarController ()

@end

@implementation JKYTabBarController

+ (void)initialize
{
    // 通过appearance统一设置所有UITabBarItem的文字属性
    UITabBarItem *tabBarItem = [UITabBarItem appearance];
    
    /** 设置默认状态 */
    NSMutableDictionary *norDict = @{}.mutableCopy;
    norDict[NSFontAttributeName] = [UIFont systemFontOfSize:kNormalTabbarFontOfSize];
    norDict[NSForegroundColorAttributeName] = [UIColor jl_colorWithHexString:kNormalTabbarFontOfColor];
    [tabBarItem setTitleTextAttributes:norDict forState:UIControlStateNormal];
    
    /** 设置选中状态 */
    NSMutableDictionary *selDict = @{}.mutableCopy;
    selDict[NSFontAttributeName] = [UIFont systemFontOfSize:kSelectedTabbarFontOfSize];
    selDict[NSForegroundColorAttributeName] = [UIColor jl_colorWithHexString:kSelectedTabbarFontOfColor];
    [tabBarItem setTitleTextAttributes:selDict forState:UIControlStateSelected];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self loadTabbarFromPlist];
    
    
    
    if (kTabbarHaveCenterButton) {
        JKYTabBar *newTab = [[JKYTabBar alloc] init];
        [self setValue:newTab forKeyPath:@"tabBar"];
        [newTab setUpTabBarCenterButton:^(UIButton * _Nullable centerButton) {
            [centerButton setBackgroundImage:[UIImage imageNamed:kTabbarCenterButtonNormalImage] forState:UIControlStateNormal];
            [centerButton setBackgroundImage:[UIImage imageNamed:kTabbarCenterButtonHighlightedImage] forState:UIControlStateHighlighted];
            [centerButton addTarget:self action:@selector(centerBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        }];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadTabbarFromPlist
{
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"JKYTabbarItem" ofType:@"plist"];
    NSArray *array = [[NSArray alloc] initWithContentsOfFile:plistPath];
    for (NSInteger i = 0; i < array.count; i++) {
        NSDictionary *dict = [array objectAtIndex:i];
        if ([dict isKindOfClass:[NSDictionary class]]) {
            Class navClass = NSClassFromString([dict objectForKey:@"navClassName"]);
            Class c = NSClassFromString([dict objectForKey:@"className"]);
            UINavigationController *nav = [[navClass alloc] initWithRootViewController:[[c alloc] init]];
            [self setupChildVc:nav title:[dict objectForKey:@"title"] image:[dict objectForKey:@"normalImage"] selectedImage:[dict objectForKey:@"selectedImage"]];
        }
    }
}

/**
 * 初始化子控制器
 */
- (void)setupChildVc:(UIViewController *)vc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    
    
    // 设置文字和图片
    vc.tabBarItem.title = title;
    vc.tabBarItem.image = [[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    vc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    vc.view.backgroundColor = [UIColor colorWithRed:arc4random_uniform(100)/100.0 green:arc4random_uniform(100)/100.0 blue:arc4random_uniform(100)/100.0 alpha:1.0];
    // 添加为子控制器
    [self addChildViewController:vc];
}

- (void)centerBtnClick:(UIButton *)sender
{
//    NSLog(@"centerBtnClick");
    if (sender.selected) {
        UIView *subView = [self.view viewWithTag:1900];
        if ([subView isKindOfClass:[JKYCenterPopView class]]) {
            [subView removeFromSuperview];
        }
    } else {
        CGRect bounds = [UIScreen mainScreen].bounds;
        JKYCenterPopView *popView = [[JKYCenterPopView alloc] initWithFrame:CGRectMake(0, bounds.size.height - 65.0 - 50.0, bounds.size.width, 50.0)];
//        popView.backgroundColor = [UIColor yellowColor];
        popView.tag = 1900;
        [self.view addSubview:popView];
        [self.view bringSubviewToFront:popView];
    }
    
    sender.selected = !sender.selected;
}

@end
