//
//  MYNavigationController.m
//  MYNewProject
//
//  Created by mayan on 2017/3/7.
//  Copyright © 2017年 mayan. All rights reserved.
//

#import "MYNavigationController.h"
#import "UIBarButtonItem+Extension.h"

@interface MYNavigationController () <UIGestureRecognizerDelegate>

@end

@implementation MYNavigationController


#pragma mark - 设置样式
+ (void)initialize
{
    // 1.设置标题栏字体颜色和大小
    UINavigationBar *bar = [UINavigationBar appearanceWhenContainedIn:self, nil];
    [bar setTitleTextAttributes:@{
                                  NSFontAttributeName : SYS_FONT(15),
                                  NSForegroundColorAttributeName : [UIColor orangeColor]
                                  }];
    [bar setBackgroundImage:[UIImage imageNamed:@"导航栏图片"] forBarMetrics:UIBarMetricsDefault];
    
    // 2.设置Item主题样式（高亮颜色尚未处理完善、可用类别创建文字按钮）
    UIBarButtonItem *item = [UIBarButtonItem appearanceWhenContainedIn:self, nil];
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


@end
