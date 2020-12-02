//
//  ZSAYJNetworkRequestLoaderMessageManeger.m
//  NetworkMonitoringSystem
//
//  Created by admin on 2017/11/8.
//  Copyright © 2017年 Zhonggongxinhuanyu. All rights reserved.
//

#import "ZSAYJNetworkRequestLoaderMessageManeger.h"
#import "ZSAYJNetworkRequestOperation.h"

@interface ZSAYJNetworkRequestLoaderMessageManeger ()

@property (nonatomic ,strong) NSOperationQueue *networkRequestQueue;

@property (nonatomic ,strong) NSMutableDictionary<NSString *, ZSAYJNetworkRequestOperation *> *URLWithOperationsMutableDict;

@property (nonatomic ,copy) NSString *baseRequstURLString;

@end

@implementation ZSAYJNetworkRequestLoaderMessageManeger

static ZSAYJNetworkRequestLoaderMessageManeger *_sharedInstance = nil;

+(ZSAYJNetworkRequestLoaderMessageManeger *)sharedNetworkRequestLoaderMessageManeger {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[self alloc] init];
    });
    return _sharedInstance;
}

-(instancetype)init {
    self = [super init];
    if (self != nil) {
        self.networkRequestQueue = [[NSOperationQueue alloc] init];
        self.networkRequestQueue.maxConcurrentOperationCount = 6;
        self.URLWithOperationsMutableDict = [[NSMutableDictionary alloc] init];
        self.baseRequstURLString = @"http://192.168.1.178:8080/peacock/webapi/";
    }
    return self;
}

-(void)requestPostBehindUrl:(NSString *)behindUrl withParamDict:(NSDictionary *)paramDict withCompleteBlock:(void (^)(NSString *errorString,NSDictionary *responseDict))completeBlock {
    NSString *completeURLString = [NSString stringWithFormat:@"%@%@",self.baseRequstURLString,behindUrl];
    ZSAYJNetworkRequestOperation *reqeustOperation = self.URLWithOperationsMutableDict[completeURLString];
    if (reqeustOperation == nil) {
        __weak typeof (self)weakSelf = self;
        reqeustOperation = [[ZSAYJNetworkRequestOperation alloc] initWithRequsetUrlString:completeURLString withRequsetParamDict:paramDict withCompleteBlock:completeBlock withDeleteOperation:^{
            [weakSelf.URLWithOperationsMutableDict removeObjectForKey:completeURLString];
            
        }];
        [self.URLWithOperationsMutableDict setObject:reqeustOperation forKey:completeURLString];
        [self.networkRequestQueue addOperation:reqeustOperation];
    }
    
}

@end
