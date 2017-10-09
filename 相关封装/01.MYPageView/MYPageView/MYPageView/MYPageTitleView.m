//
//  MYPageTitleView.h
//  MYPageView
//
//  Created by mayan on 2017/9/28.
//  Copyright © 2017年 mayan. All rights reserved.
//

#import "MYPageTitleView.h"
#import "MYPageView.h"

@interface MYPageTitleView ()

@property (nonatomic, strong) NSArray <NSString *>*titles;
@property (nonatomic, strong) MYPageViewStyle *style;

@property (nonatomic, strong) UILabel *currentLabel;  // 当前选择的 titleLabel
@property (nonatomic, strong) UIView  *lineView;

@end

@implementation MYPageTitleView

#pragma mark - Init
- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray<NSString *> *)titles style:(MYPageViewStyle *)style
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.showsHorizontalScrollIndicator = NO;
        self.scrollsToTop = NO;
        
        _titles = titles;
        _style  = style;
       
        [self setupUI];
        
        // 注册通知（滚动 contentView 改变 titleView 位置和状态）
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pageContentViewMakePageTitleViewScroll:) name:@"MYPageContentViewMakeMYPageTitleViewScroll" object:nil];
    }
    return self;
}

- (void)setupUI
{
    // 设置滚动条
    if (_style.isShowTitleScrollLine) {
        _lineView = [[UIView alloc] initWithFrame:CGRectMake(0, _style.titleItemHeight, 0, _style.titleScrollLineHeight)];
        _lineView.backgroundColor = _style.titleScrollLineColor;
        [self addSubview:_lineView];
    }
    
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
        CGFloat w = 0;
        CGFloat h = _style.titleItemHeight;
        CGFloat x = 0;
        CGFloat y = 0;
        
        if (_style.isTitleScrollEnabel) {
            w = [title boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, h) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : label.font} context:nil].size.width + _style.titleItemMargin;
            if (idx == 0) {
                x = 0;
            } else {
                x = CGRectGetMaxX([self viewWithTag:(idx - 1 + 100)].frame);
            }
        } else {
            w = self.bounds.size.width / _titles.count;
            x = w * idx;
        }
        label.frame = CGRectMake(x, y, w, h);
        
        // 设置默认选择第一个 label
        if (idx == 0) [self titleLabelClick:tap];
    }];
    
    // 设置 scrollView 滚动范围
    self.contentSize = CGSizeMake(CGRectGetMaxX([self viewWithTag:_titles.count - 1 + 100].frame), 0);
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - NSNotification
- (void)pageContentViewMakePageTitleViewScroll:(NSNotification *)notification
{
    NSUInteger row = [notification.object integerValue];
    
    // 设置选中 label 颜色和滚动到的位置
    self.currentLabel = [self viewWithTag:row + 100];
}

- (void)titleLabelClick:(UITapGestureRecognizer *)tapGesture
{
    // 设置选中 label 颜色和滚动到的位置
    self.currentLabel = (UILabel *)tapGesture.view;
    
    // 使 contentView 滚动到相应的位置
    [[NSNotificationCenter defaultCenter] postNotificationName:@"MYPageTitleViewMakeMYPageContentViewScroll" object:@(self.currentLabel.tag - 100)];
}

#pragma mark - Set
// 设置选中 label 颜色和滚动到的位置
- (void)setCurrentLabel:(UILabel *)currentLabel
{
    if (currentLabel == _currentLabel) return;
    
    _currentLabel.textColor = _style.titleNormalColor;
    _currentLabel = currentLabel;
    _currentLabel.textColor = _style.titleSelectedColor;
    
    // 滚动条滚到选中 label 下方
    if (_style.isShowTitleScrollLine) {
        [UIView animateWithDuration:0.2 animations:^{
            CGRect frame = _lineView.frame;
            frame.size.width = _currentLabel.frame.size.width - _style.titleItemMargin;
            frame.origin.x   = _currentLabel.frame.origin.x + _style.titleItemMargin * 0.5;
            _lineView.frame = frame;
        }];
    }

    // 调整位置，使选中的 label 滚动到中间
    if (_style.isTitleScrollEnabel) {
        CGFloat offsetX = _currentLabel.center.x - self.bounds.size.width * 0.5;
        if (offsetX < 0) {
            offsetX = 0;
        }
        if (offsetX > (self.contentSize.width - self.bounds.size.width)) {
            offsetX = self.contentSize.width - self.bounds.size.width;
        }
        [self setContentOffset:CGPointMake(offsetX, 0) animated:YES];
    }
}


@end
