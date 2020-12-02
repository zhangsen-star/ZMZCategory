//
//  ZSAYJNetworkRequestOperation.h
//  NetworkMonitoringSystem
//
//  Created by admin on 2017/11/8.
//  Copyright © 2017年 Zhonggongxinhuanyu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZSAYJNetworkRequestOperation : NSOperation

-(id)initWithRequsetUrlString:(NSString *)requestUrlString withRequsetParamDict:(NSDictionary *)paramDict withCompleteBlock:(void (^) (NSString *errorString,NSDictionary *responseDict))completeBlock withDeleteOperation:(void (^) (void))completeDeleteOperation;
@end
