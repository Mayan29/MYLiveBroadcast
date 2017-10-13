//
//  MYScrollPageView.m
//  MYScrollPageView
//
//  Created by mayan on 2017/10/11.
//  Copyright © 2017年 mayan. All rights reserved.
//

#import "MYScrollPageView.h"
#import "MYScrollPageTitleBar.h"
#import "MYScrollPageCollectionView.h"

@interface MYScrollPageView () <MYScrollPageCollectionViewDelegate, MYScrollPageTitleBarDelegate>

@property (nonatomic, strong) NSArray <NSString *>*titles;
@property (nonatomic, strong) NSArray <UIViewController *>*childVCs;
@property (nonatomic, strong) MYScrollPageStyle *style;

@property (nonatomic, strong) MYScrollPageTitleBar       *titleBar;
@property (nonatomic, strong) MYScrollPageCollectionView *collectionView;

@end

@implementation MYScrollPageView

- (instancetype)initWithFrame:(CGRect)frame
                       titles:(NSArray<NSString *> *)titles
                     childVCs:(NSArray<UIViewController *> *)childVCs
                        style:(MYScrollPageStyle *)style
{
    self = [super initWithFrame:frame];
    if (self) {
        
        NSAssert(titles.count == childVCs.count, @"titles.count 和 childVCs.count 不相等");
        
        _titles   = titles;
        _childVCs = childVCs;
        _style    = style ? style : [[MYScrollPageStyle alloc] init];
        
        [self setupUI];
    }
    return self;
}

- (void)setupUI
{
    CGRect titleBarF = CGRectMake(0, 0, self.bounds.size.width, _style.titleBarHeight + (_style.isTitleScrollLineShow ? _style.titleScrollLineHeight : 0));
    CGRect collectionViewF = CGRectMake(0, CGRectGetMaxY(titleBarF), self.bounds.size.width, self.bounds.size.height - titleBarF.size.height);
    
    _titleBar = [[MYScrollPageTitleBar alloc] initWithFrame:titleBarF titles:_titles style:_style];
    _titleBar.my_delegate = self;
    [self addSubview:_titleBar];
    
    _collectionView = [[MYScrollPageCollectionView alloc] initWithFrame:collectionViewF childVCs:_childVCs];
    _collectionView.my_delegate = self;
    [self addSubview:_collectionView];
}

- (NSArray<UIViewController *> *)childVCs
{
    return _childVCs;
}

#pragma mark - MYScrollPageTitleBarDelegate
// 点击 titleBarItem 改变 UICollectionView contentOffset
- (void)scrollPageTitleBar:(MYScrollPageTitleBar *)scrollPageTitleBar clickItem:(NSInteger)item
{
    [_collectionView setContentOffset:CGPointMake(item * scrollPageTitleBar.bounds.size.width, 0) animated:YES];
}


#pragma mark - MYScrollPageCollectionViewDelegate
// 滑动 UICollectionView 改变 titleBar 文字颜色和底部滑动条
- (void)scrollViewDidScroll:(MYScrollPageCollectionView *)scrollPageCollectionView direction:(NSString *)direction
{
    [_titleBar scrollViewDidScroll:scrollPageCollectionView direction:direction];
}

@end
