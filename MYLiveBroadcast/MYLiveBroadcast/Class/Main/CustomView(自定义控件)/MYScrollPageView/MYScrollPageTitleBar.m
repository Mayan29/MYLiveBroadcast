//
//  MYScrollPageTitleBar.m
//  MYScrollPageView
//
//  Created by mayan on 2017/10/11.
//  Copyright © 2017年 mayan. All rights reserved.
//

#import "MYScrollPageTitleBar.h"
#import "MYScrollPageStyle.h"

@interface MYScrollPageTitleBar ()

@property (nonatomic, strong) NSArray<NSString *> *titles;
@property (nonatomic, strong) MYScrollPageStyle   *style;

@property (nonatomic, strong) UIView *lineView; // 文字下方滚动条

@property (nonatomic, assign) NSInteger currentLabelTag;  // 当前选择的 titleLabel 的 tag

@end

@implementation MYScrollPageTitleBar

#pragma mark - Init
- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray<NSString *> *)titles style:(MYScrollPageStyle *)style
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.showsHorizontalScrollIndicator = NO;
        self.scrollsToTop = NO;
        
        _titles = titles;
        _style  = style;
        
        [self setupUI];
    }
    return self;
}

- (void)setupUI
{
    // 遍历设置 titleLabel
    [_titles enumerateObjectsUsingBlock:^(NSString *title, NSUInteger idx, BOOL * _Nonnull stop) {
        
        // 创建 titleLabel
        UILabel *label = [[UILabel alloc] init];
        label.text          = title;
        label.textColor     = _style.titleNormalColor;
        label.tag           = idx + 100;
        label.font          = _style.titleFont;
        label.textAlignment = NSTextAlignmentCenter;
        label.userInteractionEnabled = YES;
        [self addSubview:label];
        
        // 监听点击
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(titleLabelClick:)];
        [label addGestureRecognizer:tap];
        
        // 设置 frame
        CGFloat w = [title boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, _style.titleBarHeight) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : label.font} context:nil].size.width + _style.titleItemMargin;
        CGFloat x = (idx == 0) ? 0 : CGRectGetMaxX([self viewWithTag:(idx - 1 + 100)].frame);
        
        label.frame = CGRectMake(x, 0, w, _style.titleBarHeight);
        
        // 设置默认选择第一个 label
        if (idx == 0) {
            self.currentLabelTag = label.tag;
        }
    }];
    
    // 设置初始化默认文字颜色
    UILabel *firstLabel = [self viewWithTag:_currentLabelTag];
    firstLabel.textColor = _style.titleSelectedColor;
    
    // 设置初始化滚动条
    if (_style.isTitleScrollLineShow) {
        _lineView = [[UIView alloc] initWithFrame:CGRectMake(firstLabel.frame.origin.x, _style.titleBarHeight, firstLabel.frame.size.width, _style.titleScrollLineHeight)];
        _lineView.backgroundColor = _style.titleScrollLineColor;
        [self addSubview:_lineView];
    }
    
    // 设置 scrollView 滚动范围
    self.contentSize = CGSizeMake(CGRectGetMaxX([self viewWithTag:_titles.count - 1 + 100].frame), 0);
}

- (void)titleLabelClick:(UITapGestureRecognizer *)tapGesture
{
    if ([self.my_delegate respondsToSelector:@selector(scrollPageTitleBar:clickItem:)]) {
        [self.my_delegate scrollPageTitleBar:self clickItem:tapGesture.view.tag - 100];
    }
}

#pragma mark - Set
// 设置选中 label 滚动到的位置
- (void)setCurrentLabelTag:(NSInteger)currentLabelTag
{
    if (_currentLabelTag == currentLabelTag) return;

    _currentLabelTag = currentLabelTag;
    
    // 调整位置，使选中的 label 滚动到中间
    UILabel *currentLabel = [self viewWithTag:currentLabelTag];
    CGFloat offsetX = currentLabel.center.x - self.bounds.size.width * 0.5;
    if (offsetX < 0) {
        offsetX = 0;
    }
    if (offsetX > (self.contentSize.width - self.bounds.size.width)) {
        offsetX = self.contentSize.width - self.bounds.size.width;
    }
    [self setContentOffset:CGPointMake(offsetX, 0) animated:YES];
}

// 滑动中
- (void)scrollViewDidScroll:(UICollectionView *)collectionView direction:(NSString *)direction
{
    CGFloat num = collectionView.contentOffset.x / collectionView.bounds.size.width;
    
    NSInteger index  = floor(num);
    CGFloat progress = num - index;
    
    UILabel *oldLabel = nil;
    UILabel *newLabel = nil;
    
    if ([direction isEqualToString:@"向左"]) {
        
        self.currentLabelTag = index + 100;
        
        oldLabel = [self viewWithTag:(index + 100)];
        newLabel = [self viewWithTag:(index + 100 + 1)];

        // 底部滚动条位置
        if (_style.isTitleScrollLineShow) {
            CGFloat oldX = oldLabel.frame.origin.x;
            CGFloat oldW = oldLabel.frame.size.width;
            CGFloat newX = newLabel.frame.origin.x;
            CGFloat newW = newLabel.frame.size.width;
            CGFloat currentX = oldX + (newX - oldX) * progress;
            CGFloat currentW = oldW + (newW - oldW) * progress;
            _lineView.frame = CGRectMake(currentX, _lineView.frame.origin.y, currentW, _lineView.frame.size.height);
        }
        
        // 文字颜色
        CGFloat normalR, normalG, normalB, normalA = 0.0;
        CGFloat selectedR, selectedG, selectedB, selectedA = 0.0;
        [_style.titleNormalColor   getRed:&normalR green:&normalG blue:&normalB alpha:&normalA];
        [_style.titleSelectedColor getRed:&selectedR green:&selectedG blue:&selectedB alpha:&selectedA];
        
        CGFloat oldR = selectedR + (normalR - selectedR) * progress;
        CGFloat oldG = selectedG + (normalG - selectedG) * progress;
        CGFloat oldB = selectedB + (normalB - selectedB) * progress;
        CGFloat oldA = selectedA + (normalA - selectedA) * progress;
        CGFloat newR = normalR + (selectedR - normalR) * progress;
        CGFloat newG = normalG + (selectedG - normalG) * progress;
        CGFloat newB = normalB + (selectedB - normalB) * progress;
        CGFloat newA = normalA + (selectedA - normalA) * progress;
        oldLabel.textColor = [UIColor colorWithRed:oldR green:oldG blue:oldB alpha:oldA];
        newLabel.textColor = [UIColor colorWithRed:newR green:newG blue:newB alpha:newA];
        
    } else if ([direction isEqualToString:@"向右"]) {
        
        if (progress < 0.1) {
            self.currentLabelTag = index + 100;
        } else {
            self.currentLabelTag = index + 1 + 100;
        }
        
        oldLabel = [self viewWithTag:(index + 100 + 1)];
        newLabel = [self viewWithTag:(index + 100)];
        
        // 底部滚动条位置
        if (_style.isTitleScrollLineShow) {
            // 底部滚动条位置
            CGFloat oldX = oldLabel.frame.origin.x;
            CGFloat oldW = oldLabel.frame.size.width;
            CGFloat newX = newLabel.frame.origin.x;
            CGFloat newW = newLabel.frame.size.width;
            CGFloat currentX = newX + (oldX - newX) * progress;
            CGFloat currentW = newW + (oldW - newW) * progress;
            _lineView.frame = CGRectMake(currentX, _lineView.frame.origin.y, currentW, _lineView.frame.size.height);
        }
            
        // 文字颜色
        CGFloat normalR, normalG, normalB, normalA = 0.0;
        CGFloat selectedR, selectedG, selectedB, selectedA = 0.0;
        [_style.titleNormalColor   getRed:&normalR green:&normalG blue:&normalB alpha:&normalA];
        [_style.titleSelectedColor getRed:&selectedR green:&selectedG blue:&selectedB alpha:&selectedA];
        
        CGFloat oldR = normalR + (selectedR - normalR) * progress;
        CGFloat oldG = normalG + (selectedG - normalG) * progress;
        CGFloat oldB = normalB + (selectedB - normalB) * progress;
        CGFloat oldA = normalA + (selectedA - normalA) * progress;
        CGFloat newR = selectedR + (normalR - selectedR) * progress;
        CGFloat newG = selectedG + (normalG - selectedG) * progress;
        CGFloat newB = selectedB + (normalB - selectedB) * progress;
        CGFloat newA = selectedA + (normalA - selectedA) * progress;
        oldLabel.textColor = [UIColor colorWithRed:oldR green:oldG blue:oldB alpha:oldA];
        newLabel.textColor = [UIColor colorWithRed:newR green:newG blue:newB alpha:newA];
    }
}

@end
