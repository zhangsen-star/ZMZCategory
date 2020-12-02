//
//  NMSApplicationMonitoringCommonQueryResultView.m
//  NetworkMonitoringSystem
//
//  Created by 张森 on 2017/12/29.
//  Copyright © 2017年 Zhonggongxinhuanyu. All rights reserved.
//

#import "NMSApplicationMonitoringCommonQueryResultView.h"

@interface NMSApplicationMonitoringCommonQueryResultView ()

@property (nonatomic ,strong) UIImageView *queryResultImageView;

@end

@implementation NMSApplicationMonitoringCommonQueryResultView

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self != nil) {
        
        self.backgroundColor = [UIColor clearColor];
        
        self.queryResultImageView = [[UIImageView alloc] init];
        self.queryResultImageView.backgroundColor = [UIColor clearColor];
        self.queryResultImageView.image = [UIImage imageNamed:@"application_Monitoring_common_query_result_image"];
        self.queryResultImageView.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:self.queryResultImageView];
        self.queryResultImageView.translatesAutoresizingMaskIntoConstraints = false;
        
        self.resultMessageLable = [[UILabel alloc] init];
        self.resultMessageLable.font = [UIFont systemFontOfSize:16.0];
        self.resultMessageLable.textColor = [UIColor colorWithRed:203.0/255.0 green:203.0/255.0 blue:203.0/255.0 alpha:1.0];
        self.resultMessageLable.backgroundColor = [UIColor clearColor];
        self.resultMessageLable.textAlignment = NSTextAlignmentCenter;
        self.resultMessageLable.numberOfLines = 0;
        [self addSubview:self.resultMessageLable];
        self.resultMessageLable.translatesAutoresizingMaskIntoConstraints = false;
        [self setupLayout];
    }
    return self;
}

-(void)setupLayout {
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.queryResultImageView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.queryResultImageView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.queryResultImageView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:128.0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.queryResultImageView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:128.0]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.resultMessageLable attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.queryResultImageView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:5.0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.resultMessageLable attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.resultMessageLable attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0.0]];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
