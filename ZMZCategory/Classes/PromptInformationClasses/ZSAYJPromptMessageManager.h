//
//  ZSAYJPromptMessageManager.h
//  NetworkMonitoringSystem
//
//  Created by admin on 2017/10/24.
//  Copyright © 2017年 Zhonggongxinhuanyu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZSAYJPromptMessageManager : UIView

+(ZSAYJPromptMessageManager *)sharedPromptMessageManager;

-(void)showLoadPromptMessage:(NSString *)loadMessage;

-(void)showSuccessPromptMessage:(NSString*)successMessage;

-(void)showErrorPromptMessage:(NSString*)errorMessage;

-(void)showRemindPromptMessage:(NSString *)remindMessage;

-(void)showRemindPromptMessage:(NSString *)remindMessage withShowImage:(UIImage *)remindImage;

-(void)putOneselfRemoveShowWindowView;

@end
