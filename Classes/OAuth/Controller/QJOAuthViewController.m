//
//  QJOAuthViewController.m
//  SinaWeibo
//
//  Created by 张庆杰 on 15/8/2.
//  Copyright (c) 2015年 QJ. All rights reserved.
//

#import "QJOAuthViewController.h"
#import "MBProgressHUD+MJ.h"
#import "QJHttpTool.h"
#import "QJNewfeatureViewController.h"
#import "QJTabBarViewController.h"
#import "QJControllerTool.h"
#import "QJAccount.h"
#import "QJAccountTool.h"

@interface QJOAuthViewController () <UIWebViewDelegate>

@end

@implementation QJOAuthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 创建webView
    UIWebView *webView = [[UIWebView alloc] init];
    [self.view addSubview:webView];
    webView.frame = self.view.bounds;
    
    // 发送请求
    NSString *urlStr = [NSString stringWithFormat:@"https://api.weibo.com/oauth2/authorize?client_id=%@&redirect_uri=%@", QJClient_id, QJRedirect_uri];
    NSURL *url = [NSURL URLWithString:urlStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
    
    // 设置webView代理
    webView.delegate = self;
}

#pragma mark - webView代理

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    NSString *url = request.URL.absoluteString;
    NSRange range = [url rangeOfString:@"http://www.or2z.com/?code="];
    if (range.location != NSNotFound) {
        NSString *code = [url substringFromIndex:range.location + range.length];
        
        [self accessTokenWithCode:code];
        
        return NO;
    }
    return YES;
}

-(void)webViewDidStartLoad:(UIWebView *)webView {
    [MBProgressHUD showMessage:@"正在加载中..." toView:self.view];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView {
    [MBProgressHUD hideHUDForView:self.view];
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [MBProgressHUD hideHUDForView:self.view];
}

#pragma mark - 公共方法
/**
 *  根据授权后的code获取AccessToken(发送POST请求)
 */
- (void)accessTokenWithCode:(NSString *)code {
    
    // 创建请求参数
    QJAccessTokenParam *params = [[QJAccessTokenParam alloc] init];
    params.client_id = QJClient_id;
    params.client_secret = QJClient_secret;
    params.grant_type = @"authorization_code";
    params.code = code;
    params.redirect_uri = QJRedirect_uri;
    
    // 发送POST请求
    [QJAccountTool accessTokenWithParams:params success:^(QJAccount *account) {
        // 存储账号模型
        [QJAccountTool save:account];
        
        // 选择根控制器
        [QJControllerTool chooseRootViewController];
    } failure:^(NSError *error) {
        NSLog(@"error = %@", error);
    }];
}

@end
