//
//  MYRoomViewController.m
//  MYLiveBroadcast
//
//  Created by mayan on 2017/10/9.
//  Copyright © 2017年 mayan. All rights reserved.
//

#import "MYRoomViewController.h"
#import "MYAnchorModel.h"
#import "UIImageView+WebCache.h"
#import "CALayer+ParticleAnimation.h"
#import "MYGiftKeyboard.h"
#import "MYChatToolsView.h"

@interface MYRoomViewController () <MYChatToolsViewDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;
@property (weak, nonatomic) IBOutlet UIView      *bottomView;

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel     *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel     *roomIdLabel;

@property (nonatomic, strong) MYChatToolsView *chatToolsView;
@property (nonatomic, strong) MYGiftKeyboard  *giftKeyboard;

@end

@implementation MYRoomViewController

#pragma mark - init
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    // 1. 聊天工具条
    _chatToolsView = [MYChatToolsView chatToolsViewWithSuperView:self.view andDelegate:self];
    
    
    // 2. 礼物键盘
    // 标题
    NSArray *titles = @[@"热门", @"高级", @"豪华", @"专属"];
    // 样式
    MYGiftKeyboardStyle *style = [[MYGiftKeyboardStyle alloc] init];
    // 传入模型（模型需要根据数据情况自行封装）
    NSMutableArray *models = [NSMutableArray array];
    for (int i = 0; i < titles.count; i++) {
        NSMutableArray *arr = [NSMutableArray array];
        for (int j = 0; j < 10; j++) {
            [arr addObject:[[MYGiftKeyboardModel alloc] init]];
        }
        [models addObject:arr];
    }
    
    _giftKeyboard = [MYGiftKeyboard keyboardWithTitles:titles style:style models:models];
    _giftKeyboard.commitClickBlock = ^(MYGiftKeyboardModel *model) {
        NSLog(@"点击了 %@", model);
    };
    [self.view addSubview:_giftKeyboard];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}


#pragma mark - set
- (void)setModel:(MYAnchorModel *)model
{
    _model = model;
    
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:model.avatar]];
    self.roomIdLabel.text = [NSString stringWithFormat:@"房间号：%d", model.roomid];
    self.nameLabel.text = model.name;
}


#pragma mark - button click
- (IBAction)bottomMenuClick:(UIButton *)sender
{
    switch (sender.tag) {
        case 100:
            [self chatClick:sender];  // 聊天
            break;
        case 101:
            NSLog(@"分享");
            break;
        case 102:
            [self giftClick:sender];  // 礼物
            break;
        case 103:
            NSLog(@"更多");
            break;
        case 104:
            [self starClick:sender];  // 星星
            break;
        default:
            break;
    }
}


- (void)chatClick:(UIButton *)button
{
    [_chatToolsView showKeyboard];
}

- (void)starClick:(UIButton *)button
{
    CGPoint point = CGPointMake(button.center.x, self.bottomView.origin.y);
    
    if (button.isSelected) {
        [self.view.layer stopRarticleAnimation];
    } else {
        [self.view.layer startParticleAnimationWithPoint:point];
    }
    
    button.selected = !button.isSelected;
}

- (void)giftClick:(UIButton *)button
{
    [_giftKeyboard showKeyboard];
}

- (IBAction)follow  // 关注
{
    
}

- (IBAction)close
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)people
{
    
}


#pragma mark - MYChatToolsViewDelegate
- (void)chatToolsView:(MYChatToolsView *)chatToolsView message:(NSString *)message
{
    NSLog(@"%@", message);
}

@end
