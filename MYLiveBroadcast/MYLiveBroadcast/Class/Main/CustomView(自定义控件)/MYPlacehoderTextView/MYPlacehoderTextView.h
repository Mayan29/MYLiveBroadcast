//
//  ViewController.h
//  MYPlacehoderTextView
//
//  Created by mayan on 2017/10/23.
//  Copyright © 2017年 mayan. All rights reserved.
//
//  带有占位文字

#import <UIKit/UIKit.h>

@interface MYPlacehoderTextView : UITextView

@property (nonatomic, strong) NSString *placeholder;
@property (nonatomic, strong) UIColor  *placeholderColor;  // 默认灰色


@end
