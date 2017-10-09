//
//  MYPageTitleView.h
//  MYPageView
//
//  Created by mayan on 2017/9/28.
//  Copyright © 2017年 mayan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MYPageViewStyle;
@interface MYPageTitleView : UIScrollView

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray <NSString *>*)titles style:(MYPageViewStyle *)style;

@end
