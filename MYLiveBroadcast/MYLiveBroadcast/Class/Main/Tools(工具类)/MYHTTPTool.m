//
//  MYHTTPTool.m
//  直播项目
//
//  Created by mayan on 2017/5/25.
//  Copyright © 2017年 mayan. All rights reserved.
//

#import "MYHTTPTool.h"
#import "AFNetworking.h"


static NSUInteger const time_out = 20;


@implementation MYHTTPTool


+ (AFHTTPSessionManager *)shareManager
{
    static AFHTTPSessionManager *manager;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        manager = [AFHTTPSessionManager manager];
        manager.requestSerializer.timeoutInterval = time_out;
    });
    
    return manager;
}



+ (void)GET:(NSString *)url params:(NSMutableDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    
    [self printWithURL:url params:params];
    
    AFHTTPSessionManager *manager = [MYHTTPTool shareManager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/plain", nil];
    
    [manager GET:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (error) {
            failure(error);
        }
    }];
}





+ (void)POST:(NSString *)url params:(NSMutableDictionary *)params body:(id)body success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    
    [self printWithURL:url params:params];
    
    
    AFHTTPSessionManager *manager = [MYHTTPTool shareManager];
    
    if ([body isKindOfClass:[UIImage class]]) {
        
        NSData *data = UIImageJPEGRepresentation(body, 0.1);
        
        NSString *base64 = [data base64EncodedStringWithOptions:0];
        
        [params setObject:base64 forKey:@"userImage"];
    }
    
    
    [manager POST:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (error) {
            failure(error);
        }
    }];
}




+ (void)printWithURL:(NSString *)url params:(NSDictionary *)params
{
    NSMutableArray *paramsArr = [NSMutableArray array];
    [params enumerateKeysAndObjectsUsingBlock:^(NSString *key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        
        NSString *paramsString = [NSString stringWithFormat:@"%@=%@", key, obj];
        [paramsArr addObject:paramsString];
    }];
    
    NSString *paramsString = [paramsArr componentsJoinedByString:@"&"];
    
    MYLog(@"%@?%@", url, paramsString);
}

@end
