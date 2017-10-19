//
//  MYGiftKeyboardCollectionView.h
//  MYGiftKeyboard
//
//  Created by mayan on 2017/10/16.
//  Copyright © 2017年 mayan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MYGiftKeyboardCollectionView;
@protocol MYScrollPageCollectionViewDelegate <NSObject>

// 滑动 UICollectionView 改变 titleBar 文字颜色和底部滑动条
- (void)scrollViewDidScrollCurrentItem:(NSInteger)currentItem progress:(CGFloat)progress direction:(NSString *)direction;
- (void)scrollViewDidEndDecelerating:(MYGiftKeyboardCollectionView *)giftKeyboardCollectionView;

@end


@class MYGiftKeyboardStyle, MYGiftKeyboardModel;
@interface MYGiftKeyboardCollectionView : UIView

- (instancetype)initWithFrame:(CGRect)frame
                       models:(NSArray<NSArray<MYGiftKeyboardModel *> *> *)models
                        style:(MYGiftKeyboardStyle *)style;

@property (nonatomic, weak) id<MYScrollPageCollectionViewDelegate> my_delegate;
// 点击 titleBar 改变 UICollectionView 滑动位置
- (void)setContentOffsetItem:(NSInteger)item;


@property (nonatomic, readonly, strong) MYGiftKeyboardModel *currentModel;
@property (nonatomic, copy) void(^selectedBlock)(void);


@end
