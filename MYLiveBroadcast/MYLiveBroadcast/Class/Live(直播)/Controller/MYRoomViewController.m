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

@interface MYRoomViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;
@property (weak, nonatomic) IBOutlet UIView      *bottomView;

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel     *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel     *roomIdLabel;

@end

@implementation MYRoomViewController

#pragma mark - init
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
            NSLog(@"聊天");
            break;
        case 101:
            NSLog(@"分享");
            break;
        case 102:
            NSLog(@"礼物");
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

@end
