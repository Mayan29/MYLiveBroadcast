//
//  MYHTTPTool.h
//  直播项目
//
//  Created by mayan on 2017/5/25.
//  Copyright © 2017年 mayan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MYHTTPTool : NSObject




#define NSStringWithFormat(a,b) [NSString stringWithFormat:@"%@/%@",a,b]
#define BaseURL @"http://qf.56.com"


+ (void)GET:(NSString *)url params:(NSMutableDictionary *)params success:(void (^)(id response))success failure:(void (^)(NSError *error))failure;


+ (void)POST:(NSString *)url params:(NSMutableDictionary *)params body:(id)body success:(void (^)(id response))success failure:(void (^)(NSError *error))failure;



@end
