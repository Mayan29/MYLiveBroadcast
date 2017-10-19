//
//  MYGiftKeyboardCollectionViewCell.m
//  MYGiftKeyboard
//
//  Created by mayan on 2017/10/18.
//  Copyright © 2017年 mayan. All rights reserved.
//

#import "MYGiftKeyboardCollectionViewCell.h"
#import "MYGiftKeyboardModel.h"

// RGB颜色
#define MYColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
// 随机色
#define MYRandomColor MYColor(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))

@interface MYGiftKeyboardCollectionViewCell ()

@property (nonatomic, strong) MYGiftKeyboardModel *model;

@end

@implementation MYGiftKeyboardCollectionViewCell

#pragma mark - Init
+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView indexPath:(NSIndexPath *)indexPath model:(MYGiftKeyboardModel *)model
{
    MYGiftKeyboardCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[self identifier] forIndexPath:indexPath];
    cell.backgroundColor   = MYRandomColor;
    cell.layer.borderColor = [UIColor orangeColor].CGColor;
    cell.model             = model;
    [cell my_setSelected:NO];
    
    return cell;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = MYRandomColor;
    }
    return self;
}

#pragma mark - Set
- (void)setModel:(MYGiftKeyboardModel *)model
{
    _model = model;
    
    // 这里设置模型属性
}

#pragma mark - Other
+ (NSString *)identifier
{
    return @"MYContentViewCell";
}

- (void)my_setSelected:(BOOL)selected
{    
    if (selected) {
        self.layer.borderWidth = 2;
    } else {
        self.layer.borderWidth = 0;
    }
}

@end
