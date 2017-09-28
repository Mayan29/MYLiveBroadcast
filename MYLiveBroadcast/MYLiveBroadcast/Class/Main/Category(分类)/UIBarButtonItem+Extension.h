//
//  UIBarButtonItem+Extension.h
//  MYNewProject
//
//  Created by mayan on 2017/3/7.
//  Copyright © 2017年 mayan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extension)

+ (instancetype)my_itemWithTarget:(id)target action:(SEL)action image:(NSString *)image higImage:(NSString *)hightImage;
+ (instancetype)my_itemWithTarget:(id)target action:(SEL)action image:(NSString *)image selImage:(NSString *)selImage;

+ (instancetype)my_itemWithTarget:(id)target action:(SEL)action title:(NSString *)title;


@end
