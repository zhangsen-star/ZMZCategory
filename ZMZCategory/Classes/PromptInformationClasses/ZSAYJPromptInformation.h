//
//  ZSAYJPromptInformation.h
//  NetworkMonitoringSystem
//
//  Created by admin on 2017/10/24.
//  Copyright © 2017年 Zhonggongxinhuanyu. All rights reserved.
//

#import "ZSAYJPromptMessageManager.h"

@interface ZSAYJPromptInformation : ZSAYJPromptMessageManager

+(void)showWithStatus:(NSString *)status;

+(void)showSuccessWithStatus:(NSString *)status;

+(void)showErrorWithStatus:(NSString *)status;

+(void)showImage:(UIImage *)image status:(NSString *)status;

+(void)dismiss;

+(void)showRequestErrorMessage:(NSString *)messageString;

@end
