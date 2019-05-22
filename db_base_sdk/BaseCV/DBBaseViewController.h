//
//  DBBaseViewController.h
//  db_ios_sdk
//
//  Created by 管家人 on 2019/5/13.
//  Copyright © 2019 管家人. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DBBaseViewController : UIViewController

/**
 返回按钮图片(一般不需要设置,只有在DBNaviViewController才需要设置)
 */
@property (nonatomic,strong) UIImage *backImg;

/**
 跳转是携带的参数
 */
@property (nonatomic,strong) id pushData;

/**
 反向传值使用的block
 */
@property (nonatomic,copy) void(^popBlock)(__nullable id popData);

/**
 跳转界面
 注意:如果是按导航的箭头返回,是没有反向传值,需要自己重新popViewControllerAnimated方法
 @param className 指定的界面名称
 @param pushData 跳转是携带的参数
 @param popBlock 这个是反向传值用的block,不需要nil就行
 */
-(void)pushClassName:(NSString *)className pushData:(__nullable id)pushData popBlock:(void (^ __nullable)(__nullable id popData))popBlock;

/**
 返回到指定的同级界面(同一个tabbar)
 
 @param specifiedVc 要跳转的控制器名称
 */
-(void)popViewControllerSpecified:(NSString *)specifiedVc;


/**
 返回上一个界面
 注意:如果是按导航的箭头返回,是没有反向传值,需要自己重新popViewControllerAnimated方法
 @param popData 反向传值的数据
 */
-(void)popViewControllerPopData:(__nullable id)popData;

/**
 返回到tabbar首页
 
 @param vc 当前控制器
 @param tabbarIndex 跳转到第几个tabbar
 */
-(void)popMainTabbar:(UIViewController *)vc tabbarIndex:(NSInteger)tabbarIndex;

/**
 推出新的界面
 
 @param className 指定的界面名称
 @param pushData 跳转是携带的参数
 @param popBlock 这个是反向传值用的block,不需要nil就行
 */
-(void)presentClassName:(NSString *)className pushData:(__nullable id)pushData popBlock:(void (^ __nullable)(__nullable id popData))popBlock;


/**
 退出这个界面
 
 @param popData 反向传值的数据
 */
-(void)dismissViewControllerPopData:(__nullable id)popData;

/**
 获取底部安全区域的高度

 @return 安全区域的高度
 */
-(float)getSafeAreaBottomHeight;


/**
 获取当前版本号

 @return app当前版本号
 */
-(NSString *)getAppVersion;


/**
 修改状态栏颜色

 @param type 1:为白色 0:黑色
 @param animated 动画效果
 */
-(void)setStatusBarStyleType:(NSInteger)type animated:(BOOL)animated;

@end

NS_ASSUME_NONNULL_END
