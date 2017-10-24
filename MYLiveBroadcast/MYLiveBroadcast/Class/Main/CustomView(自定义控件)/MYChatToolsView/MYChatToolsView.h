//
//  MYChatToolsView.h
//  MYChatToolsView
//
//  Created by mayan on 2017/10/19.
//  Copyright © 2017年 mayan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MYChatToolsView;
@protocol MYChatToolsViewDelegate <NSObject>

- (void)chatToolsView:(MYChatToolsView *)chatToolsView message:(NSString *)message;

@end


@interface MYChatToolsView : UIView

+ (instancetype)chatToolsViewWithSuperView:(UIView *)superView andDelegate:(id<MYChatToolsViewDelegate>)delegate;

- (void)showKeyboard;

@property (nonatomic, strong) UIFont   *textFont;                   // 字号大小，默认 14
@property (nonatomic, strong) NSString *placeholderText;            // 占位符文字，默认为“请输入文字”
@property (nonatomic, strong) UIColor  *sendMsgButtonColor;         // 发送按钮颜色，默认橙色
@property (nonatomic, strong) UIColor  *disableSendMsgButtonColor;  // 发送按钮不可用颜色，默认灰色

@end
