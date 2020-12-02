//
//  ZSAYJNetworkHandlesManager.h
//  NetworkMonitoringSystem
//
//  Created by admin on 2017/10/24.
//  Copyright © 2017年 Zhonggongxinhuanyu. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

@interface ZSAYJNetworkHandlesManager : AFHTTPSessionManager

+(ZSAYJNetworkHandlesManager *)sharedNetworkHandlesManager;

+(void)requestGetWithUrl:(NSString *)getRequestUrl withCompleteBlock:(void (^)(NSString *errorString,NSDictionary *responseDict))completeBlock;

-(void)requestPostBehindUrl:(NSString *)behindUrl withParamDict:(NSDictionary *)paramDict withCompleteBlock:(void (^)(NSString *errorString,NSDictionary *responseDict))completeBlock;

@end
