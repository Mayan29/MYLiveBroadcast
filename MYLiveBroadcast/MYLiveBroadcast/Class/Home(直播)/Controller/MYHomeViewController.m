//
//  MYHomeViewController.m
//  MYLiveBroadcast
//
//  Created by mayan on 2017/9/28.
//  Copyright © 2017年 mayan. All rights reserved.
//

#import "MYHomeViewController.h"

@interface MYHomeViewController () <UISearchBarDelegate>

@end

@implementation MYHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNavigationBar];
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
    
    // 设置搜索框
    UISearchBar *searchBar = [[UISearchBar alloc] init];
    searchBar.placeholder    = @"主播昵称/房间号/链接";
    searchBar.searchBarStyle = UISearchBarStyleMinimal;
    searchBar.tintColor      = [UIColor whiteColor];
    searchBar.delegate       = self;
    
    UITextField *textField = [searchBar valueForKeyPath:@"_searchField"];
    textField.textColor = [UIColor whiteColor];
    
    self.navigationItem.titleView = searchBar;
}

#pragma mark - Action
- (void)rightItemClick
{
    NSLog(@"前往收藏夹");
}


@end
