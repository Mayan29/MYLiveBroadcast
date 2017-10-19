//
//  MYGiftKeyboardCollectionViewCell.h
//  MYGiftKeyboard
//
//  Created by mayan on 2017/10/18.
//  Copyright © 2017年 mayan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MYGiftKeyboardModel;
@interface MYGiftKeyboardCollectionViewCell : UICollectionViewCell

+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView indexPath:(NSIndexPath *)indexPath model:(MYGiftKeyboardModel *)model;

+ (NSString *)identifier;

- (void)my_setSelected:(BOOL)selected;

@end
