//
//  MYGiftKeyboardCollectionLayout.m
//  MYGiftKeyboard
//
//  Created by mayan on 2017/10/16.
//  Copyright © 2017年 mayan. All rights reserved.
//

#import "MYGiftKeyboardCollectionLayout.h"

@interface MYGiftKeyboardCollectionLayout ()
{
    NSInteger _cols;
    NSInteger _rows;
}

@property (nonatomic, strong) NSMutableArray<UICollectionViewLayoutAttributes *> *cellAttrs;
@property (nonatomic, assign) CGFloat maxWidth;

@end

@implementation MYGiftKeyboardCollectionLayout

#pragma mark - init
- (instancetype)initWithCols:(NSInteger)cols rows:(NSInteger)rows
{
    self = [super init];
    if (self) {
        _cols = cols;
        _rows = rows;
    }
    return self;
}

- (NSInteger)cols
{
    return _cols;
}

- (NSInteger)rows
{
    return _rows;
}


#pragma mark - lazy load
- (NSMutableArray<UICollectionViewLayoutAttributes *> *)cellAttrs
{
    if (!_cellAttrs) {
        _cellAttrs = [NSMutableArray array];
    }
    return _cellAttrs;
}

- (CGFloat)maxWidth
{
    if (!_maxWidth) {
        _maxWidth = 0;
    }
    return _maxWidth;
}


#pragma mark - delegate
// 什么时候调用：第一次布局、collectionView 刷新
// 作用：计算 cell 布局（条件：cell 的位置固定不变）
- (void)prepareLayout
{
    [super prepareLayout];
    
    // 0.计算item宽度&高度
    CGFloat itemW = (self.collectionView.bounds.size.width - self.sectionInset.left - self.sectionInset.right - self.minimumInteritemSpacing * (_cols - 1)) / _cols;
    CGFloat itemH = (self.collectionView.bounds.size.height - self.sectionInset.top - self.sectionInset.bottom - self.minimumInteritemSpacing * (_rows - 1)) / _rows;
    
    // 1.获取一共多少组
    NSInteger sectionCount = self.collectionView.numberOfSections;
    
    // 2.获取每组中有多少个 Item
    NSInteger prePageCount = 0;
    for (int i = 0; i < sectionCount; i++) {
        NSInteger itemCount = [self.collectionView numberOfItemsInSection:i];
        for (int j = 0; j < itemCount; j++) {
            // 2.1.获取Cell对应的 indexPath
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:j inSection:i];
            // 2.2.根据 indexPath 创建 UICollectionViewLayoutAttributes
            UICollectionViewLayoutAttributes *attr = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
            // 2.3.计算j在该组中第几页
            NSInteger page = j / (_cols * _rows);
            NSInteger index = j % (_cols * _rows);
            // 2.4.设置attr的frame
            CGFloat itemX = (prePageCount + page) * self.collectionView.bounds.size.width + self.sectionInset.left + (itemW + self.minimumInteritemSpacing) * (index % _cols);
            CGFloat itemY = self.sectionInset.top + (itemH + self.minimumInteritemSpacing) * (index / _cols);
            attr.frame = CGRectMake(itemX, itemY, itemW, itemH);
            // 2.5.保存attr到数组中
            [self.cellAttrs addObject:attr];
        }
        prePageCount += (itemCount - 1) / (_cols * _rows) + 1;
    }
    
    // 3.计算最大Y值
    self.maxWidth = prePageCount * self.collectionView.bounds.size.width;
}

// 作用：返回一段区域内 cell 尺寸
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    return self.cellAttrs;
}

// 作用：计算collectionView滚动范围
- (CGSize)collectionViewContentSize
{
    return CGSizeMake(self.maxWidth, 0);
}


@end
