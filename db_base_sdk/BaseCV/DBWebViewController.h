//
//  DBWebViewController.h
//  db_ios_sdk
//
//  Created by 管家人 on 2019/5/22.
//  Copyright © 2019 管家人. All rights reserved.
//

#import "DBBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN
@class WKWebView,WKNavigation,WKUserContentController,WKScriptMessage;
@protocol DBWebViewControllerDelegate <NSObject>

@optional
/**
 页面开始加载时调用

 @param webView 当前加载的webview
 @param navigation  <#navigation description#>
 */
-(void)webView:(WKWebView *)webView db_didStartProvisionalNavigation:(WKNavigation *)navigation;


/**
 当内容开始返回时调用

 @param webView 当前加载的webview
 @param navigation  <#navigation description#>
 */
- (void)webView:(WKWebView *)webView db_didCommitNavigation:(WKNavigation *)navigation;


/**
 页面加载完成之后调用类似 UIWebView 的 －webViewDidFinishLoad:

 @param webView 当前加载的webview
 @param navigation <#navigation description#>
 */
- (void)webView:(WKWebView *)webView db_didFinishNavigation:(WKNavigation *)navigation;


/**
 js交互后的处理

 @param userContentController 当前交互的界面?
 @param message 交互获取的交互参数
 */
- (void)userContentController:(WKUserContentController *)userContentController db_didReceiveScriptMessage:(WKScriptMessage *)message;

/**
 加载失败时调用 类似 UIWebView 的- webView:didFailLoadWithError:

 @param webView 当前加载的webview
 @param navigation <#navigation description#>
 @param error 错误
 */
- (void)webView:(WKWebView *)webView db_didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error;

@end

@interface DBWebViewController : DBBaseViewController


@property(nonatomic,weak)id<DBWebViewControllerDelegate> delegate;

/**
 重新初始化方法

 @param url 要展示的url
 @param title 标题 不需要可以填nil
 @return DBWebViewController
 */
-(instancetype)initWithUrl:(NSString *)url title:(nullable NSString *)title;


/**
 需要交互的方法名

 @param scriptMessageArr 方法名[@"xxs"];
 */
-(void)setScriptMessageArr:(NSArray <NSString *> *)scriptMessageArr;


@end

NS_ASSUME_NONNULL_END
