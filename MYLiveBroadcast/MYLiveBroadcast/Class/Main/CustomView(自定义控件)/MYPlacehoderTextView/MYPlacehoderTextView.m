//
//  ViewController.h
//  MYPlacehoderTextView
//
//  Created by mayan on 2017/10/23.
//  Copyright © 2017年 mayan. All rights reserved.
//

#import "MYPlacehoderTextView.h"

@implementation MYPlacehoderTextView


#pragma mark - Init
- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:self];
}

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

- (void)drawRect:(CGRect)rect
{
    if (self.hasText) return;  // 如果有文字就直接返回
    if (!self.placeholder.length) return;
    
    NSDictionary *attrs = @{
                            NSFontAttributeName : self.font ?: [UIFont systemFontOfSize:12],
                            NSForegroundColorAttributeName : self.placeholderColor ?: [UIColor grayColor]
                            };
    [self.placeholder drawInRect:CGRectMake(5, 7, rect.size.width - 10, rect.size.height - 14) withAttributes:attrs];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self setNeedsDisplay];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


#pragma mark - Set
- (void)setPlaceholder:(NSString *)placeholder
{
    _placeholder = placeholder;
    
    [self setNeedsDisplay];
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor
{
    _placeholderColor = placeholderColor;
    
    [self setNeedsDisplay];
}

- (void)setFont:(UIFont *)font
{
    [super setFont:font];
    
    [self setNeedsDisplay];
}

- (void)setText:(NSString *)text
{
    [super setText:text];
    
    [self setNeedsDisplay];
}

- (void)setAttributedText:(NSAttributedString *)attributedText
{
    [super setAttributedText:attributedText];
    
    [self setNeedsDisplay];
}


@end
