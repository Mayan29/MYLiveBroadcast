//
//  MYHomeDataService.m
//  MYLiveBroadcast
//
//  Created by mayan on 2017/10/9.
//  Copyright © 2017年 mayan. All rights reserved.
//

#import "MYHomeDataService.h"
#import "MYHTTPTool.h"
#import "MYAnchorModel.h"
#import "MJExtension.h"

@implementation MYHomeDataParams

@end

@implementation MYHomeDataService

+ (void)loadHomeDataWithParams:(MYHomeDataParams *)params success:(void (^)(NSArray<MYAnchorModel *> *))success
{
    NSMutableDictionary *paramsDic = [params mj_keyValues];
    
    [MYHTTPTool GET:NSStringWithFormat(BaseURL, @"home/v4/moreAnchor.ios") params:paramsDic success:^(id response) {
        if (success) {
            
            NSArray *data = response[@"message"][@"anchors"];
            NSArray *anchors = [MYAnchorModel mj_objectArrayWithKeyValuesArray:data];
            
            success(anchors);
        }
    } failure:^(NSError *error) {
        NSLog(@"%@", error.description);
    }];
}

@end
