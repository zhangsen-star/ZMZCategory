//
//  ZSAYJPromptMessageShowView.h
//  NetworkMonitoringSystem
//
//  Created by 张森 on 2017/11/28.
//  Copyright © 2017年 Zhonggongxinhuanyu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZSAYJPromptMessageShowView : UIView

-(instancetype)initWithFrame:(CGRect)frame withSelectedSuperView:(UIView *)selectedSuperView;

-(void)showLoadPromptMessage:(NSString *)loadMessage;

-(void)showSuccessPromptMessage:(NSString*)successMessage;

-(void)showErrorPromptMessage:(NSString*)errorMessage;

-(void)showRemindPromptMessage:(NSString *)remindMessage;

-(void)showRemindPromptMessage:(NSString *)remindMessage withShowImage:(UIImage *)remindImage;

-(void)putOneselfRemoveShowWindowView;

@end
