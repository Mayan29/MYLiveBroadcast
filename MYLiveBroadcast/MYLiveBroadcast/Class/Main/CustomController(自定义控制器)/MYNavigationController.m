//
//  MYNavigationController.m
//  MYNewProject
//
//  Created by mayan on 2017/3/7.
//  Copyright © 2017年 mayan. All rights reserved.
//

#import "MYNavigationController.h"
#import "UIBarButtonItem+Extension.h"
//#import <objc/runtime.h>

@interface MYNavigationController () <UIGestureRecognizerDelegate>

@end

@implementation MYNavigationController


#pragma mark - 设置样式
+ (void)initialize
{
    // 1.设置标题栏字体颜色和大小
    UINavigationBar *bar = [UINavigationBar appearanceWhenContainedInInstancesOfClasses:@[self.class]];
    [bar setTitleTextAttributes:@{
                                  NSFontAttributeName : SYS_FONT(15),
                                  NSForegroundColorAttributeName : [UIColor orangeColor]
                                  }];
    [bar setBarTintColor:[UIColor blackColor]];
    
    // 2.设置Item主题样式（高亮颜色尚未处理完善、可用类别创建文字按钮）
    UIBarButtonItem *item = [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[self.class]];
    [item setTitleTextAttributes:@{
                                   NSFontAttributeName : SYS_FONT(15),
                                   NSForegroundColorAttributeName : [UIColor blackColor]
                                   }
                        forState:UIControlStateNormal];
    [item setTitleTextAttributes:@{
                                   NSFontAttributeName : SYS_FONT(15),
                                   NSForegroundColorAttributeName : [UIColor lightGrayColor]
                                   }
                        forState:UIControlStateDisabled];
    [item setTitleTextAttributes:@{
                                   NSFontAttributeName : SYS_FONT(15),
                                   NSForegroundColorAttributeName : [UIColor orangeColor]
                                   }
                        forState:UIControlStateHighlighted];
}


#pragma mark - 返回按钮
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count > 0) {
        
        viewController.hidesBottomBarWhenPushed = YES;
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem my_itemWithTarget:self action:@selector(back) image:@"back_btn_nor" higImage:@"back_btn_hig"];
    }
    [super pushViewController:viewController animated:animated];
}
- (void)back
{
    [self popViewControllerAnimated:YES];
}


#pragma mark - 滑动返回
- (void)viewDidLoad
{
    [super viewDidLoad];

    self.interactivePopGestureRecognizer.delegate = self;
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    // 非根控制器才会触发
    return (self.childViewControllers.count > 1);
}

// ios 11 之前只有如下方法才可以实现全屏 Pop
//- (void)viewDidLoad
//{
//    [super viewDidLoad];
//
//    // 全屏 Pop
//    // 0. 获取私有属性名
//    unsigned int count = 0;
//    Ivar *ivars = class_copyIvarList(UIGestureRecognizer.class, &count);
//    for (int i = 0; i < count; i++) {
//        NSLog(@"%d : %s", i, ivar_getName(ivars[i]));
//    }
//    // 1. 获取 target 和 action
//    id targetObjc = [[self.interactivePopGestureRecognizer valueForKey:@"_targets"] firstObject];
//    id target = [targetObjc valueForKey:@"target"];
//    SEL action = NSSelectorFromString(@"handleNavigationTransition:");
//    // 2. 将手势添加到 view 上
//    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:target action:action];
//    pan.delegate = self;
//    [self.view addGestureRecognizer:pan];
//}
//
//- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
//{
//    // 当前控制器是否为根控制器
//    BOOL isRootVC = self.viewControllers.count == 1;
//    // 是否正在进行 push、pop 动画
//    BOOL isTransitioning = [[self valueForKey:@"_isTransitioning"] boolValue];
//
//    return !isRootVC && !isTransitioning;
//}


#pragma mark - 控制器状态栏的颜色
//- (UIViewController *)childViewControllerForStatusBarStyle {
//    return self.topViewController;
//}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}


@end
