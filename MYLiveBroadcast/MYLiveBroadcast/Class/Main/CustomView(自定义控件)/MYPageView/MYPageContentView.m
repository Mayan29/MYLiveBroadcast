//
//  MYPageContentView.m
//  MYPageView
//
//  Created by mayan on 2017/9/28.
//  Copyright © 2017年 mayan. All rights reserved.
//

#import "MYPageContentView.h"
#import "MYPageTitleView.h"

@interface MYPageContentView () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) NSArray <UIViewController *>*childVCs;
@property (nonatomic, weak  ) UIViewController *parentVC;

@property (nonatomic, assign) NSInteger currentRow;

@end


static NSString *identifier = @"MYContentViewCell";

@implementation MYPageContentView

#pragma mark - Init
- (instancetype)initWithFrame:(CGRect)frame childVCs:(NSArray <UIViewController *>*)childVCs parentVC:(UIViewController *)parentVC
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = frame.size;
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        
        self.delegate                       = self;
        self.dataSource                     = self;
        self.pagingEnabled                  = YES;
        self.scrollsToTop                   = NO;
        self.showsHorizontalScrollIndicator = NO;
        self.backgroundColor                = [UIColor whiteColor];
        [self registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:identifier];
        
        _childVCs = childVCs;
        _parentVC = parentVC;
        for (UIViewController *vc in childVCs) {
            [parentVC addChildViewController:vc];
        }
        
        // 注册通知（点击 titleView 改变 contentView 位置）
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pageTitleViewMakePageContentViewScroll:) name:@"MYPageTitleViewMakeMYPageContentViewScroll" object:nil];
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - UICollectionView Delegate and Data Source
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    // 移除cell上所有view
    [cell.contentView.subviews makeObjectsPerformSelector:@selector
     (removeFromSuperview)];
    
    UIViewController *vc = _childVCs[indexPath.item];
    vc.view.frame = cell.contentView.bounds;
    [cell.contentView addSubview:vc.view];
    
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _childVCs.count;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self contentEndScroll];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self contentEndScroll];
}

#pragma mark - NSNotification
- (void)pageTitleViewMakePageContentViewScroll:(NSNotification *)notification
{
    NSUInteger row = [notification.object integerValue];
    
    // 点击 titleLabel 使 contentView 滚动到对应的页面
    [self scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:row inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
}

- (void)contentEndScroll
{
    // 获取滚动到的位置
    NSUInteger row = (self.contentOffset.x + self.bounds.size.width * 0.5) / self.bounds.size.width;
    
    if (row == _currentRow) return;
    
    _currentRow = row;
    
    // 通知 titleView 滚动调整
    [[NSNotificationCenter defaultCenter] postNotificationName:@"MYPageContentViewMakeMYPageTitleViewScroll" object:@(row)];
}

@end
