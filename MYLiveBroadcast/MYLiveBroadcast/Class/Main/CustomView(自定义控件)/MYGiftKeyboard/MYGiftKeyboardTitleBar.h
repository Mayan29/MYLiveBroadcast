//
//  MYGiftKeyboardTitleBar.h
//  MYGiftKeyboard
//
//  Created by mayan on 2017/10/16.
//  Copyright © 2017年 mayan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MYGiftKeyboardTitleBar;
@protocol MYGiftKeyboardTitleBarDelegate <NSObject>

// 点击 titleBar 滑动 UICollectionView
- (void)scrollPageTitleBar:(MYGiftKeyboardTitleBar *)scrollPageTitleBar clickItem:(NSInteger)item;

@end

@class MYGiftKeyboardStyle, MYGiftKeyboardCollectionView;
@interface MYGiftKeyboardTitleBar : UIScrollView

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray<NSString *> *)titles style:(MYGiftKeyboardStyle *)style;

@property (nonatomic, weak) id<MYGiftKeyboardTitleBarDelegate>my_delegate;
// 滑动 UICollectionView 改变 titleBar 文字颜色和底部滑动条
- (void)scrollViewDidScrollCurrentItem:(NSInteger)currentItem progress:(CGFloat)progress direction:(NSString *)direction;
- (void)scrollViewDidEndDecelerating;


@end
