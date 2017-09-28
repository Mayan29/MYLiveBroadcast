//
//  UIBarButtonItem+Extension.m
//  MYNewProject
//
//  Created by mayan on 2017/3/7.
//  Copyright © 2017年 mayan. All rights reserved.
//

#import "UIBarButtonItem+Extension.h"

@implementation UIBarButtonItem (Extension)


+ (instancetype)my_itemWithTarget:(id)target action:(SEL)action image:(NSString *)image higImage:(NSString *)higImage
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [btn setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:higImage] forState:UIControlStateHighlighted];
    btn.size = btn.currentBackgroundImage.size;
    
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}

+ (instancetype)my_itemWithTarget:(id)target action:(SEL)action image:(NSString *)image selImage:(NSString *)selImage
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [btn setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:selImage] forState:UIControlStateSelected];
    btn.size = btn.currentBackgroundImage.size;
    
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}

+ (instancetype)my_itemWithTarget:(id)target action:(SEL)action title:(NSString *)title
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];  // 以下几种属性依照具体UI风格调整
    [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateHighlighted];
    [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
    btn.titleLabel.font = SYS_FONT(15);
    [btn sizeToFit];
    
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}


@end
