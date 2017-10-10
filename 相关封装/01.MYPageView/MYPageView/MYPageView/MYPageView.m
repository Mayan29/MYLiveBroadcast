//
//  MYPageView.m
//  MYPageView
//
//  Created by mayan on 2017/9/28.
//  Copyright © 2017年 mayan. All rights reserved.
//

#import "MYPageView.h"
#import "MYPageViewStyle.h"
#import "MYPageTitleView.h"
#import "MYPageContentView.h"

@interface MYPageView ()

@property (nonatomic, strong) NSArray <NSString *>*titles;
@property (nonatomic, strong) NSArray <UIViewController *>*childVCs;
@property (nonatomic, strong) MYPageViewStyle *style;

@end

@implementation MYPageView

- (instancetype)initWithFrame:(CGRect)frame
                       titles:(NSArray<NSString *> *)titles
                     childVCs:(NSArray<UIViewController *> *)childVCs
                        style:(MYPageViewStyle *)style
{
    self = [super initWithFrame:frame];
    if (self) {
        
        NSAssert(titles.count == childVCs.count, @"titles.count 和 childVCs.count 不相等");
        
        _titles   = titles;
        _childVCs = childVCs;
        _style    = style ? style : [[MYPageViewStyle alloc] init];
        
        [self setupUI];
    }
    return self;
}

- (void)setupUI
{
    CGFloat titleViewH = _style.titleItemHeight + (_style.isShowTitleScrollLine ? _style.titleScrollLineHeight : 0);
    
    CGRect titleViewF = CGRectMake(0, 0, self.bounds.size.width, titleViewH);
    CGRect contentViewF = CGRectMake(0, CGRectGetMaxY(titleViewF), self.bounds.size.width, self.bounds.size.height - _style.titleItemHeight);
    
    MYPageTitleView *titleView = [[MYPageTitleView alloc] initWithFrame:titleViewF titles:_titles style:_style];
    [self addSubview:titleView];
    
    MYPageContentView *contentView = [[MYPageContentView alloc] initWithFrame:contentViewF childVCs:_childVCs];
    [self addSubview:contentView];    
}

@end
