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

@interface MYRoomViewController () <MYChatToolsViewDelegate, UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;
@property (weak, nonatomic) IBOutlet UIView      *bottomView;
@property (weak, nonatomic) IBOutlet UITableView *chatTableView;

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel     *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel     *roomIdLabel;

@property (nonatomic, strong) MYChatToolsView *chatToolsView;
@property (nonatomic, strong) MYGiftKeyboard  *giftKeyboard;

@property (nonatomic, strong) NSMutableArray *chatsArray;

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
    
    __weak typeof(self)wself = self;
    _giftKeyboard = [MYGiftKeyboard keyboardWithTitles:titles style:style models:models];
    _giftKeyboard.commitClickBlock = ^(MYGiftKeyboardModel *model) {
        [wself insetMessage:@"mayan 赠送了一个礼物🎁"];
    };
    [self.view addSubview:_giftKeyboard];
    
    // 3. 聊天列表
    _chatTableView.rowHeight = 25;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    self.tabBarController.tabBar.hidden = YES;
    
    [self insetMessage:@"mayan 进入了房间"];
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
    [self insetMessage:[NSString stringWithFormat:@"mayan：%@", message]];
}


#pragma mark - UITableViewDelegate and UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.chatsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"chatTableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.textLabel.textColor     = [UIColor whiteColor];
        cell.textLabel.numberOfLines = 0;
        cell.textLabel.font          = SYS_FONT(14);
        cell.backgroundColor         = [UIColor clearColor];
        cell.selectionStyle          = UITableViewCellSelectionStyleNone;
    }
    cell.textLabel.attributedText = self.chatsArray[indexPath.row];
    
    return cell;
}


#pragma mark - Lazy load
- (NSMutableArray *)chatsArray
{
    if (!_chatsArray) {
        _chatsArray = [NSMutableArray array];
    }
    return _chatsArray;
}


#pragma mark - Other
- (void)insetMessage:(NSString *)message
{
    NSMutableAttributedString *mutMsg = [[NSMutableAttributedString alloc] initWithString:message];
    [mutMsg addAttributes:@{NSForegroundColorAttributeName : [UIColor orangeColor]} range:NSMakeRange(0, 5)];
    [self.chatsArray addObject:mutMsg];
    
    NSIndexPath *path = [NSIndexPath indexPathForRow:self.chatsArray.count - 1 inSection:0];
    [self.chatTableView insertRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationNone];
    [self.chatTableView selectRowAtIndexPath:path animated:YES scrollPosition:UITableViewScrollPositionBottom];
}

@end
