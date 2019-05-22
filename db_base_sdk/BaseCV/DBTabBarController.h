//
//  DBTabBarController.h
//  db_ios_sdk
//
//  Created by 管家人 on 2019/5/13.
//  Copyright © 2019 管家人. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, DBTabBarItemStatus) {
    DBTabBarItemStatusSelected, //选中状态
    DBTabBarItemStatusDefault, //默认状态
};

@interface DBTabBarController : UITabBarController

@property (nonatomic,copy) void (^actionSelectBlock)(UIViewController *targetVc,UIViewController *pushVc);

//初始化（控制器名称数组）
- (instancetype)initWithChildControllerNames:(NSArray<NSString *> *)names;

//标签标题
- (void)itemTitles:(NSArray <NSString *>*)titles;
- (DBTabBarController *(^)(NSArray <NSString *>*titles))setupItemTitles;

//标签标题颜色 [统一]
- (void)itemsTitleColor:(UIColor *)color status:(DBTabBarItemStatus)status;
- (DBTabBarController *(^)(UIColor *))setupItemsTitleDefaultColor;
- (DBTabBarController *(^)(UIColor *))setupItemsTitleSelectedColor;

//字体大小
- (DBTabBarController *(^)(NSInteger))setupItemsTitleDefaultFont;
- (DBTabBarController *(^)(NSInteger))setupItemsTitleSelectedFont;

//标签标题颜色 [不统一]
- (void)itemTitleColor:(UIColor *)color atIndex:(NSInteger)idx status:(DBTabBarItemStatus)status;

//去除tabbar顶部黑线
-(void)removeTabbarTopBlackLine;

//设置选中图片
- (DBTabBarController *(^)(NSArray <NSString *>*imageName))setUpSelectImages;

//设置未选中图片
- (DBTabBarController *(^)(NSArray <NSString *>*imageName))setUpUnSelectImages;

@end

NS_ASSUME_NONNULL_END
