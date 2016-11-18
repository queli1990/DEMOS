//
//  HomeViewController.m
//  VegoTVWeb
//
//  Created by mobile_007 on 16/11/11.
//  Copyright © 2016年 QL. All rights reserved.
//

#import "HomeViewController.h"
#import <WebKit/WebKit.h>
#import <MediaPlayer/MediaPlayer.h>

//define this constant if you want to use Masonry without the 'mas_' prefix
#define MAS_SHORTHAND
/**
 #define MAS_SHORTHAND  一定要写在   #import "Masonry.h"的前面
 */
#define MAS_SHORTHAND_GLOBALS

#import "Masonry.h"
#import "AppDelegate.h"
#import <MediaPlayer/MediaPlayer.h>


@interface HomeViewController () <WKNavigationDelegate,WKScriptMessageHandler>
@property (nonatomic,strong) WKWebView *webview;
@property (nonatomic,strong) WKUserContentController *config;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBarHidden = YES;
    
    [self initWKWeb];
    
}

- (void) hidden{
    NSLog(@"隐藏");
//    [UIApplication sharedApplication].statusBarHidden = YES;//电池栏是否隐藏
    
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];//控制横竖屏
    delegate.allowRotation = YES;
}

- (void) show{
    NSLog(@"show");
//    [UIApplication sharedApplication].statusBarHidden = NO;//电池栏是否隐藏
    
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"startFullScreen" object:nil];
    
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];//控制横竖屏
    delegate.allowRotation = NO;
}

- (void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear: animated];
    [self performSelector:@selector(hidden) withObject:nil afterDelay:5];
    [self performSelector:@selector(show) withObject:nil afterDelay:15];
}

#pragma mark -WKWebview的设置
- (void) initWKWeb{
    
    UIView *shadeView = [[UIView alloc] init];
    shadeView.backgroundColor = [UIColor whiteColor];
//    [shadeView layoutIfNeeded];
    [self.view addSubview:shadeView];
    
    [shadeView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.left);
        make.right.equalTo(self.view.right);
        make.height.equalTo(20);
        make.top.equalTo(self.view.top);
    }];
    
    
    WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
    configuration.allowsInlineMediaPlayback = YES;//允许播放视频
//    configuration.mediaPlaybackAllowsAirPlay = YES; //是否允许AirPlay后台播放
    configuration.mediaTypesRequiringUserActionForPlayback = NO;//是否需要用户同意才开始播放
    
    //js和webview内容交互
    configuration.userContentController = [[WKUserContentController alloc] init];
    // 注入JS对象名称senderModel，当JS通过senderModel来调用时，我们可以在WKScriptMessageHandler代理中接收到
    [configuration.userContentController addScriptMessageHandler:self name:@"senderModel"];
    
    
    self.webview = [[WKWebView alloc] initWithFrame:CGRectMake(0, 20, ScreenWidth, ScreenHeight-20) configuration:configuration];
    _webview.navigationDelegate = self;
    NSURL *url = [NSURL URLWithString:@"http://www.iqiyi.com/"];//加载网址   wechattest.vego.tv
    _webview.translatesAutoresizingMaskIntoConstraints = NO;
    _webview.allowsBackForwardNavigationGestures = YES;//允许手势返回
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [_webview loadRequest:request];
//    [_webview layoutIfNeeded];
    [self.view addSubview:_webview];

    [_webview makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.left);
        make.top.equalTo(20);
        make.right.equalTo(self.view.right);
        make.bottom.equalTo(self.view.bottom);
    }];
    
}

#pragma make - 电池栏横竖屏时都不会消失，同时plist文件中添加View controller-based status bar appearance字段
- (BOOL)prefersStatusBarHidden{
    return NO;
}







#pragma mark - WKScriptMessageHandler 代理方法
- (void)userContentController:(WKUserContentController *)userContentController
      didReceiveScriptMessage:(WKScriptMessage *)message {
    if ([message.name isEqualToString:@"senderModel"]) {
        // 打印所传过来的参数，只支持NSNumber, NSString, NSDate, NSArray,
        // NSDictionary, and NSNull类型
        //do something
        NSLog(@"%@", message.body);
        NSLog(@"代理走了");
    }
}

#pragma mark - WKNavigationDelegate
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    NSURL *URL = navigationAction.request.URL;
    NSString *scheme = [URL scheme];
//    NSLog(@"loadingURL:%@",URL);
    decisionHandler(WKNavigationActionPolicyAllow);
}

#pragma mark -与js的交互
- (void)getLocation{
    // 获取位置信息
    // 将结果返回给js
    NSString *jsStr = [NSString stringWithFormat:@"setLocation('%@')",@"广东省深圳市南山区学府路XXXX号"];
    [self.webview evaluateJavaScript:jsStr completionHandler:^(id _Nullable result, NSError * _Nullable error) {
        NSLog(@"%@----%@",result, error);
    }];
}


#pragma mark -WKWebview的加载顺序
- (void) webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
//    NSLog(@"1");
}

- (void) webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation{}

- (void) webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error{}






- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
