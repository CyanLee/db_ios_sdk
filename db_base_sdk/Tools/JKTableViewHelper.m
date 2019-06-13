//
//  JKTableViewHelper.m
//  链式响应Demo
//
//  Created by 管家人 on 2019/5/27.
//  Copyright © 2019 管家人. All rights reserved.
//

#import "JKTableViewHelper.h"
#import <UIKit/UIKit.h>

@interface JKTableViewHelper ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UITableView *tableView;

/**
 分区数(内->外)
 */
@property (nonatomic, copy) DBSectionIndexNumBlock sectionIndexNumCall;

/**
 row数(内->外)
 */
@property (nonatomic, copy) DBRowIndexNumBlock rowIndexNumCall;

/**
 cell的样式(内->外)
 */
@property (nonatomic, copy) DBCellCallBlock cellCall;

/**
 headerView样式(内->外)
 */
@property (nonatomic, copy) DBHeaderViewBlock headerViewCall;

/**
 headerView高度(内->外)
 */
@property (nonatomic, copy) DBHeaderViewHeightBlock headerViewHeightCall;

/**
 footerView样式(内->外)
 */
@property (nonatomic, copy) DBFooterViewBlock footerViewCall;

/**
 footerView高度(内->外)
 */
@property (nonatomic, copy) DBFooterViewHeightBlock footerViewHeightCall;

/**
 点击事件(内->外)
 */
@property (nonatomic, copy) DBActionBlock actionCall;

@end

@implementation JKTableViewHelper


/**
 初始化
 把当前tableView与中间件进行绑定
 @param tableView 当前的tableView
 @return <#return value description#>
 */
-(instancetype)initWithTableView:(UITableView *)tableView{
    if (self = [super init]) {
        tableView.delegate = self;
        tableView.dataSource = self;
        _tableView = tableView;
    }
    return self;
}


/**
 链式响应的 调用(外->内)block 分区个数
 */
-(JKTableViewHelper *(^)(DBSectionIndexNumBlock block))sectionIndexNumBlock{
    return ^JKTableViewHelper * (DBSectionIndexNumBlock block) {
        if (block) {
            self.sectionIndexNumCall = block;
        }
        return self;
    };
}

/**
 链式响应的 调用(外->内)block row个数
 */
-(JKTableViewHelper *(^)(DBRowIndexNumBlock block))rowIndexNumBlock{
    return ^JKTableViewHelper * (DBRowIndexNumBlock block) {
        if (block) {
            self.rowIndexNumCall = block;
        }
        return self;
    };
}

/**
 链式响应的 调用(外->内)block cell样式
 */
-(JKTableViewHelper *(^)(DBCellCallBlock block))cellCallBlock{
    return ^JKTableViewHelper * (DBCellCallBlock block) {
        if (block) {
            self.cellCall = block;
        }
        return self;
    };
}

/**
 链式响应的 调用(外->内)block headerView样式
 */
-(JKTableViewHelper *(^)(DBHeaderViewBlock block))headerViewBlock{
    return ^JKTableViewHelper * (DBHeaderViewBlock block) {
        if (block) {
            self.headerViewCall = block;
        }
        return self;
    };
}

/**
 链式响应的 调用(外->内)block headerView高度
 */
-(JKTableViewHelper *(^)(DBHeaderViewHeightBlock block))headerViewHeightBlock{
    return ^JKTableViewHelper * (DBHeaderViewHeightBlock block) {
        if (block) {
            self.headerViewHeightCall = block;
        }
        return self;
    };
}

/**
 链式响应的 调用(外->内)block footerView样式
 */
-(JKTableViewHelper *(^)(DBFooterViewBlock block))footerViewBlock{
    return ^JKTableViewHelper * (DBFooterViewBlock block) {
        if (block) {
            self.footerViewCall = block;
        }
        return self;
    };
}

/**
 链式响应的 调用(外->内)block footerView高度
 */
-(JKTableViewHelper *(^)(DBFooterViewHeightBlock block))footerViewHeightBlock{
    return ^JKTableViewHelper * (DBFooterViewHeightBlock block) {
        if (block) {
            self.footerViewHeightCall = block;
        }
        return self;
    };
}

/**
 链式响应的 调用(外->内)block 点击事件
 */
-(JKTableViewHelper *(^)(DBActionBlock block))actionBlock{
    return ^JKTableViewHelper * (DBActionBlock block) {
        if (block) {
            self.actionCall = block;
        }
        return self;
    };
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (self.sectionIndexNumCall) {
        return self.sectionIndexNumCall(tableView);
    }else{
        return 1;
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.rowIndexNumCall(tableView,section);
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.cellCall(tableView,indexPath);
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.actionCall) {
        self.actionCall(tableView, indexPath);
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (self.headerViewCall) {
        return self.headerViewCall(tableView,section);
    }else{
        return [UIView new];
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (self.headerViewHeightCall) {
        return self.headerViewHeightCall(tableView,section);
    }else{
        return 0.0f;
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (self.footerViewCall) {
        return self.footerViewCall(tableView,section);
    }else{
        return [UIView new];
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (self.footerViewHeightCall) {
        return self.footerViewHeightCall(tableView,section);
    }else{
        return 0.0f;
    }
}


@end
