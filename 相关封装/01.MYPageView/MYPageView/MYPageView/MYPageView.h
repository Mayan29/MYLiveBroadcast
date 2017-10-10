//
//  MYPageView.h
//  MYPageView
//
//  Created by mayan on 2017/9/28.
//  Copyright © 2017年 mayan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MYPageViewStyle.h"

@interface MYPageView : UIView

- (instancetype)initWithFrame:(CGRect)frame
                       titles:(NSArray <NSString *>*)titles
                     childVCs:(NSArray <UIViewController *>*)childVCs
                        style:(MYPageViewStyle *)style;

@end
