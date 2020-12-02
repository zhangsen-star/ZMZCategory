//
//  ZSAYJPromptInformation.m
//  NetworkMonitoringSystem
//
//  Created by admin on 2017/10/24.
//  Copyright © 2017年 Zhonggongxinhuanyu. All rights reserved.
//

#import "ZSAYJPromptInformation.h"

@implementation ZSAYJPromptInformation

+(void)showWithStatus:(NSString *)status {
    [[ZSAYJPromptMessageManager sharedPromptMessageManager] showLoadPromptMessage:status];
}

+(void)showSuccessWithStatus:(NSString *)status {
    [[ZSAYJPromptMessageManager sharedPromptMessageManager] showSuccessPromptMessage:status];
}

+(void)showErrorWithStatus:(NSString *)status {
    [[ZSAYJPromptMessageManager sharedPromptMessageManager] showErrorPromptMessage:status];
}

+(void)showImage:(UIImage *)image status:(NSString *)status {
    [[ZSAYJPromptMessageManager sharedPromptMessageManager] showRemindPromptMessage:status withShowImage:image];
}

+(void)dismiss {
    [[ZSAYJPromptMessageManager sharedPromptMessageManager] putOneselfRemoveShowWindowView];
}

+(void)showRequestErrorMessage:(NSString *)messageString {
    NSString *tipString = messageString;
    if ((tipString == nil) || ([tipString length] == 0)) {
        [ZSAYJPromptInformation showErrorWithStatus:tipString];
    } else {
        [ZSAYJPromptInformation showErrorWithStatus:@"参数错误"];
    }
}

+(void)setedBaseInformation {
}

@end
