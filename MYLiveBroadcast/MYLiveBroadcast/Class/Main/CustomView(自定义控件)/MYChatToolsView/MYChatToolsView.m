//
//  MYChatToolsView.m
//  MYChatToolsView
//
//  Created by mayan on 2017/10/19.
//  Copyright © 2017年 mayan. All rights reserved.
//

#import "MYChatToolsView.h"
#import "MYPlacehoderTextView.h"

@interface MYChatToolsView () <UITextViewDelegate>

@property (nonatomic, strong) UIView *bgView;
@property (weak, nonatomic) IBOutlet MYPlacehoderTextView *inputTextView;  // 输入框
@property (weak, nonatomic) IBOutlet UIButton             *sendMsgButton;  // 发送按钮

@property (nonatomic, weak) id<MYChatToolsViewDelegate> delegate;

@property (nonatomic, strong) NSLayoutConstraint *topCos;
@property (nonatomic, strong) NSLayoutConstraint *leftCos;
@property (nonatomic, strong) NSLayoutConstraint *rightCos;
@property (nonatomic, strong) NSLayoutConstraint *heightCos;

@end

@implementation MYChatToolsView


#pragma mark - Init
+ (instancetype)chatToolsViewWithSuperView:(UIView *)superView andDelegate:(id<MYChatToolsViewDelegate>)delegate
{
    MYChatToolsView *chatToolsView = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil].firstObject;
    chatToolsView.delegate = delegate;
    chatToolsView.translatesAutoresizingMaskIntoConstraints = NO;
    [superView addSubview:chatToolsView];
    [superView bringSubviewToFront:chatToolsView];
    
    // 添加 MYChatToolsView 约束
    chatToolsView.topCos    = [NSLayoutConstraint constraintWithItem:chatToolsView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:superView attribute:NSLayoutAttributeTop multiplier:1.0 constant:superView.bounds.size.height];
    chatToolsView.leftCos   = [NSLayoutConstraint constraintWithItem:chatToolsView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:superView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.0];
    chatToolsView.rightCos  = [NSLayoutConstraint constraintWithItem:chatToolsView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:superView attribute:NSLayoutAttributeRight multiplier:1.0 constant:0.0];
    chatToolsView.heightCos = [NSLayoutConstraint constraintWithItem:chatToolsView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:44];
    
    [superView addConstraint:chatToolsView.topCos];
    [superView addConstraint:chatToolsView.leftCos];
    [superView addConstraint:chatToolsView.rightCos];
    [chatToolsView addConstraint:chatToolsView.heightCos];
    
    return chatToolsView;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    // 0. 设置初始化值
    _textFont                  = [UIFont systemFontOfSize:14];  // 字号大小，默认 14
    _placeholderText           = @"请输入文字";                   // 占位符文字，默认为“请输入文字”
    _sendMsgButtonColor        = [UIColor orangeColor];         // 发送按钮颜色，默认橙色
    _disableSendMsgButtonColor = [UIColor grayColor];           // 发送按钮不可用颜色，默认灰色
    
    // 1. 初始化 sendMsgButton
    _sendMsgButton.layer.cornerRadius = _sendMsgButton.bounds.size.height / 4;
    _sendMsgButton.enabled            = NO;
    
    // 2. 初始化 inputView
    _inputTextView.allowsEditingTextAttributes   = YES;
    _inputTextView.delegate                      = self;
    _inputTextView.enablesReturnKeyAutomatically = YES;
    _inputTextView.placeholder                   = _placeholderText;
    _inputTextView.layer.cornerRadius            = _sendMsgButton.layer.cornerRadius;
    _inputTextView.layer.borderWidth             = 0.5;
    _inputTextView.layer.borderColor             = [UIColor lightGrayColor].CGColor;
    [_inputTextView.textInputView addObserver:self forKeyPath:@"frame" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    
    // 3. 监听键盘
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [_inputTextView.textInputView removeObserver:self forKeyPath:@"frame"];
}


#pragma mark - Button click
// 发送
- (IBAction)sendMsgClick:(UIButton *)sender
{
    if (!_inputTextView.text.length) return;
    
    if ([self.delegate respondsToSelector:@selector(chatToolsView:message:)]) {
        [self.delegate chatToolsView:self message:_inputTextView.text];
    }
    _inputTextView.text = @"";
    [self textViewDidChange:_inputTextView];
    
    [self hiddenKeyboard];
}


#pragma mark - UITextViewDelegate
- (void)textViewDidChange:(UITextView *)textView
{
    _sendMsgButton.enabled = textView.text.length;
    [_sendMsgButton setBackgroundColor:(_sendMsgButton.enabled ? self.sendMsgButtonColor : self.disableSendMsgButtonColor)];
}


#pragma mark - NSNotification
- (void)keyboardWillChangeFrame:(NSNotification *)notification
{
    NSDictionary *userInfo = notification.userInfo;
    CGFloat duration       = [userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    CGRect  keyboardBeginF = [userInfo[UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    CGRect  keyboardEndF   = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];

    // 1 计算键盘移动速度
    CGFloat speed = duration ? (ABS(keyboardBeginF.origin.y - keyboardEndF.origin.y) / duration) : 0;
    
    // 2 计算工具条位移位置
    CGFloat oldTopCos = self.topCos.constant;
    CGFloat newTopCos = self.topCos.constant;
    // 2.1 键盘弹出
    if (keyboardBeginF.origin.y > keyboardEndF.origin.y) {
        newTopCos -= ABS(keyboardBeginF.origin.y - keyboardEndF.origin.y);
        if (ABS(keyboardBeginF.origin.y - keyboardEndF.origin.y) >= keyboardBeginF.size.height) {
            newTopCos -= self.heightCos.constant;
        }
    }
    // 2.2 键盘落下
    else if (keyboardBeginF.origin.y < keyboardEndF.origin.y) {
        newTopCos += ABS(keyboardBeginF.origin.y - keyboardEndF.origin.y);
        if (ABS(keyboardBeginF.origin.y - keyboardEndF.origin.y) >= keyboardBeginF.size.height) {
            newTopCos += self.heightCos.constant;
        }
    }
    self.topCos.constant = newTopCos;
    
    // 3 计算工具条移动速度
    CGFloat my_duration = speed ? ABS(oldTopCos - newTopCos) / speed : 0;
    
    [UIView animateWithDuration:my_duration animations:^{
        [self.superview layoutIfNeeded];
    }];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{    
    if ([keyPath isEqualToString:@"frame"]) {
        
        CGFloat oldHeightConstant = self.heightCos.constant;
        self.heightCos.constant = _inputTextView.textInputView.bounds.size.height + 10;
        self.topCos.constant -= self.heightCos.constant - oldHeightConstant;

        [UIView animateWithDuration:0.25 animations:^{
            [self.superview layoutIfNeeded];
        }];
    }
}


#pragma mark - Action
- (void)showKeyboard
{
    [self.superview addSubview:self.bgView];
    [self.superview bringSubviewToFront:self];
    
    [_inputTextView becomeFirstResponder];
}

- (void)hiddenKeyboard
{
    [self.bgView removeFromSuperview];
    
    [_inputTextView resignFirstResponder];
}


#pragma mark - Lazy load
- (UIView *)bgView
{
    if (!_bgView) {

        _bgView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _bgView.backgroundColor = [UIColor clearColor];
        [_bgView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenKeyboard)]];
    }
    return _bgView;
}


#pragma mark - Set
- (void)setTextFont:(UIFont *)textFont
{
    _textFont = textFont;
    _inputTextView.font = textFont;
    
    if (textFont.lineHeight + 16 + 10 > _heightCos.constant) {
        _heightCos.constant = textFont.lineHeight + 16 + 10;
    }
}

- (void)setPlaceholderText:(NSString *)placeholderText
{
    _placeholderText = placeholderText;
    
    _inputTextView.placeholder = placeholderText;
}

@end
