//
//  MYTabBarController.m
//  MYNewProject
//
//  Created by mayan on 2017/3/7.
//  Copyright © 2017年 mayan. All rights reserved.
//

#import "MYTabBarController.h"
#import "MYNavigationController.h"

#import "MYHomeViewController.h"
#import "MYRankViewController.h"
#import "MYDiscoverViewController.h"
#import "MYProfileViewController.h"

@interface MYTabBarController ()

@end

@implementation MYTabBarController


+ (void)initialize
{
    // 如果使用appearance,调用发短信,会修改系统的导航条,导致选取联系人按钮消失
    UITabBarItem *item = [UITabBarItem appearanceWhenContainedIn:self, nil];
    
    NSDictionary *norAttr = @{
                              NSFontAttributeName : SYS_FONT(12),
                              NSForegroundColorAttributeName : MYColor(120, 120, 120)
                              };
    NSDictionary *selAttr = @{
                              NSFontAttributeName : SYS_FONT(12),
                              NSForegroundColorAttributeName : [UIColor orangeColor]
                              };
    [item setTitleTextAttributes:norAttr forState:UIControlStateNormal];
    [item setTitleTextAttributes:selAttr forState:UIControlStateSelected];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    MYHomeViewController *vc_1 = [[MYHomeViewController alloc] init];
    [self addChildVC:vc_1 title:@"直播" image:@"tab_one_nor" selImage:@"tab_one_sel" hasNvc:YES];
    
    MYRankViewController *vc_2 = [[MYRankViewController alloc] init];
    [self addChildVC:vc_2 title:@"排行" image:@"tab_two_nor" selImage:@"tab_two_sel" hasNvc:NO];
    
    MYDiscoverViewController *vc_3 = [[MYDiscoverViewController alloc] init];
    [self addChildVC:vc_3 title:@"发现" image:@"tab_three_nor" selImage:@"tab_three_sel" hasNvc:YES];
    
    MYProfileViewController *vc_4 = [[MYProfileViewController alloc] init];
    [self addChildVC:vc_4 title:@"我的" image:@"tab_four_nor" selImage:@"tab_four_sel" hasNvc:NO];
}

- (void)addChildVC:(UIViewController *)vc title:(NSString *)title image:(NSString *)image selImage:(NSString *)selImage hasNvc:(BOOL)hasNvc
{
    vc.title = title;
    vc.tabBarItem.image = [[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    vc.tabBarItem.selectedImage = [[UIImage imageNamed:selImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    if (hasNvc) {
        [self addChildViewController:[[MYNavigationController alloc] initWithRootViewController:vc]];
    } else {
        [self addChildViewController:vc];
    }
}


@end
