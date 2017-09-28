//
//  MYPlacehoderTextView.m
//  MYNewProject
//
//  Created by mayan on 2017/3/7.
//  Copyright © 2017年 mayan. All rights reserved.
//

#import "MYPlacehoderTextView.h"

@implementation MYPlacehoderTextView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:self];
    }
    return self;
}
- (void)textDidChange
{
    [self setNeedsDisplay];
}

- (void)setPlaceholder:(NSString *)placeholder
{
    _placeholder = placeholder;
    
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{
    if (self.hasText) return;  // 如果有文字就直接返回
    
    NSDictionary *attrs = @{
                            NSFontAttributeName : self.font,
                            NSForegroundColorAttributeName : [UIColor lightGrayColor]
                            };
    [self.placeholder drawInRect:CGRectMake(5, 8, rect.size.width - 10, rect.size.height - 16)
                  withAttributes:attrs];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
