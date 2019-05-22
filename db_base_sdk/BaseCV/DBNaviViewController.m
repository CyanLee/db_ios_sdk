//
//  DBNaviViewController.m
//  db_ios_sdk
//
//  Created by 管家人 on 2019/5/13.
//  Copyright © 2019 管家人. All rights reserved.
//

#import "DBNaviViewController.h"
#import "DBBaseViewController.h"

@interface DBNaviViewController ()

@property (nonatomic,strong) UIImage *backImg;

@end

@implementation DBNaviViewController

-(void)setupBackground:(UIColor *)background titleColor:(UIColor *)titleColor titleFont:(NSInteger) titleFont backImg:(UIImage *)backImg{
    [self setupBackground:background];
    [self setupTitleFont:titleFont titleColor:titleColor];
    self.backImg = backImg;
    [[UINavigationBar appearance] setTranslucent:NO];
}


/**
 设置背景色

 @param background background
 */
-(void)setupBackground:(UIColor *)background{
    self.navigationBar.barTintColor = background;
}


/**
 设置标题颜色和标题字体大小

 @param titleFont 字体大小
 @param titleColor 字体颜色
 */
-(void)setupTitleFont:(NSInteger)titleFont titleColor:(UIColor *)titleColor{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[NSFontAttributeName] = [UIFont systemFontOfSize:titleFont];
    dict[NSForegroundColorAttributeName] = titleColor;
    [self.navigationBar setTitleTextAttributes:dict];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


/**
 重写backImgset方法

 @param backImg backImg
 */
-(void)setBackImg:(UIImage *)backImg{
    _backImg = backImg;
}


/**
 返回的截取

 @param viewController 当前控制器
 @param animated 动画效果
 */
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.childViewControllers.count > 0) {//非根控制器
        viewController.hidesBottomBarWhenPushed = YES;
        [(DBBaseViewController *)viewController setBackImg:self.backImg];
    }
    [super pushViewController:viewController animated:animated];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
