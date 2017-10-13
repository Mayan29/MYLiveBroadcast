//
//  MYScrollPageCollectionView.h
//  MYScrollPageView
//
//  Created by mayan on 2017/10/11.
//  Copyright © 2017年 mayan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MYScrollPageCollectionView;
@protocol MYScrollPageCollectionViewDelegate <NSObject>

// 滑动 UICollectionView 改变 titleBar 文字颜色和底部滑动条
- (void)scrollViewDidScroll:(MYScrollPageCollectionView *)scrollPageCollectionView direction:(NSString *)direction;

@end


@class MYScrollPageStyle;
@interface MYScrollPageCollectionView : UICollectionView

- (instancetype)initWithFrame:(CGRect)frame childVCs:(NSArray<UIViewController *> *)childVCs;

@property (nonatomic, weak) id<MYScrollPageCollectionViewDelegate> my_delegate;

@end
