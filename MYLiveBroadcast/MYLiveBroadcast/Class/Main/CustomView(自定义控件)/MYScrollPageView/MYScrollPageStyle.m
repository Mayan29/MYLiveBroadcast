//
//  MYScrollPageStyle.m
//  MYScrollPageView
//
//  Created by mayan on 2017/10/11.
//  Copyright © 2017年 mayan. All rights reserved.
//

#import "MYScrollPageStyle.h"

@implementation MYScrollPageStyle

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        // MYScrollPageView
        
        // MYScrollPageTitleBar
        _titleBarHeight  = 44;  // titleBar 高度，默认 44
        _titleItemMargin = 30;  // titleItem 间隔，默认 30
        
        _titleNormalColor   = [UIColor blackColor];          // 文字未选中状态颜色，默认黑色
        _titleSelectedColor = [UIColor orangeColor];         // 文字选中状态颜色，默认橘色
        _titleFont          = [UIFont systemFontOfSize:15];  // 文字大小，默认 15
        
        _titleScrollLineHeight = 2;                     // 文字下方滚动条高度，默认 2
        _titleScrollLineColor  = _titleSelectedColor;   // 文字下方滚动条颜色，默认橘色
       
        _isTitleScrollLineShow = YES;  // 文字下方滚动条是否显示，默认 YES

        // MYScrollPageCollectionView
    }
    return self;
}



@end
