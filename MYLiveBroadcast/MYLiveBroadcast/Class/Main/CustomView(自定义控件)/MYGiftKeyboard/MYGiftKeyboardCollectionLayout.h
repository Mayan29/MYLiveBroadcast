//
//  MYGiftKeyboardCollectionLayout.h
//  MYGiftKeyboard
//
//  Created by mayan on 2017/10/16.
//  Copyright © 2017年 mayan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MYGiftKeyboardCollectionLayout : UICollectionViewFlowLayout

@property (nonatomic, readonly, assign) NSInteger cols;
@property (nonatomic, readonly, assign) NSInteger rows;

- (instancetype)initWithCols:(NSInteger)cols rows:(NSInteger)rows;


@end
