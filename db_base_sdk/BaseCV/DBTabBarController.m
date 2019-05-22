//
//  DBTabBarController.m
//  db_ios_sdk
//
//  Created by 管家人 on 2019/5/13.
//  Copyright © 2019 管家人. All rights reserved.
//

#import "DBTabBarController.h"
#import "DBBaseViewController.h"
#import "DBNaviViewController.h"

@interface DBTabBarController ()

@end

@implementation DBTabBarController

//初始化（控制器名称数组）
- (instancetype)initWithChildControllerNames:(NSArray<NSString *> *)names{
    if (self = [super init]) {
        
        [[UITabBar appearance] setBarTintColor:[UIColor redColor]];
        [UITabBar appearance].translucent = NO;
        
        [self configChildControllerWithNames:names];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark - ---------- Private Methods ----------

//根据名字初始化子视图控制器
- (void)configChildControllerWithNames:(NSArray <NSString *>*)names {
    [self setViewControllers:[self navigationControllersWithStr:names]];
}

- (NSArray *)navigationControllersWithStr:(NSArray <NSString *>*)strArr{
    NSMutableArray *naviVCArr = [NSMutableArray array];
    for (int i = 0; i < strArr.count; i++) {
        Class c = NSClassFromString([strArr objectAtIndex:i]);
        DBBaseViewController *VC = [[c alloc]init];
        DBNaviViewController *naviVC = [[DBNaviViewController alloc]initWithRootViewController:VC];
        [naviVC setupBackground:[UIColor purpleColor] titleColor:[UIColor orangeColor] titleFont:20 backImg:[UIImage imageNamed:@"ni"]];
        [naviVCArr addObject:naviVC];
    }
    return naviVCArr;
}

#pragma mark - ---------- Public Methods ----------
//标签标题
- (void)itemTitles:(NSArray <NSString *>*)titles {
    [self.childViewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.tabBarItem.title = titles[idx];
    }];
}
//标签标题(链式)
- (DBTabBarController *(^)(NSArray <NSString *>*titles))setupItemTitles {
    return ^(NSArray <NSString *>*titles) {
        [self.childViewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            obj.tabBarItem.title = titles[idx];
        }];
        return self;
    };
}

- (DBTabBarController *(^)(NSArray <NSString *>*imageName))setUpSelectImages{
    return ^(NSArray <NSString *>*imageNames){
        [self.childViewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            obj.tabBarItem.selectedImage = [UIImage imageNamed:imageNames[idx]];
            [obj.tabBarController.tabBar setTintColor:[UIColor purpleColor]];
        }];
        return self;
    };
}

- (DBTabBarController *(^)(NSArray <NSString *>*imageName))setUpUnSelectImages{
    return ^(NSArray <NSString *>*imageNames){
        [self.childViewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            obj.tabBarItem.image = [UIImage imageNamed:imageNames[idx]];
            [obj.tabBarController.tabBar setUnselectedItemTintColor:[UIColor grayColor]];
        }];
        return self;
    };
}

//标签标题未选中状态颜色
- (void)itemsTitleColor:(UIColor *)color status:(DBTabBarItemStatus)status {
    [self.childViewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIControlState state = (status == DBTabBarItemStatusSelected) ? UIControlStateSelected : UIControlStateNormal;
        [obj.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:color,NSForegroundColorAttributeName, nil] forState:state];
    }];
}

- (DBTabBarController *(^)(UIColor *))setupItemsTitleDefaultColor {
    return ^(UIColor *color) {
        [self.childViewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [obj.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:color,NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
        }];
        return self;
    };
}

- (DBTabBarController *(^)(UIColor *))setupItemsTitleSelectedColor {
    return ^(UIColor *color) {
        [self.childViewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [obj.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:color,NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
        }];
        return self;
    };
}

//字体大小
- (DBTabBarController *(^)(NSInteger))setupItemsTitleDefaultFont{
    return ^(NSInteger font) {
        [self.childViewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [obj.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:font],NSFontAttributeName, nil] forState:UIControlStateNormal];
        }];
        return self;
    };
}
- (DBTabBarController *(^)(NSInteger))setupItemsTitleSelectedFont{
    return ^(NSInteger font) {
        [self.childViewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [obj.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:font],NSFontAttributeName, nil] forState:UIControlStateSelected];
        }];
        return self;
    };
}

//标签标题颜色 [不统一]
- (void)itemTitleColor:(UIColor *)color atIndex:(NSInteger)idx status:(DBTabBarItemStatus)status {
    UIViewController *vc = self.childViewControllers[idx];
    UIControlState state = (status == DBTabBarItemStatusDefault) ? UIControlStateNormal : UIControlStateSelected;
    [vc.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:color,NSForegroundColorAttributeName, nil] forState:state];
}

-(void)removeTabbarTopBlackLine
{
    //方法1
    [UITabBar appearance].clipsToBounds = YES;
    //方法2
    [[UITabBar appearance] setBackgroundColor:[UIColor whiteColor]];
    [[UITabBar appearance] setBarTintColor:[UIColor whiteColor]];
    [[UITabBar appearance] setBackgroundImage:[UIImage imageNamed:@"tabbarImage.png"]];
    [UITabBar appearance].clipsToBounds = YES;
    [[UITabBar appearance] setShadowImage:[UIImage imageNamed:@"tabbarImage.png"]];
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
    DBNaviViewController *navVC = (DBNaviViewController *)viewController;
    DBNaviViewController *navSelectVC = (DBNaviViewController *)tabBarController.selectedViewController;
    UIViewController *vc = navVC.viewControllers[0];
    UIViewController *selectedVC = navSelectVC.viewControllers[0];
    
    if (self.actionSelectBlock) {
        self.actionSelectBlock(vc, selectedVC);
    }
    
    return YES;
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
