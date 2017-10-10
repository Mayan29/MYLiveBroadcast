//
//  ViewController.m
//  MYPageView
//
//  Created by mayan on 2017/9/28.
//  Copyright © 2017年 mayan. All rights reserved.
//

#import "ViewController.h"
#import "MYPageView.h"

// RGB颜色
#define MYColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:0.5]
// 随机色
#define MYRandomColor MYColor(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 1. frame
    CGFloat y = self.navigationController.navigationBar.bounds.size.height + [UIApplication sharedApplication].statusBarFrame.size.height;
    CGRect frame = CGRectMake(0, y, self.view.bounds.size.width, self.view.bounds.size.height - y - self.tabBarController.tabBar.bounds.size.height);
    // 2. 标题
    NSArray *titles = @[@"全部", @"高颜值", @"偶像派", @"好声音", @"有才艺", @"小鲜肉", @"搞笑", @"劲爆", @"更多"];
    // 3. 子控制器
    NSMutableArray *childVCs = [NSMutableArray array];
    for (int i = 0; i < titles.count; i++) {
        
        // 创建一个控制器
        UIViewController *vc = [self createWithTitle:titles[i]];
        [childVCs addObject:vc];
    }
    // 4. 样式
    MYPageViewStyle *style = [[MYPageViewStyle alloc] init];
    
    
    MYPageView *pageView = [[MYPageView alloc] initWithFrame:frame titles:titles childVCs:childVCs style:style];
    [self.view addSubview:pageView];
}

- (UIViewController *)createWithTitle:(NSString *)title
{
    UIViewController *vc = [[UIViewController alloc] init];
    vc.view.backgroundColor = MYRandomColor;
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 100, vc.view.bounds.size.width, 50)];
    label.text          = title;
    label.font          = [UIFont systemFontOfSize:20];
    label.textAlignment = NSTextAlignmentCenter;
    [vc.view addSubview:label];
    
    return vc;
}


@end
