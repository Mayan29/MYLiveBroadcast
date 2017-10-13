//
//  MYScrollPageTitleBar.h
//  MYScrollPageView
//
//  Created by mayan on 2017/10/11.
//  Copyright © 2017年 mayan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MYScrollPageTitleBar;
@protocol MYScrollPageTitleBarDelegate <NSObject>

// 点击 titleBar 滑动 UICollectionView
- (void)scrollPageTitleBar:(MYScrollPageTitleBar *)scrollPageTitleBar clickItem:(NSInteger)item;

@end

@class MYScrollPageStyle, MYScrollPageCollectionView;
@interface MYScrollPageTitleBar : UIScrollView

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray<NSString *> *)titles style:(MYScrollPageStyle *)style;

@property (nonatomic, weak) id<MYScrollPageTitleBarDelegate>my_delegate;
// 滑动 UICollectionView 改变 titleBar 文字颜色和底部滑动条
- (void)scrollViewDidScroll:(UICollectionView *)collectionView direction:(NSString *)direction;

@end
