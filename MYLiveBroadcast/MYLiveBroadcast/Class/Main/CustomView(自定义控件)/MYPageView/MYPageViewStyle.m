//
//  MYPageViewStyle.m
//  MYPageView
//
//  Created by mayan on 2017/10/9.
//  Copyright © 2017年 mayan. All rights reserved.
//

#import "MYPageViewStyle.h"

@implementation MYPageViewStyle

- (instancetype)init
{
    self = [super init];
    if (self) {
        _isTitleScrollEnabel   = YES;
        _isShowTitleScrollLine = YES;
        _titleItemHeight       = 44;
        _titleItemMargin       = 30;
        _titleScrollLineHeight = 2;
        _titleNormalColor      = [UIColor blackColor];
        _titleSelectedColor    = [UIColor orangeColor];
        _titleFont             = [UIFont systemFontOfSize:15];
        _titleScrollLineColor  = _titleSelectedColor;
    }
    return self;
}

@end
