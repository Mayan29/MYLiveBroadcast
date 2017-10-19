//
//  MYGiftKeyboard.m
//  MYGiftKeyboard
//
//  Created by mayan on 2017/10/16.
//  Copyright © 2017年 mayan. All rights reserved.
//

#import "MYGiftKeyboard.h"
#import "MYGiftKeyboardTitleBar.h"
#import "MYGiftKeyboardCollectionView.h"
#import "MYGiftKeyboardBottomView.h"

@interface MYGiftKeyboard () <MYScrollPageCollectionViewDelegate, MYGiftKeyboardTitleBarDelegate>

@property (nonatomic, strong) NSArray<NSString *> *titles;
@property (nonatomic, strong) MYGiftKeyboardStyle *style;
@property (nonatomic, strong) NSArray<NSArray<MYGiftKeyboardModel *> *> *models;

@property (nonatomic, strong) UIView                       *touchHiddenView;
@property (nonatomic, strong) MYGiftKeyboardTitleBar       *titleBar;
@property (nonatomic, strong) MYGiftKeyboardCollectionView *collectionView;
@property (nonatomic, strong) MYGiftKeyboardBottomView     *bottomView;

@end

@implementation MYGiftKeyboard

#pragma mark - Init
+ (instancetype)keyboardWithTitles:(NSArray<NSString *> *)titles
                             style:(MYGiftKeyboardStyle *)style
                            models:(NSArray<NSArray<MYGiftKeyboardModel *> *> *)models
{
    MYGiftKeyboard *keyboard = [[MYGiftKeyboard alloc] initWithTitles:titles style:style models:models];
    [keyboard hiddenKeyboard];
    return keyboard;
}

- (instancetype)initWithTitles:(NSArray<NSString *> *)titles
                         style:(MYGiftKeyboardStyle *)style
                        models:(NSArray<NSArray<MYGiftKeyboardModel *> *> *)models
{
    self = [super initWithFrame:[UIScreen mainScreen].bounds];
    if (self) {
        
        self.titles = titles;
        self.style  = style ? style : [[MYGiftKeyboardStyle alloc] init];
        self.models = models;
        
        CGRect frame = self.frame;
        frame.origin.y = frame.size.height - _touchHiddenView.bounds.size.height;
        self.frame = frame;

        [self setupUI];
    }
    return self;
}

- (void)setupUI
{
    CGRect touchHiddenF = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height - _style.keyboardHeight);
    
    CGFloat titleBarW = self.bounds.size.width;
    CGFloat titleBarH = _style.titleBarHidden ? 0 : (_style.titleBarHeight + (_style.isTitleScrollLineShow ? _style.titleScrollLineHeight : 0));
    CGRect  titleBarF = CGRectMake(0, CGRectGetMaxY(touchHiddenF), titleBarW, titleBarH);
    
    CGFloat collectionViewW = titleBarW;
    CGFloat collectionViewH = self.bounds.size.height - touchHiddenF.size.height - titleBarF.size.height - _style.bottomViewHeight;
    CGRect  collectionViewF = CGRectMake(0, CGRectGetMaxY(titleBarF), collectionViewW, collectionViewH);
    
    CGFloat bottomViewW = titleBarW;
    CGFloat bottomViewH = _style.bottomViewHeight;
    CGRect  bottomViewF = CGRectMake(0, CGRectGetMaxY(collectionViewF), bottomViewW, bottomViewH);
    
    __weak typeof(self)wself = self;
    
    _touchHiddenView = [[UIView alloc] initWithFrame:touchHiddenF];
    [self addSubview:_touchHiddenView];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenKeyboard)];
    [_touchHiddenView addGestureRecognizer:tap];
    
    if (!_style.titleBarHidden) {
        _titleBar = [[MYGiftKeyboardTitleBar alloc] initWithFrame:titleBarF titles:_titles style:_style];
        _titleBar.my_delegate = self;
        [self addSubview:_titleBar];
    }
    
    _collectionView = [[MYGiftKeyboardCollectionView alloc] initWithFrame:collectionViewF models:_models style:_style];
    _collectionView.my_delegate = self;
    _collectionView.selectedBlock = ^(void){
        [wself.bottomView setCommitButtonEnabled:(wself.collectionView.currentModel != nil)];
    };
    [self addSubview:_collectionView];
    
    _bottomView = [[MYGiftKeyboardBottomView alloc] initWithFrame:bottomViewF style:_style];
    _bottomView.commitBlock = ^{
        if (wself.commitClickBlock) {
            wself.commitClickBlock(wself.collectionView.currentModel);
        }
        [wself hiddenKeyboard];
    };
    [self addSubview:_bottomView];
}


#pragma mark - MYScrollPageTitleBarDelegate
// 点击 titleBarItem 改变 UICollectionView contentOffset
- (void)scrollPageTitleBar:(MYGiftKeyboardTitleBar *)scrollPageTitleBar clickItem:(NSInteger)item
{
    [_collectionView setContentOffsetItem:item];
}


#pragma mark - MYScrollPageCollectionViewDelegate
// 滑动 UICollectionView 改变 titleBar 文字颜色和底部滑动条
- (void)scrollViewDidScrollCurrentItem:(NSInteger)currentItem progress:(CGFloat)progress direction:(NSString *)direction
{
    if (!_style.titleBarHidden) {
        [_titleBar scrollViewDidScrollCurrentItem:currentItem progress:progress direction:direction];
    }
}
- (void)scrollViewDidEndDecelerating:(MYGiftKeyboardCollectionView *)giftKeyboardCollectionView
{
    if (!_style.titleBarHidden) {
        [_titleBar scrollViewDidEndDecelerating];
    }
}

#pragma mark - Other
- (void)showKeyboard
{
    self.userInteractionEnabled = YES;
    [UIView animateWithDuration:0.25 animations:^{
        CGRect frame = self.frame;
        frame.origin.y = 0;
        self.frame = frame;
    }];
}

- (void)hiddenKeyboard
{
    [UIView animateWithDuration:0.25 animations:^{
        CGRect frame = self.frame;
        frame.origin.y = frame.size.height - _touchHiddenView.bounds.size.height;
        self.frame = frame;
    } completion:^(BOOL finished) {
        self.userInteractionEnabled = NO;
    }];
}

@end
