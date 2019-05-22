//
//  DBSVProgressHUD.m
//  db_base_sdk
//
//  Created by 管家人 on 2019/5/20.
//  Copyright © 2019 管家人. All rights reserved.
//

#import "DBSVProgressHUD.h"

@interface DBSVProgressHUD ()

@property (nonatomic, strong) UIView *typeView;

@end

@implementation DBSVProgressHUD

+ (DBSVProgressHUD*)sharedView {
    static dispatch_once_t once;
    
    static DBSVProgressHUD *sharedView;
#if !defined(SV_APP_EXTENSIONS)
    dispatch_once(&once, ^{ sharedView = [[self alloc] initWithFrame:[[[UIApplication sharedApplication] delegate] window].bounds]; });
#else
    dispatch_once(&once, ^{ sharedView = [[self alloc] initWithFrame:[[UIScreen mainScreen] bounds]]; });
#endif
    return sharedView;
}

/**
 指定某个视图一直显示 不会消失
 
 @param view 指定的视图
 */
+(void)db_showWithView:(UIView *)view{
    [DBSVProgressHUD sharedView].typeView = view;
    view.userInteractionEnabled = NO;
    [DBSVProgressHUD show];
}

/**
 显示错误信息

 @param error 错误信息
 */
+ (void)db_showError:(NSError *)error{
    NSDictionary *dic = error.userInfo;
    [self showInfoWithStatus:[dic safeObjectForKey:@"errorMsg"]];
    if ([DBSVProgressHUD sharedView].typeView) {
        [DBSVProgressHUD sharedView].typeView.userInteractionEnabled = YES;
    }
}

/**
 隐藏HUD
 */
+ (void)db_dismiss{
    [super dismiss];
    if ([DBSVProgressHUD sharedView].typeView) {
        [DBSVProgressHUD sharedView].typeView.userInteractionEnabled = YES;
    }
}

@end
