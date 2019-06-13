//
//  UITableView+JKAdd.h
//  链式响应Demo
//
//  Created by 管家人 on 2019/5/27.
//  Copyright © 2019 管家人. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JKTableViewHelper.h"

NS_ASSUME_NONNULL_BEGIN

@interface UITableView (JKAdd)

/*
 链式开发 作为指向 JKTableViewHelper 这个中间件
 遇到的问题
 1.JKTableViewHelper中间件没有被持有 导致列表出现后马上消失
 */
-(JKTableViewHelper *(^)(void))makeConfigureHelper;

@end

NS_ASSUME_NONNULL_END
