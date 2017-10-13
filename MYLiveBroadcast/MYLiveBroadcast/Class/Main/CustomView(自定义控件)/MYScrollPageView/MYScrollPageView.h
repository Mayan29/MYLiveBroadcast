//
//  MYScrollPageView.h
//  MYScrollPageView
//
//  Created by mayan on 2017/10/11.
//  Copyright © 2017年 mayan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MYScrollPageStyle.h"

@interface MYScrollPageView : UIView

@property (nonatomic, readonly, strong) NSArray <UIViewController *>*childVCs;

- (instancetype)initWithFrame:(CGRect)frame
                       titles:(NSArray<NSString *> *)titles
                     childVCs:(NSArray<UIViewController *> *)childVCs
                        style:(MYScrollPageStyle *)style;

@end
