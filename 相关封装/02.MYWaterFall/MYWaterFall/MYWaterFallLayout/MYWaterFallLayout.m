//
//  MYWaterFallLayout.m
//  瀑布流
//
//  Created by mayan on 2017/5/22.
//  Copyright © 2017年 mayan. All rights reserved.
//

#import "MYWaterFallLayout.h"

@interface MYWaterFallLayout ()

@property (nonatomic, strong) NSMutableArray <UICollectionViewLayoutAttributes *>*cellAttrs;
@property (nonatomic, strong) NSMutableArray <NSNumber *>*totalHeights;

@end

@implementation MYWaterFallLayout


static const NSUInteger cols = 3;  // 列数


#pragma mark - lazy load
- (NSMutableArray<UICollectionViewLayoutAttributes *> *)cellAttrs
{
    if (!_cellAttrs) {
        _cellAttrs = [NSMutableArray array];
    }
    return _cellAttrs;
}
- (NSMutableArray<NSNumber *> *)totalHeights
{
    if (!_totalHeights) {
        _totalHeights = [NSMutableArray array];
        
        for (int i = 0; i < cols; i++) {
            [_totalHeights addObject:@(self.sectionInset.top)];
        }
    }
    return _totalHeights;
}


#pragma mark - delegate
// 什么时候调用：第一次布局、collectionView 刷新
// 作用：计算 cell 布局（条件：cell 的位置固定不变）
- (void)prepareLayout
{
    [super prepareLayout];
    
    // 0.定义默认初始时，所有 cell 的位置的数据
    CGFloat cellW = (self.collectionView.bounds.size.width - self.sectionInset.left - self.sectionInset.right - (cols - 1) * self.minimumInteritemSpacing) / cols;
    
    
    // 1.获取 cell 个数
    NSUInteger itemCount = [self.collectionView numberOfItemsInSection:0];
    
    // 2.给每个 cell 创建一个 UICollectionViewLayoutAttributes
    for (int i = 0; i < itemCount; i++) {
        
        // 2.1 根据 i 创建 indexPath
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        
        // 2.2 根据 indexPath 创建对应的 UICollectionViewLayoutAttributes
        UICollectionViewLayoutAttributes *attr = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
        
        // 2.3 设置 attr 中的 frame
        CGFloat cellH = arc4random_uniform(150) + 150;
        
        CGFloat minH = [[self.totalHeights valueForKeyPath:@"@min.floatValue"] floatValue];
        NSUInteger minIndex = [self.totalHeights indexOfObject:@(minH)];
   
        CGFloat cellX = self.sectionInset.left + (self.minimumInteritemSpacing + cellW) * minIndex;
        CGFloat cellY = minH + self.minimumLineSpacing;
        attr.frame = CGRectMake(cellX, cellY, cellW, cellH);
        
        // 2.4 保存 attr
        [self.cellAttrs addObject:attr];
        
        // 2.5 添加当前的高度
        self.totalHeights[minIndex] = @(minH + self.minimumLineSpacing + cellH);
    }
}

// 作用：返回一段区域内 cell 尺寸
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    return self.cellAttrs;
}

// 作用：计算collectionView滚动范围
- (CGSize)collectionViewContentSize
{
    CGFloat maxH = [[self.totalHeights valueForKeyPath:@"@max.floatValue"] floatValue];
    return CGSizeMake(0, maxH + self.sectionInset.bottom);
}


@end
