//
//  MYGiftKeyboard.h
//  MYGiftKeyboard
//
//  Created by mayan on 2017/10/16.
//  Copyright © 2017年 mayan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MYGiftKeyboardStyle.h"
#import "MYGiftKeyboardModel.h"

@interface MYGiftKeyboard : UIView

+ (instancetype)keyboardWithTitles:(NSArray<NSString *> *)titles
                             style:(MYGiftKeyboardStyle *)style
                            models:(NSArray<NSArray<MYGiftKeyboardModel *> *> *)models;

@property (nonatomic, copy) void(^commitClickBlock)(MYGiftKeyboardModel *model);


// 弹起键盘
- (void)showKeyboard;


@end
