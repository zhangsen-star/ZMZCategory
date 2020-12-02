//
//  ZSAYJPromptMessageShowView.m
//  NetworkMonitoringSystem
//
//  Created by 张森 on 2017/11/28.
//  Copyright © 2017年 Zhonggongxinhuanyu. All rights reserved.
//

#import "ZSAYJPromptMessageShowView.h"

extern const CGFloat AYJPromptMessageHorizontalSpacing;

extern const CGFloat AYJPromptMessageVerticalSpacing;

extern const CGFloat AYJPromptMessageLabelSpacing;

@interface ZSAYJPromptMessageShowView ()

@property (nonatomic ,strong) UIImageView *showPromptMatchingImageView;

@property (nonatomic ,strong) UILabel *showPromptWordsLable;

@property (nonatomic ,strong) UIFont *promptWordsLableFont;

@property (nonatomic ,strong) NSTimer *showPromptExhibitTimer;

@property (nonatomic ,strong) UIActivityIndicatorView *showPromptIndicatorView;

@property (nonatomic ,strong) UIImage *messeageImage;

@property (nonatomic ,strong) UIImage *successImage;

@property (nonatomic ,strong) UIImage *errorImage;

@property (nonatomic ,assign) CGPoint centerViewPoint;

@property (nonatomic ,weak) UIView *backSuperView;

@end

@implementation ZSAYJPromptMessageShowView


-(void)showLoadPromptMessage:(NSString *)loadMessage {
    self.showPromptWordsLable.text = loadMessage;
    [self.showPromptIndicatorView startAnimating];
    self.showPromptIndicatorView.hidden = false;
    self.showPromptMatchingImageView.hidden = true;
    self.showPromptMatchingImageView.image = nil;
    [self updatePromptMessageViewFrame];
}

-(void)showSuccessPromptMessage:(NSString*)successMessage {
    [self showSuccessPromptMessage:successMessage withTime:1.0];
}

-(void)showSuccessPromptMessage:(NSString*)successMessage withTime:(CGFloat)showMessageTime {
    self.showPromptWordsLable.text = successMessage;
    self.showPromptIndicatorView.hidden = true;
    self.showPromptMatchingImageView.hidden = false;
    self.showPromptMatchingImageView.image = self.successImage;
    [self updatePromptMessageViewFrame];
    [self creatTimerShowWithTime:showMessageTime];
    
}

-(void)showErrorPromptMessage:(NSString*)errorMessage {
    [self showErrorPromptMessage:errorMessage withTime:1.0];
}

-(void)showErrorPromptMessage:(NSString*)errorMessage withTime:(CGFloat)showMessageTime {
    self.showPromptWordsLable.text = errorMessage;
    self.showPromptIndicatorView.hidden = true;
    self.showPromptMatchingImageView.hidden = false;
    self.showPromptMatchingImageView.image = self.errorImage;
    [self updatePromptMessageViewFrame];
    [self creatTimerShowWithTime:showMessageTime];
    
}

-(void)showRemindPromptMessage:(NSString *)remindMessage {
    [self showRemindPromptMessage:remindMessage withShowImage:nil];
}

-(void)showRemindPromptMessage:(NSString *)remindMessage withShowImage:(UIImage *)remindImage {
    [self showRemindPromptMessage:remindMessage withShowImage:remindImage withTime:1.0];
}

-(void)showRemindPromptMessage:(NSString *)remindMessage withShowImage:(UIImage *)remindImage withTime:(CGFloat)showMessageTime {
    self.showPromptWordsLable.text = remindMessage;
    self.showPromptIndicatorView.hidden = true;
    if (remindImage == nil) {
        self.showPromptMatchingImageView.hidden = true;
    } else {
        self.showPromptMatchingImageView.hidden = false;
    }
    
    self.showPromptMatchingImageView.image = self.errorImage;
    [self updatePromptMessageViewFrame];
    [self creatTimerShowWithTime:showMessageTime];
}

-(void)creatTimerShowWithTime:(CGFloat)showMessageTime {
    self.showPromptExhibitTimer = [NSTimer timerWithTimeInterval:showMessageTime target:self selector:@selector(putOneselfRemoveShowWindowView) userInfo:nil repeats:false];
    [[NSRunLoop mainRunLoop] addTimer:self.showPromptExhibitTimer forMode:NSRunLoopCommonModes];
}

-(void)putOneselfRemoveShowWindowView {
    [self.showPromptIndicatorView stopAnimating];
    [self.showPromptExhibitTimer invalidate];
    self.showPromptExhibitTimer = nil;
    [self removeFromSuperview];
}

-(instancetype)initWithFrame:(CGRect)frame withSelectedSuperView:(UIView *)selectedSuperView {
    self = [super initWithFrame:frame];
    if (self != nil) {
        
        self.userInteractionEnabled = false;
        self.layer.masksToBounds = true;
        self.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin;
        self.layer.cornerRadius = 13.0;
        self.backgroundColor = [UIColor colorWithRed:0.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:0.6];
        self.backSuperView = selectedSuperView;
        
        self.centerViewPoint = selectedSuperView.center;
        self.promptWordsLableFont = [UIFont preferredFontForTextStyle:UIFontTextStyleSubheadline];
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 80000
        
#else
        
#endif
        UIImage *localMessageImage = [UIImage imageNamed:@"prompt_information_content_message"];
        UIImage *localSuccessImage = [UIImage imageNamed:@"prompt_information_content_success"];
        UIImage *localErrorImage = [UIImage imageNamed:@"prompt_information_content_error"];
        self.messeageImage = [localMessageImage imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        self.successImage = [localSuccessImage imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        self.errorImage = [localErrorImage imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    }
    return self;
}

-(void)updatePromptMessageViewFrame {
    [self.backSuperView addSubview:self];
    BOOL whetherShowImage = (self.showPromptMatchingImageView.image != nil) && (!self.showPromptMatchingImageView.hidden);
    BOOL whetherShowIndicatorView = !self.showPromptIndicatorView.hidden;
    CGRect messageLableRect = CGRectZero;
    CGFloat messageLableHeight = 0.0;
    CGFloat messageLableWidth = 0.0;
    if (self.showPromptWordsLable.text != nil) {
        CGSize presetConstraintSize = CGSizeMake(200.0, 300.0);
        messageLableRect = [self.showPromptWordsLable.text boundingRectWithSize:presetConstraintSize options:(NSStringDrawingOptions) (NSStringDrawingUsesFontLeading | NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName: self.showPromptWordsLable.font} context:NULL];
        messageLableHeight = ceilf(CGRectGetHeight(messageLableRect));
        messageLableWidth = ceilf(CGRectGetWidth(messageLableRect));
    }
    
    CGFloat promptContentViewWidth = 0.0;
    CGFloat promptContentViewHeight = 0.0;
    
    CGFloat promptContentWidth = 0.0;
    CGFloat promptContentHeight = 0.0;
    
    if (whetherShowImage || whetherShowIndicatorView) {
        promptContentWidth = CGRectGetWidth(whetherShowImage ? self.showPromptMatchingImageView.frame : self.showPromptIndicatorView.frame);
        promptContentHeight = CGRectGetHeight(whetherShowImage ? self.showPromptMatchingImageView.frame : self.showPromptIndicatorView.frame);
        
    }
    
    promptContentViewWidth = AYJPromptMessageHorizontalSpacing + MAX(messageLableWidth, promptContentWidth) + AYJPromptMessageHorizontalSpacing;
    promptContentViewHeight = AYJPromptMessageVerticalSpacing + messageLableHeight + promptContentHeight + AYJPromptMessageVerticalSpacing;
    
    if ((self.showPromptWordsLable.text != nil) && (whetherShowImage || whetherShowIndicatorView)) {
        promptContentViewHeight = promptContentViewHeight + AYJPromptMessageLabelSpacing;
    }
    
    self.bounds = CGRectMake(0.0, 0.0, promptContentViewWidth, promptContentViewHeight);
    self.center = self.centerViewPoint;
    
    CGFloat showImageIndicatorViewY = AYJPromptMessageVerticalSpacing + (promptContentHeight / 2.0);
    self.showPromptMatchingImageView.center = CGPointMake(CGRectGetMidX(self.bounds), showImageIndicatorViewY);
    self.showPromptIndicatorView.center = CGPointMake(CGRectGetMidX(self.bounds), showImageIndicatorViewY);
    
    CGFloat showLableMessageBaseY = 0.0;
    if (whetherShowIndicatorView || whetherShowImage) {
        showLableMessageBaseY = AYJPromptMessageVerticalSpacing + promptContentHeight + AYJPromptMessageLabelSpacing;
    } else {
        showLableMessageBaseY = AYJPromptMessageVerticalSpacing;
    }
    
    CGFloat showLableMessageY = showLableMessageBaseY + (messageLableHeight / 2);
    self.showPromptWordsLable.frame = messageLableRect;
    self.showPromptWordsLable.center = CGPointMake(CGRectGetMidX(self.bounds), showLableMessageY);
    self.showPromptWordsLable.hidden = (self.showPromptWordsLable.text == nil);
    
    
}

-(UIImage *)modifyImageColorWithImage:(UIImage *)originalImage withTintColor:(UIColor *)changeColor {
    CGRect showChangeRect = CGRectMake(0.0, 0.0, originalImage.size.width, originalImage.size.height);
    UIGraphicsBeginImageContextWithOptions(showChangeRect.size, false, originalImage.scale);
    CGContextRef changeImageContetRef = UIGraphicsGetCurrentContext();
    [originalImage drawInRect:showChangeRect];
    CGContextSetFillColorWithColor(changeImageContetRef, [changeColor CGColor]);
    CGContextSetBlendMode(changeImageContetRef, kCGBlendModeSourceAtop);
    CGContextFillRect(changeImageContetRef, showChangeRect);
    UIImage *changedColorImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return changedColorImage;
}

-(UIImageView *)showPromptMatchingImageView {
    if (_showPromptMatchingImageView == nil) {
        _showPromptMatchingImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, 40.0, 40.0)];
    }
    if (_showPromptMatchingImageView.superview == nil) {
        [self addSubview:_showPromptMatchingImageView];
    }
    _showPromptMatchingImageView.tintColor = [UIColor whiteColor];
    return _showPromptMatchingImageView;
}

-(UILabel *)showPromptWordsLable {
    if (_showPromptWordsLable == nil) {
        _showPromptWordsLable = [[UILabel alloc] initWithFrame:CGRectZero];
        _showPromptWordsLable.backgroundColor = [UIColor clearColor];
        _showPromptWordsLable.adjustsFontSizeToFitWidth = true;
        _showPromptWordsLable.textAlignment = NSTextAlignmentCenter;
        _showPromptWordsLable.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
        _showPromptWordsLable.numberOfLines = 0;
    }
    if (_showPromptWordsLable.superview == nil) {
        [self addSubview:_showPromptWordsLable];
    }
    _showPromptWordsLable.textColor = [UIColor whiteColor];
    _showPromptWordsLable.font = self.promptWordsLableFont;
    return _showPromptWordsLable;
}

-(UIActivityIndicatorView *)showPromptIndicatorView {
    if (_showPromptIndicatorView == nil) {
        
        _showPromptIndicatorView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0.0, 0.0, 40.0, 40.0)];
        _showPromptIndicatorView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
        _showPromptIndicatorView.backgroundColor = [UIColor clearColor];
        _showPromptIndicatorView.color = [UIColor whiteColor];
        _showPromptIndicatorView.hidesWhenStopped = true;
    }
    if (_showPromptIndicatorView.superview == nil) {
        [self addSubview:_showPromptIndicatorView];
    }
    return _showPromptIndicatorView;
}

-(UIImage *)errorImage {
    if (_errorImage == nil) {
        _errorImage = [[UIImage alloc] init];
    }
    return _errorImage;
}

-(UIImage *)successImage {
    if (_successImage == nil) {
        _successImage = [[UIImage alloc] init];
    }
    return _successImage;
}

-(UIImage *)messeageImage {
    if (_messeageImage == nil) {
        _messeageImage = [[UIImage alloc] init];
    }
    return _messeageImage;
}


@end
