//
//  MYGiftKeyboardCollectionView.m
//  MYGiftKeyboard
//
//  Created by mayan on 2017/10/16.
//  Copyright © 2017年 mayan. All rights reserved.
//

#import "MYGiftKeyboardCollectionView.h"
#import "MYGiftKeyboardCollectionLayout.h"
#import "MYGiftKeyboardCollectionViewCell.h"
#import "MYGiftKeyboardStyle.h"
#import "MYGiftKeyboardModel.h"

@interface MYGiftKeyboardCollectionView () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) MYGiftKeyboardCollectionLayout *layout;
@property (nonatomic, strong) UICollectionView               *collectionView;
@property (nonatomic, strong) UIPageControl                  *pageControl;

@property (nonatomic, strong) NSArray<NSArray<MYGiftKeyboardModel *> *> *models;
@property (nonatomic, strong) MYGiftKeyboardStyle *style;
@property (nonatomic, assign) CGFloat beginDraggingContentOffset;

@property (nonatomic, strong) NSMutableDictionary *sections;  // key：页数 value：组数

@end

@implementation MYGiftKeyboardCollectionView

#pragma mark - Init
- (instancetype)initWithFrame:(CGRect)frame
                       models:(NSArray<NSArray<MYGiftKeyboardModel *> *> *)models
                        style:(MYGiftKeyboardStyle *)style
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _models = models;
        _style  = style;
        self.backgroundColor = style.collectionViewBackgroundColor;
        
        MYGiftKeyboardCollectionLayout *layout = [[MYGiftKeyboardCollectionLayout alloc] initWithCols:4 rows:2];
        layout.sectionInset = UIEdgeInsetsMake(10, 10, 0, 10);
        layout.minimumLineSpacing = 10;
        layout.minimumInteritemSpacing = 10;
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _layout = layout;
        
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height - 15) collectionViewLayout:layout];
        collectionView.delegate                       = self;
        collectionView.dataSource                     = self;
        collectionView.pagingEnabled                  = YES;
        collectionView.scrollsToTop                   = NO;
        collectionView.showsHorizontalScrollIndicator = NO;
        collectionView.bounces                        = NO;
        collectionView.backgroundColor                = self.backgroundColor;
        [collectionView registerClass:[MYGiftKeyboardCollectionViewCell class] forCellWithReuseIdentifier:MYGiftKeyboardCollectionViewCell.identifier];
        [self addSubview:collectionView];
        _collectionView = collectionView;
        
        // 获取每页对应的 section
        _sections = [NSMutableDictionary dictionary];
        NSInteger pageNum = 0;
        for (int section = 0; section < models.count; section++) {
            NSInteger pages = ceilf(models[section].count * 1.0 / (layout.cols * layout.rows));
            for (int row = 0; row < pages; row++) {
                _sections[@(pageNum)] = @(section);
                pageNum++;
            }
        }
        
        UIPageControl *control = [[UIPageControl alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(collectionView.frame), frame.size.width, 15)];
        control.numberOfPages                 = ceilf(models.firstObject.count * 1.0 / (layout.cols * layout.rows));
        control.backgroundColor               = self.backgroundColor;
        control.currentPageIndicatorTintColor = style.currentPageIndicatorTintColor;
        control.pageIndicatorTintColor        = style.pageIndicatorTintColor;
        control.userInteractionEnabled        = NO;
        [self addSubview:control];
        _pageControl = control;
    }
    return self;
}

#pragma mark - UICollectionView Delegate and Data Source
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return _models.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _models[section].count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MYGiftKeyboardModel *model = _models[indexPath.section][indexPath.item];
    
    return [MYGiftKeyboardCollectionViewCell cellWithCollectionView:collectionView
                                                          indexPath:indexPath
                                                              model:model];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    MYGiftKeyboardModel *model = _models[indexPath.section][indexPath.item];
    
    MYGiftKeyboardCollectionViewCell *cell = (MYGiftKeyboardCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    [cell my_setSelected:(model != _currentModel)];
    
    _currentModel = (model == _currentModel) ? nil : model;
    
    if (self.selectedBlock) {
        self.selectedBlock();
    }
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    MYGiftKeyboardCollectionViewCell *cell = (MYGiftKeyboardCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    [cell my_setSelected:NO];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSInteger currentItem = floor(scrollView.contentOffset.x / self.bounds.size.width);
    
    CGFloat progress = scrollView.contentOffset.x / self.bounds.size.width - currentItem;
    if ([_sections[@(currentItem)] integerValue] == [_sections[@(currentItem + 1)] integerValue]) progress = 0;
    
    CGFloat num = scrollView.contentOffset.x - _beginDraggingContentOffset;
    NSString *direction;
    if (num > 0) {
        direction = @"向左";
    } else if (num < 0) {
        direction = @"向右";
    }
    
    if ([self.my_delegate respondsToSelector:@selector(scrollViewDidScrollCurrentItem:progress:direction:)]) {
        [self.my_delegate scrollViewDidScrollCurrentItem:[_sections[@(currentItem)] integerValue] progress:progress direction:direction];
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    _beginDraggingContentOffset = scrollView.contentOffset.x;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self changePageControl];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    if ([self.my_delegate respondsToSelector:@selector(scrollViewDidEndDecelerating:)]) {
        [self.my_delegate scrollViewDidEndDecelerating:self];
    }
    [self changePageControl];
}


#pragma mark - Set
// 点击 titleBar 改变 UICollectionView 滑动位置
- (void)setContentOffsetItem:(NSInteger)item
{
    __block CGFloat contentOffsetX = 0;
    [_sections enumerateKeysAndObjectsUsingBlock:^(NSNumber *key, NSNumber *value, BOOL * _Nonnull stop) {
        if (value.integerValue < item) {
            contentOffsetX += self.bounds.size.width;
        }
    }];
    [_collectionView setContentOffset:CGPointMake(contentOffsetX, 0) animated:YES];
}

#pragma mark - Other
// 滑动停止时，改变 pageControl 的 numberOfPages 和 currentPage
- (void)changePageControl
{
    // 当前页数
    NSInteger currentItem = _collectionView.contentOffset.x / self.bounds.size.width;
    // 当前组数
    NSInteger currentSection = [_sections[@(currentItem)] integerValue];
    // 当前item
    NSInteger currentPage = 0;
    for (NSInteger i = currentItem - 1; i >= 0; i--) {
        if ([_sections[@(i)] integerValue] != currentSection) break;
        currentPage++;
    }
    
    _pageControl.numberOfPages = ceilf(_models[currentSection].count * 1.0 / (_layout.cols * _layout.rows));
    _pageControl.currentPage = currentPage;
}

@end
