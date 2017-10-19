//
//  MYGiftKeyboardBottomView.m
//  MYGiftKeyboard
//
//  Created by mayan on 2017/10/17.
//  Copyright © 2017年 mayan. All rights reserved.
//

#import "MYGiftKeyboardBottomView.h"
#import "MYGiftKeyboardStyle.h"

@interface MYGiftKeyboardBottomView ()

@property (nonatomic, strong) UIButton *commitButton;

@property (nonatomic, strong) UIColor *norColor;
@property (nonatomic, strong) UIColor *banColor;

@end

@implementation MYGiftKeyboardBottomView

- (instancetype)initWithFrame:(CGRect)frame style:(MYGiftKeyboardStyle *)style
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = style.bottomViewBackgroundColor;
        self.norColor        = style.bottomViewButtonBackgroundColor;
        self.banColor        = [UIColor grayColor];
        
        CGFloat buttonW = 100;
        CGFloat buttonH = frame.size.height - 20;
        CGFloat buttonX = frame.size.width - 10 - buttonW;
        CGFloat buttonY = (frame.size.height - buttonH) / 2;
        
        _commitButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _commitButton.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        _commitButton.layer.cornerRadius = _commitButton.bounds.size.height * 0.5;
        [_commitButton setBackgroundColor:_banColor];
        [_commitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_commitButton setTitle:@"发送" forState:UIControlStateNormal];
        [_commitButton addTarget:self action:@selector(commit) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_commitButton];
    }
    return self;
}

- (void)commit
{
    if (_commitButton.backgroundColor == _banColor) return;
    
    if (self.commitBlock) {
        self.commitBlock();
    }
}

- (void)setCommitButtonEnabled:(BOOL)enabled
{
    if (enabled) {
        [_commitButton setBackgroundColor:_norColor];
    } else {
        [_commitButton setBackgroundColor:_banColor];
    }
}

@end
