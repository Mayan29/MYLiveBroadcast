//
//  MYHomeViewController.m
//  MYLiveBroadcast
//
//  Created by mayan on 2017/9/28.
//  Copyright © 2017年 mayan. All rights reserved.
//

#import "MYHomeViewController.h"
#import "MYPageView.h"
#import "MYAnchorViewController.h"
#import "MYRoomViewController.h"
#import "MYHomeDataService.h"

@interface MYHomeViewController () <UISearchBarDelegate>

@property (nonatomic, strong) MYPageView *pageView;

@end

@implementation MYHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self setupNavigationBar];
    [self setupContentView];
    [self setupData];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

#pragma mark - Set up UI
- (void)setupNavigationBar
{
    // 设置右侧收藏 item
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"home_favorites"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(rightItemClick)];
}

- (void)setupContentView
{
    // 1. frame
    CGFloat x = 0;
    CGFloat y = MYNavigationBarH + MYStatusBarH;
    CGFloat w = self.view.width;
    CGFloat h = self.view.height - y - MYTabBarH;
    CGRect frame = CGRectMake(x, y, w, h);
    // 2. 标题
    NSArray *titles = @[@"全部", @"高颜值", @"偶像派", @"好声音", @"有才艺", @"小鲜肉", @"搞笑", @"劲爆", @"更多"];
    // 3. 子控制器
    NSMutableArray *childVCs = [NSMutableArray array];
    for (int i = 0; i < titles.count; i++) {
        
        MYAnchorViewController *vc = [[MYAnchorViewController alloc] init];
        vc.itemClickBlock = ^(MYAnchorModel *model) {
            
            [self pushToRoomVcWithModel:model];
        };
        [childVCs addObject:vc];
    }
    // 4. 样式
    MYPageViewStyle *style = [[MYPageViewStyle alloc] init];
    
    
    _pageView = [[MYPageView alloc] initWithFrame:frame titles:titles childVCs:childVCs style:style];
    [self.view addSubview:_pageView];
}

#pragma mark - Set up Data
- (void)setupData
{
    MYHomeDataParams *params = [[MYHomeDataParams alloc] init];
    params.index = 0;
    params.size = 48;
    params.type = 0;
    
    [MYHomeDataService loadHomeDataWithParams:params success:^(NSArray<MYAnchorModel *> *response) {
        
        for (MYAnchorViewController *vc in _pageView.childVCs) {
            
            vc.dataArray = response;
        }
    }];
}

#pragma mark - Action
- (void)rightItemClick
{
    NSLog(@"前往收藏夹");
}

#pragma mark - other
- (void)pushToRoomVcWithModel:(MYAnchorModel *)model
{
    [self.navigationItem.titleView resignFirstResponder];
    
    MYRoomViewController *roomVC = [[MYRoomViewController alloc] init];
    roomVC.model = model;
    roomVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:roomVC animated:YES];
}


@end
