//
//  MYHomeDataService.h
//  MYLiveBroadcast
//
//  Created by mayan on 2017/10/9.
//  Copyright © 2017年 mayan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MYHomeDataParams : NSObject

@property (nonatomic, assign) int type;
@property (nonatomic, assign) int index;
@property (nonatomic, assign) int size;

@end


@class MYAnchorModel;
@interface MYHomeDataService : NSObject

// 首页获取所有主播 model
+ (void)loadHomeDataWithParams:(MYHomeDataParams *)params success:(void(^)(NSArray <MYAnchorModel *>*response))success;

@end
