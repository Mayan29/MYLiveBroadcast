//
//  MYGiftKeyboardBottomView.h
//  MYGiftKeyboard
//
//  Created by mayan on 2017/10/17.
//  Copyright © 2017年 mayan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MYGiftKeyboardStyle;
@interface MYGiftKeyboardBottomView : UIView

- (instancetype)initWithFrame:(CGRect)frame style:(MYGiftKeyboardStyle *)style;

@property (nonatomic, copy) void (^commitBlock)(void);

- (void)setCommitButtonEnabled:(BOOL)enabled;

@end
