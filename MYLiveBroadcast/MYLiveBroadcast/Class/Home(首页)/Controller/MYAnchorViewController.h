//
//  MYAnchorViewController.h
//  MYLiveBroadcast
//
//  Created by mayan on 2017/10/9.
//  Copyright © 2017年 mayan. All rights reserved.
//
//  直播首页滑动翻页每页控制器

#import <UIKit/UIKit.h>

@class MYAnchorModel;
@interface MYAnchorViewController : UIViewController

@property (nonatomic, strong) NSArray <MYAnchorModel *>*dataArray;

@property (nonatomic, strong) void (^itemClickBlock)(MYAnchorModel *model);


@end
