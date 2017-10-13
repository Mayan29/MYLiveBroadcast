//
//  MYScrollPageCollectionView.m
//  MYScrollPageView
//
//  Created by mayan on 2017/10/11.
//  Copyright © 2017年 mayan. All rights reserved.
//

#import "MYScrollPageCollectionView.h"

@interface MYScrollPageCollectionView () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) NSArray<UIViewController *> *childVCs;

@property (nonatomic, assign) CGFloat beginDraggingContentOffset;

@end

static NSString *identifier = @"MYContentViewCell";

@implementation MYScrollPageCollectionView

- (instancetype)initWithFrame:(CGRect)frame childVCs:(NSArray<UIViewController *> *)childVCs
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
        self.bounces                        = NO;
        self.backgroundColor                = [UIColor whiteColor];
        [self registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:identifier];
        
        _childVCs = childVCs;
    }
    return self;
}

#pragma mark - UICollectionView Delegate and Data Source
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    // 移除cell上所有view
    [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    UIViewController *vc = _childVCs[indexPath.item];
    vc.view.frame = cell.contentView.bounds;
    [cell.contentView addSubview:vc.view];
    
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _childVCs.count;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat num = scrollView.contentOffset.x - _beginDraggingContentOffset;

    NSString *direction;
    if (num > 0) {
        direction = @"向左";
    } else if (num < 0) {
        direction = @"向右";
    }
    
    if ([self.my_delegate respondsToSelector:@selector(scrollViewDidScroll:direction:)]) {
        [self.my_delegate scrollViewDidScroll:self direction:direction];
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    _beginDraggingContentOffset = scrollView.contentOffset.x;
}

@end
