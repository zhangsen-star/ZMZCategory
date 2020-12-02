//
//  ZSAYJNetworkRequestOperation.m
//  NetworkMonitoringSystem
//
//  Created by admin on 2017/11/8.
//  Copyright © 2017年 Zhonggongxinhuanyu. All rights reserved.
//

#import "ZSAYJNetworkRequestOperation.h"
#import <AFNetworking/AFNetworking.h>

@interface ZSAYJNetworkRequestOperation ()

@property (nonatomic ,copy) NSString *requestNetworkString;

@property (nonatomic ,strong) NSDictionary *requestParamDict;

@property (nonatomic ,copy) void (^completeRequestBlock)(NSString *errorString,NSDictionary *responseDict);

@property (nonatomic ,copy) void (^completedDeleteOperation)(void);

@property (assign, nonatomic, getter = isExecuting) BOOL executing;
@property (assign, nonatomic, getter = isFinished) BOOL finished;

@end

@implementation ZSAYJNetworkRequestOperation

@synthesize executing = _executing;
@synthesize finished = _finished;



-(id)initWithRequsetUrlString:(NSString *)requestUrlString withRequsetParamDict:(NSDictionary *)paramDict withCompleteBlock:(void (^)(NSString *errorString,NSDictionary *responseDict))completeBlock withDeleteOperation:(void (^)(void))completeDeleteOperation {
    self = [super init];
    if (self != nil) {
        self.requestNetworkString = requestUrlString;
        self.requestParamDict = paramDict;
        self.completeRequestBlock = completeBlock;
        self.completedDeleteOperation = completeDeleteOperation;
        _executing = false;
        _finished = false;
        
    }
    return self;
}


-(void)start {
    AFHTTPSessionManager *postRequstManager = [AFHTTPSessionManager manager];
    postRequstManager.requestSerializer = [AFJSONRequestSerializer serializer];
    postRequstManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [postRequstManager.requestSerializer setTimeoutInterval:10.0];
    self.executing = true;
    __weak typeof (self)weakSelf = self;
    [postRequstManager POST:self.requestNetworkString parameters:self.requestParamDict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        if (weakSelf.completedDeleteOperation) {
            weakSelf.completedDeleteOperation();
        }
        if (weakSelf.completeRequestBlock) {
            weakSelf.completeRequestBlock(@"",responseDict);
        }
        
        weakSelf.executing = false;
        weakSelf.finished = true;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (weakSelf.completedDeleteOperation) {
            weakSelf.completedDeleteOperation();
        }
        
        if (weakSelf.completeRequestBlock) {
            NSHTTPURLResponse *requestResponse = (NSHTTPURLResponse *)task.response;
            NSLog(@"%ld",requestResponse.statusCode);
            if (requestResponse.statusCode == 500) {
                weakSelf.completeRequestBlock(@"内部服务器错误!",nil);
            } else {
                if (requestResponse.statusCode == 404) {
                    weakSelf.completeRequestBlock(@"无法连接到服务器!",nil);
                } else {
                    if (requestResponse.statusCode == 0) {
                        weakSelf.completeRequestBlock(@"服务器未开启!",nil);
                    } else {
                        weakSelf.completeRequestBlock(@"网络不给力，稍后再试!",nil);
                    }
                    
                }
            }
            
        }
        weakSelf.executing = false;
        weakSelf.finished = true;
    }];
}


-(void)setFinished:(BOOL)finished {
    [self willChangeValueForKey:@"isFinished"];
    _finished = finished;
    [self didChangeValueForKey:@"isFinished"];
}

-(void)setExecuting:(BOOL)executing {
    [self willChangeValueForKey:@"isExecuting"];
    _executing = executing;
    [self didChangeValueForKey:@"isExecuting"];
}

@end
