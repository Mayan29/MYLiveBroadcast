//
//  MYPageViewStyle.h
//  MYPageView
//
//  Created by mayan on 2017/10/9.
//  Copyright © 2017年 mayan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MYPageViewStyle : NSObject

@property (nonatomic, assign) BOOL     isTitleScrollEnabel;   // 允许 titleScrollView 滚动，默认 YES
@property (nonatomic, assign) CGFloat  titleItemHeight;     // titleItem 高度，默认 44
@property (nonatomic, assign) CGFloat  titleItemMargin;     // titleItem 之间的间隔，默认 30

// 文字
@property (nonatomic, strong) UIColor* titleNormalColor;    // titleItem 文字未选中状态颜色，默认黑色
@property (nonatomic, strong) UIColor* titleSelectedColor;  // titleItem 文字选中状态颜色，默认橘色
@property (nonatomic, strong) UIFont*  titleFont;           // titleItem 文字大小

// 滚动条
@property (nonatomic, assign) BOOL     isShowTitleScrollLine;
@property (nonatomic, assign) CGFloat  titleScrollLineHeight;
@property (nonatomic, strong) UIColor* titleScrollLineColor;

@end
