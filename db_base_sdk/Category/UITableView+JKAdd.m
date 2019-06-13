//
//  UITableView+JKAdd.m
//  链式响应Demo
//
//  Created by 管家人 on 2019/5/27.
//  Copyright © 2019 管家人. All rights reserved.
//

#import "UITableView+JKAdd.h"
#import "JKTableViewHelper.h"
#import <objc/runtime.h>

@interface UITableView ()

@property (nonatomic, strong) JKTableViewHelper *helper;

@end

@implementation UITableView (JKAdd)

//通过runtime为分类添加存储属性
- (void)setHelper:(JKTableViewHelper *)helper {
    //使用runtime为分类绑定一个helper属性
    objc_setAssociatedObject(self, @selector(helper), helper, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (JKTableViewHelper *)helper {
    //获取关联的对象
    return objc_getAssociatedObject(self, @selector(helper));
}


/**
 创建中间件,并且对他持有
 */
-(JKTableViewHelper *(^)(void))makeConfigureHelper{
    return ^(void) {
        NSLog(@"123");
        JKTableViewHelper *helper = [[JKTableViewHelper alloc] initWithTableView:self];
        self.helper = helper;
        return self.helper;
    };
}

@end
