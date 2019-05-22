//
//  DBNaviViewController.h
//  db_ios_sdk
//
//  Created by 管家人 on 2019/5/13.
//  Copyright © 2019 管家人. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DBNaviViewController : UINavigationController

/**
 导航一些初始化设置

 @param background 背景色
 @param titleColor 标题颜色
 @param titleFont 标题字体大小
 @param backImg 返回按钮图片
 */
-(void)setupBackground:(UIColor *)background titleColor:(UIColor *)titleColor titleFont:(NSInteger) titleFont backImg:(UIImage *)backImg;

@end

NS_ASSUME_NONNULL_END
