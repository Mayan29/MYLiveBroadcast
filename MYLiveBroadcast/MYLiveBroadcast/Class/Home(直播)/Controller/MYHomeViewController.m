//
//  MYHomeViewController.m
//  MYLiveBroadcast
//
//  Created by mayan on 2017/9/28.
//  Copyright © 2017年 mayan. All rights reserved.
//

#import "MYHomeViewController.h"
#import "MYPageView.h"

@interface MYHomeViewController () <UISearchBarDelegate>

@end

@implementation MYHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNavigationBar];
    [self setupUI];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

#pragma mark - Setup UI
- (void)setupNavigationBar
{
    // 设置右侧收藏 item
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"home_favorites"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(rightItemClick)];
}

- (void)setupUI
{
    // 1. frame
    CGFloat y = self.navigationController.navigationBar.bounds.size.height + [UIApplication sharedApplication].statusBarFrame.size.height;
    CGRect frame = CGRectMake(0, y, self.view.bounds.size.width, self.view.bounds.size.height - y - self.tabBarController.tabBar.bounds.size.height);
    // 2. 标题
    NSArray *titles = @[@"全部", @"高颜值", @"偶像派", @"好声音", @"有才艺", @"小鲜肉", @"搞笑", @"劲爆", @"更多"];
    // 3. 子控制器
    NSMutableArray *childVCs = [NSMutableArray array];
    for (int i = 0; i < titles.count; i++) {
        
        UIViewController *vc = [[UIViewController alloc] init];
        vc.view.backgroundColor = MYRandomColor;
        [childVCs addObject:vc];
    }
    // 4. 样式
    MYPageViewStyle *style = [[MYPageViewStyle alloc] init];
    
    
    MYPageView *pageView = [[MYPageView alloc] initWithFrame:frame titles:titles childVCs:childVCs parentVC:self style:style];
    [self.view addSubview:pageView];
}

#pragma mark - Action
- (void)rightItemClick
{
    NSLog(@"前往收藏夹");
}


@end
