//
//  DBBaseViewController.m
//  db_ios_sdk
//
//  Created by 管家人 on 2019/5/13.
//  Copyright © 2019 管家人. All rights reserved.
//

#import "DBBaseViewController.h"


@interface DBBaseViewController ()

@end

@implementation DBBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initialize];
    [self createUI];
    // Do any additional setup after loading the view.
}

-(void)initialize{
    
}

-(void)createUI{
    self.view.backgroundColor = [UIColor whiteColor];
}

/**
 设置返回按钮
 */
-(void)setBackButton{
    UIBarButtonItem *leftButtonItem = [self backItemWithImage:self.backImg highImage:self.backImg target:self action:@selector(popViewControllerAnimated)];
    self.navigationItem.leftBarButtonItem = leftButtonItem;
}

//导航栏返回按钮
- (UIBarButtonItem *)backItemWithImage:(UIImage *)image highImage:(UIImage *)highImage target:target action:(SEL)action{
    UIButton *backBtn = [[UIButton alloc] init];
    [backBtn setImage:image forState:UIControlStateNormal];
    [backBtn setImage:highImage forState:UIControlStateHighlighted];
    [backBtn sizeToFit];
    //设置按钮内边距 调整位置  按道理超出父控件的 会不显示  但是因为在导航栏 系统内部做了处理，左边右边是按钮的 系统会自动扩充按钮的面积
    backBtn.contentEdgeInsets = UIEdgeInsetsMake(0, -15, 0, 0);
    //覆盖了系统做法 就没有系统的默认返回 也没有了点击屏幕侧边返回的功能
    //监听点击 返回
    [backBtn addTarget:target action:action forControlEvents:UIControlEventTouchDown];
    return [[UIBarButtonItem alloc] initWithCustomView:backBtn];
}

/**
 获取底部安全区域的高度
 
 @return 安全区域的高度
 */
-(float)getSafeAreaBottomHeight{
    if (@available(iOS 11.0, *)) {
        return [[[UIApplication sharedApplication] delegate] window].safeAreaInsets.bottom;
    }else{
        return 0.0f;
    }
}

/**
 导航返回事件
 */
-(void)popViewControllerAnimated{
    [self.navigationController popViewControllerAnimated:YES];
}

/**
 跳转界面
 
 @param className 指定的界面名称
 @param pushData 跳转是携带的参数
 @param popBlock 这个是反向传值用的block,不需要nil就行
 */
-(void)pushClassName:(NSString *)className pushData:(__nullable id)pushData popBlock:(void (^ __nullable)(__nullable id popData))popBlock{
    Class c = NSClassFromString(className);
    DBBaseViewController *vc = [[c alloc]init];
    vc.pushData = pushData;
    [vc setPopBlock:^(id  _Nullable popData) {
        if (popBlock) {
            popBlock(popData);
        }

    }];
    [self.navigationController pushViewController:vc animated:YES];
}

/**
 返回上一个界面
 
 @param popData 反向传值的数据
 */
-(void)popViewControllerPopData:(__nullable id)popData{
    [self.navigationController popViewControllerAnimated:YES];
    NSInteger index = self.navigationController.viewControllers.count-1;
    DBBaseViewController *vv = self.navigationController.viewControllers[index];
    if (self.popBlock) {
        self.popBlock(popData);
    }
    [self.navigationController popToViewController:vv animated:YES];
}

/**
 返回到指定的同级界面(同一个tabbar)
 
 @param specifiedVc 要跳转的控制器名称
 */
-(void)popViewControllerSpecified:(NSString *)specifiedVc{
    Class class = NSClassFromString(specifiedVc);
    UIViewController *vv = [[class alloc] init];
    for (UIViewController *controller in self.navigationController.viewControllers) {
        if ([controller isKindOfClass:[vv class]]) {
            [self.navigationController popToViewController:controller animated:YES];
        }
    }
}

/**
 推出新的界面
 
 @param className 指定的界面名称
 @param pushData 跳转是携带的参数
 @param popBlock 这个是反向传值用的block,不需要nil就行
 */
-(void)presentClassName:(NSString *)className pushData:(__nullable id)pushData popBlock:(void (^ __nullable)(__nullable id popData))popBlock{
    Class c = NSClassFromString(className);
    DBBaseViewController *vc = [[c alloc]init];
    vc.pushData = pushData;
    [vc setPopBlock:^(id  _Nullable popData) {
        if (popBlock) {
            popBlock(popData);
        }
        
    }];
    [self presentViewController:vc animated:YES completion:nil];
}


/**
 退出这个界面
 
 @param popData 反向传值的数据
 */
-(void)dismissViewControllerPopData:(__nullable id)popData{
    [self dismissViewControllerAnimated:YES completion:nil];
}

/**
 返回到tabbar首页
 
 @param vc 当前控制器
 @param tabbarIndex 跳转到第几个tabbar
 */
-(void)popMainTabbar:(UIViewController *)vc tabbarIndex:(NSInteger)tabbarIndex{
    UIViewController *controller = [UIApplication sharedApplication].delegate.window.rootViewController;
    UITabBarController *rvc = (UITabBarController *)controller;
    [rvc setSelectedIndex:tabbarIndex];
    [vc.navigationController popToRootViewControllerAnimated:YES];
}

/**
 获取当前版本号
 
 @return app当前版本号
 */
-(NSString *)getAppVersion{
    NSDictionary *dict =  [NSBundle mainBundle].infoDictionary;
    NSString *appVersion = dict[@"CFBundleShortVersionString"];
    return appVersion;
}

/**
 修改状态栏颜色
 
 @param type 1:为白色 0:黑色
 @param animated 动画效果
 */
-(void)setStatusBarStyleType:(NSInteger)type animated:(BOOL)animated {
    if (type == 0) {
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:animated];
    }else{
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:animated];
    }
}

#pragma getset方法
- (void)setBackImg:(UIImage *)backImg{
    _backImg = backImg;
    [self setBackButton];
}

-(void)setPushData:(id)pushData{
    if (pushData == nil) {
        pushData = @"";
    }
    _pushData = pushData;
    
}

@end
