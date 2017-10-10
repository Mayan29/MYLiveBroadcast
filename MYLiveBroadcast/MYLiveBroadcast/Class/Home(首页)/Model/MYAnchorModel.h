//
//  MYAnchorModel.h
//  MYLiveBroadcast
//
//  Created by mayan on 2017/10/9.
//  Copyright © 2017年 mayan. All rights reserved.
//
//  首页获取所有主播的 model

#import <Foundation/Foundation.h>

@interface MYAnchorModel : NSObject

@property (nonatomic, copy)     NSString  * avatar;
@property (nonatomic, copy)     NSString  * name;
@property (nonatomic, copy)     NSString  * pic51;
@property (nonatomic, copy)     NSString  * pic74;
@property (nonatomic, copy)     NSString  * uid;
@property (nonatomic, copy)     NSString  * gameIcon;
@property (nonatomic, copy)     NSString  * gameName;
@property (nonatomic, assign)   int         roomid;
@property (nonatomic, assign)   int         live;    // 是否在直播
@property (nonatomic, assign)   int         push;    // 直播显示方式
@property (nonatomic, assign)   int         focus;   // 关注数

@property (nonatomic, assign)   int         charge;
@property (nonatomic, assign)   int         gameId;
@property (nonatomic, assign)   int         mic;
@property (nonatomic, assign)   int         weeklyStar;
@property (nonatomic, assign)   int         yearParty;


@end
