//
//  MYGiftKeyboardStyle.m
//  MYGiftKeyboard
//
//  Created by mayan on 2017/10/16.
//  Copyright © 2017年 mayan. All rights reserved.
//

#import "MYGiftKeyboardStyle.h"

@implementation MYGiftKeyboardStyle

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        
        // MYGiftKeyboard
        _keyboardHeight = [UIScreen mainScreen].bounds.size.height / 2;  // 键盘高度，默认是屏幕的一半
        
        
        // MYScrollPageTitleBar
        _titleBarHidden          = NO;                    // titleBar 是否隐藏，默认 NO
        _titleBarHeight          = 44;                    // titleBar 高度，默认 44
        _titleItemMargin         = 30;                    // titleItem 间隔，默认 30
        _titleBarBackgroundColor = [UIColor blackColor];  // titleBar 背景色，默认黑色

        _titleNormalColor   = [UIColor whiteColor];          // 文字未选中状态颜色，默认白色
        _titleSelectedColor = [UIColor orangeColor];         // 文字选中状态颜色，默认橘色
        _titleFont          = [UIFont systemFontOfSize:15];  // 文字大小，默认 15
        
        _titleScrollLineHeight = 2;                     // 文字下方滚动条高度，默认 2
        _titleScrollLineColor  = _titleSelectedColor;   // 文字下方滚动条颜色，默认橘色
        
        _isTitleScrollLineShow = YES;  // 文字下方滚动条是否显示，默认 YES
        
        
        // MYGiftKeyboardCollectionView
        _collectionViewBackgroundColor = _titleNormalColor;    // collection 背景色，默认白色
        _currentPageIndicatorTintColor = _titleSelectedColor;  // pageControl 选中的颜色，默认橘色
        _pageIndicatorTintColor        = [UIColor grayColor];  // pageControl 未选中的颜色，默认灰色
        
        
        // MYGiftKeyboardBottomView
        _bottomViewHeight                = _titleBarHeight;           // bottomView 高度，默认 44
        _bottomViewBackgroundColor       = _titleBarBackgroundColor;  // bottomView 背景色，默认黑色
        _bottomViewButtonBackgroundColor = _titleSelectedColor;       // bottomViewButton 背景色，默认橘色
    }
    return self;
}

@end
