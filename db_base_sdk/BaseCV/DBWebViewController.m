//
//  DBWebViewController.m
//  db_ios_sdk
//
//  Created by 管家人 on 2019/5/22.
//  Copyright © 2019 管家人. All rights reserved.
//

#import "DBWebViewController.h"
#import<WebKit/WebKit.h>
#import <JavaScriptCore/JavaScriptCore.h>

@interface DBWebViewController ()<WKUIDelegate,WKNavigationDelegate,WKScriptMessageHandler>

@property (nonatomic, strong) WKWebView *webView;

@end

@implementation DBWebViewController

/**
 重新初始化方法
 
 @param url 要展示的url
 @param title 标题
 @return DBWebViewController
 */
-(instancetype)initWithUrl:(NSString *)url title:(nullable NSString *)title{
    if (self = [super init]) {
        if (title != nil || title.length > 0) {
            self.title = title;
        }
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
        [self.webView loadRequest:request];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initialize];
    [self createUI];
    // Do any additional setup after loading the view.
}

-(void)dealloc{
    [self.webView removeObserver:self forKeyPath:@"title"];
}

#pragma 初始化
-(void)initialize{
    [self.webView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:NULL];
}
#pragma 创建UI
-(void)createUI{
    
}
#pragma 私用方法
#pragma 公共方法
#pragma 点击事件
#pragma 代理协议
//跳转app商店 或者 通用链接下载
-(void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    if(webView != self.webView) {
        decisionHandler(WKNavigationActionPolicyAllow);
        return;
    }
    NSURL  * url = navigationAction.request.URL;
    UIApplication *app = [UIApplication sharedApplication];
    //    appstorte
    if ([url.absoluteString containsString:@"itunes.apple.com"]){
        if ([app canOpenURL:url]){
            if (@available(iOS 10.0, *)) {
                [app openURL:url options:@{} completionHandler:^(BOOL success) {
                }];
            } else {
                 [[UIApplication sharedApplication] openURL:url];
            }
            decisionHandler(WKNavigationActionPolicyCancel);
            return;
        }
    }
    if (!navigationAction.targetFrame.isMainFrame) {
        [self.webView loadRequest:navigationAction.request];
    }
    //    appstore的外的包
    if ([url.absoluteString containsString:@"itms-services://"]) {
        if (@available(iOS 10.0, *)) {
            [app openURL:url options:@{} completionHandler:^(BOOL success) {
                
            }];
        } else {
            [[UIApplication sharedApplication] openURL:url];
        }
        decisionHandler(WKNavigationActionPolicyCancel);
        return;
    }
    decisionHandler(WKNavigationActionPolicyAllow);
}

#pragma mark - WKNavigationDelegate 【该代理提供的方法，可以用来追踪加载过程（页面开始加载、加载完成、加载失败）、决定是否执行跳转。】
/**
 *  页面开始加载时调用
 */
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    if (self.delegate && [self.delegate respondsToSelector:@selector(webView:db_didStartProvisionalNavigation:)]) {
        [self.delegate webView:webView db_didStartProvisionalNavigation:navigation];
    }
}

/**
 *  当内容开始返回时调用
 */
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(webView:didCommitNavigation:)]) {
        [self.delegate webView:webView db_didCommitNavigation:navigation];
    }
}

/**
 *  页面加载完成之后调用类似 UIWebView 的 －webViewDidFinishLoad:
 */
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(webView:didFinishNavigation:)]) {
        [self.delegate webView:webView db_didFinishNavigation:navigation];
    }
}

//WKScriptMessageHandler协议方法
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    if (self.delegate && [self.delegate respondsToSelector:@selector(userContentController:db_didReceiveScriptMessage:)]) {
        [self.delegate userContentController:userContentController db_didReceiveScriptMessage:message];
    }
}

/**
 *  加载失败时调用 类似 UIWebView 的- webView:didFailLoadWithError:
 */
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(webView:db_didFailProvisionalNavigation:withError:)]) {
        [self.delegate webView:webView db_didFailProvisionalNavigation:navigation withError:error];
    }
}

#pragma 网络请求
#pragma 懒加载
/**
 需要交互的方法名
 
 @param scriptMessageArr 方法名[@"xxs"];
 */
-(void)setScriptMessageArr:(NSArray <NSString *> *)scriptMessageArr{
    for (int i = 0; i < scriptMessageArr.count; i++) {
        NSString *name = [scriptMessageArr objectAtIndex:i];
        [[self.webView configuration].userContentController addScriptMessageHandler:self name:name];
    }
}

#pragma getset方法
- (WKWebView *)webView{
    if (!_webView) {
        __weak typeof(self) weakSelf = self;
        _webView = [[WKWebView alloc]init];
        _webView.UIDelegate = self;
        _webView.navigationDelegate = self;
        [weakSelf.view addSubview:_webView];
        [_webView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(weakSelf.view).insets(UIEdgeInsetsMake(0, 0, 0, 0));
        }];
    }
    return _webView;
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
