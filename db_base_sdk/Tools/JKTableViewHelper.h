//
//  JKTableViewHelper.h
//  链式响应Demo
//
//  Created by 管家人 on 2019/5/27.
//  Copyright © 2019 管家人. All rights reserved.
//  对tableView的代理进行一个链式响应封装,tableView的所以代理方法都经过这个中间件来完成

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


/**
 分区数(内->外)

 @param tableView <#tableView description#>
 @return <#return value description#>
 */
typedef NSInteger (^DBSectionIndexNumBlock)(UITableView *tableView);


/**
 row数(内->外)

 @param tableView <#tableView description#>
 @param section <#section description#>
 @return <#return value description#>
 */
typedef NSInteger (^DBRowIndexNumBlock)(UITableView *tableView , NSInteger section);

/**
 cell的样式(内->外)

 @param tableView <#tableView description#>
 @param indexPath <#indexPath description#>
 @return <#return value description#>
 */
typedef UITableViewCell *(^DBCellCallBlock)(UITableView *tableView , NSIndexPath *indexPath);


/**
 headerView样式(内->外)

 @param tableView <#tableView description#>
 @param section <#section description#>
 @return <#return value description#>
 */
typedef UIView *(^DBHeaderViewBlock)(UITableView *tableView , NSInteger section);


/**
 headerView高度(内->外)

 @param tableView <#tableView description#>
 @param section <#section description#>
 @return <#return value description#>
 */
typedef NSInteger (^DBHeaderViewHeightBlock)(UITableView *tableView , NSInteger section);


/**
 footerView样式(内->外)

 @param tableView <#tableView description#>
 @param section <#section description#>
 @return <#return value description#>
 */
typedef UIView *(^DBFooterViewBlock)(UITableView *tableView , NSInteger section);

/**
 footerView高度(内->外)

 @param tableView <#tableView description#>
 @param section <#section description#>
 @return <#return value description#>
 */
typedef NSInteger (^DBFooterViewHeightBlock)(UITableView *tableView , NSInteger section);


/**
 点击事件(内->外)

 @param tableView <#tableView description#>
 @param indexPath <#indexPath description#>
 */
typedef void (^DBActionBlock)(UITableView *tableView , NSIndexPath *indexPath);


@interface JKTableViewHelper : NSObject 


/**
 工场方法
 主要是绑定当前的tableView
 @param tableView 当前的tableView
 @return <#return value description#>
 */
-(instancetype)initWithTableView:(UITableView *)tableView;

/**
 分区的个数(外->内)
 */
@property (nonatomic,copy,readonly) JKTableViewHelper *(^sectionIndexNumBlock)(DBSectionIndexNumBlock block);

/**
 row的个数(外->内)
 */
@property (nonatomic,copy,readonly) JKTableViewHelper *(^rowIndexNumBlock)(DBRowIndexNumBlock block);

/**
 cell的样式(外->内)
 */
@property (nonatomic,copy,readonly) JKTableViewHelper *(^cellCallBlock)(DBCellCallBlock block);

/**
 headerView样式(外->内)
 */
@property (nonatomic,copy,readonly) JKTableViewHelper *(^headerViewBlock)(DBHeaderViewBlock block);

/**
 headerView高度(外->内)
 */
@property (nonatomic,copy,readonly) JKTableViewHelper *(^headerViewHeightBlock)(DBHeaderViewHeightBlock block);

/**
 footerView样式(外->内)
 */
@property (nonatomic,copy,readonly) JKTableViewHelper *(^footerViewBlock)(DBFooterViewBlock block);

/**
 footerView高度(外->内)
 */
@property (nonatomic,copy,readonly) JKTableViewHelper *(^footerViewHeightBlock)(DBFooterViewHeightBlock block);

/**
 点击事件(外->内)
 */
@property (nonatomic,copy,readonly) JKTableViewHelper *(^actionBlock)(DBActionBlock block);

@end


NS_ASSUME_NONNULL_END
