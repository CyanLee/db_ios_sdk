//
//  DBSVProgressHUD.h
//  db_base_sdk
//
//  Created by 管家人 on 2019/5/20.
//  Copyright © 2019 管家人. All rights reserved.
//  这里是继承SVProgressHUD,如果需要其他扩展,继承DBSVProgressHUD自行扩展
//  DBSVProgressHUD新增了2个方法

#import "SVProgressHUD.h"

NS_ASSUME_NONNULL_BEGIN

@interface DBSVProgressHUD : SVProgressHUD

+ (DBSVProgressHUD*)sharedView;

/**
 指定某个视图一直显示 不会消失

 @param view 指定的视图
 */
+(void)db_showWithView:(UIView *)view;

/**
 显示错误信息
 
 @param error 错误信息
 */
+ (void)db_showError:(NSError *)error;

/**
 隐藏HUD
 */
+ (void)db_dismiss;

@end

NS_ASSUME_NONNULL_END
