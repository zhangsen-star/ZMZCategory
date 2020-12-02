//
//  ZSAYJNetworkHandlesManager.m
//  NetworkMonitoringSystem
//
//  Created by admin on 2017/10/24.
//  Copyright © 2017年 Zhonggongxinhuanyu. All rights reserved.
//

#import "ZSAYJNetworkHandlesManager.h"

@implementation ZSAYJNetworkHandlesManager

static ZSAYJNetworkHandlesManager *_sharedInstance = nil;
//http://192.168.1.177:8080/peacock/webapi/
//http://192.168.1.67:8080/
+(ZSAYJNetworkHandlesManager *)sharedNetworkHandlesManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[self alloc] initWithBaseURL:[NSURL URLWithString:@"http://192.168.1.177:8080/peacock/webapi/"] sessionConfiguration:nil];
        [_sharedInstance.requestSerializer setTimeoutInterval:15.0];
        _sharedInstance.requestSerializer = [AFJSONRequestSerializer serializer];
        _sharedInstance.responseSerializer = [AFHTTPResponseSerializer serializer];
    });
    return _sharedInstance;
}

+(void)requestGetWithUrl:(NSString *)getRequestUrl withCompleteBlock:(void (^)(NSString *errorString,NSDictionary *responseDict))completeBlock {
    AFHTTPSessionManager *getRequstManager = [AFHTTPSessionManager manager];
    getRequstManager.requestSerializer = [AFJSONRequestSerializer serializer];
    getRequstManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    getRequstManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", @"application/json", @"text/json", @"text/plain" , nil];
    [getRequstManager GET:getRequestUrl parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        if (completeBlock) {
            completeBlock(@"",responseDict);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (completeBlock) {
            completeBlock(error.localizedFailureReason,nil);
        }
    }];
}

-(void)requestPostBehindUrl:(NSString *)behindUrl withParamDict:(NSDictionary *)paramDict withCompleteBlock:(void (^)(NSString *errorString,NSDictionary *responseDict))completeBlock {
    
    [self POST:behindUrl parameters:paramDict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *responseString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        if (completeBlock) {
            completeBlock(@"",responseDict);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        completeBlock(@"网络不给力，稍后再试!",nil);
    }];
}

@end
