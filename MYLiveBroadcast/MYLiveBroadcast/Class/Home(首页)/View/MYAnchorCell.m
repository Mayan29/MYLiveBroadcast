//
//  MYAnchorCell.m
//  MYLiveBroadcast
//
//  Created by mayan on 2017/10/10.
//  Copyright © 2017年 mayan. All rights reserved.
//

#import "MYAnchorCell.h"
#import "MYAnchorModel.h"
#import "UIImageView+WebCache.h"

@interface MYAnchorCell ()

@property (weak, nonatomic) IBOutlet UIImageView *photo;
@property (weak, nonatomic) IBOutlet UIImageView *isLivingIcon;
@property (weak, nonatomic) IBOutlet UILabel     *name;
@property (weak, nonatomic) IBOutlet UILabel     *watchingNum;

@end

@implementation MYAnchorCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.layer.cornerRadius = 5;
}

- (void)setModel:(MYAnchorModel *)model
{
    _model = model;
    
    [_photo sd_setImageWithURL:[NSURL URLWithString:model.pic74] placeholderImage:[UIImage imageNamed:@""]];
    _isLivingIcon.hidden = model.live;
    _name.text = model.name;
    _watchingNum.text = [NSString stringWithFormat:@"在线人数：%d", model.focus];
}

@end
