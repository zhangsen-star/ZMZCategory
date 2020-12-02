//
//  ZSAYJNetworkRequestLoaderMessageManeger.h
//  NetworkMonitoringSystem
//
//  Created by admin on 2017/11/8.
//  Copyright © 2017年 Zhonggongxinhuanyu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZSAYJNetworkRequestLoaderMessageManeger : NSObject

+(ZSAYJNetworkRequestLoaderMessageManeger *)sharedNetworkRequestLoaderMessageManeger ;

-(void)requestPostBehindUrl:(NSString *)behindUrl withParamDict:(NSDictionary *)paramDict withCompleteBlock:(void (^)(NSString *errorString,NSDictionary *responseDict))completeBlock;

@end
