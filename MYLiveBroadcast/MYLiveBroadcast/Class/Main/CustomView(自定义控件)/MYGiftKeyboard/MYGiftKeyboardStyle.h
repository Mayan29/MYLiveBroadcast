//
//  MYGiftKeyboardStyle.h
//  MYGiftKeyboard
//
//  Created by mayan on 2017/10/16.
//  Copyright © 2017年 mayan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MYGiftKeyboardStyle : NSObject

// MYGiftKeyboard
@property (nonatomic, assign) CGFloat keyboardHeight;  // 键盘高度，默认是屏幕的一半

// MYGiftKeyboardTitleBar
@property (nonatomic, assign) BOOL     titleBarHidden;           // titleBar 是否隐藏，默认 NO
@property (nonatomic, assign) CGFloat  titleBarHeight;           // titleBar 高度，默认 44
@property (nonatomic, assign) CGFloat  titleItemMargin;          // titleItem 间隔，默认 30
@property (nonatomic, assign) UIColor *titleBarBackgroundColor;  // titleBar 背景色，默认黑色

@property (nonatomic, strong) UIColor  *titleNormalColor;    // 文字未选中状态颜色，默认白色
@property (nonatomic, strong) UIColor  *titleSelectedColor;  // 文字选中状态颜色，默认橘色
@property (nonatomic, assign) UIFont   *titleFont;           // 文字大小，默认 15

@property (nonatomic, assign) CGFloat  titleScrollLineHeight;  // 文字下方滚动条高度，默认 2
@property (nonatomic, strong) UIColor *titleScrollLineColor;   // 文字下方滚动条颜色，默认橘色

@property (nonatomic, assign) BOOL isTitleScrollLineShow;  // 文字下方滚动条是否显示，默认 YES

// MYGiftKeyboardCollectionView
@property (nonatomic, strong) UIColor *collectionViewBackgroundColor;  // collection 背景色，默认白色
@property (nonatomic, strong) UIColor *currentPageIndicatorTintColor;  // pageControl 选中的颜色，默认橘色
@property (nonatomic, strong) UIColor *pageIndicatorTintColor;         // pageControl 未选中的颜色，默认灰色

// MYGiftKeyboardBottomView
@property (nonatomic, assign) CGFloat  bottomViewHeight;                 // bottomView 高度，默认 44
@property (nonatomic, assign) UIColor *bottomViewBackgroundColor;        // bottomView 背景色，默认黑色
@property (nonatomic, assign) UIColor *bottomViewButtonBackgroundColor;  // bottomViewButton 背景色，默认橘色

@end
