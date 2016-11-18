//
//  ViewController.m
//  VegoTVWeb
//
//  Created by mobile_007 on 16/11/9.
//  Copyright © 2016年 QL. All rights reserved.
//

#import "ViewController.h"
#import <WebKit/WebKit.h>
#import <MediaPlayer/MediaPlayer.h>


@interface ViewController () <WKNavigationDelegate,WKUIDelegate>

@property (nonatomic, strong) MPVolumeView *airPlayButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc]init];
    
    configuration.allowsInlineMediaPlayback=true;
    configuration.mediaTypesRequiringUserActionForPlayback = NO;
    
    // 创建WKWebView
    WKWebView *webView = [[WKWebView alloc] initWithFrame:CGRectMake(0,40,[UIScreen mainScreen].bounds.size.width,[UIScreen mainScreen].bounds.size.height-40) configuration: configuration];
//    webView.navigationDelegate = self;
    // 设置访问的URL
    NSURL *url = [NSURL URLWithString:@"http://www.iqiyi.com/"];
    
    webView.translatesAutoresizingMaskIntoConstraints = NO;
    
    webView.allowsBackForwardNavigationGestures = YES;
    // 根据URL创建请求
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    // WKWebView加载请求
    [webView loadRequest:request];
    
    // 将WKWebView添加到视图
    [self.view addSubview:webView];
    
    
    
    //AirPlay按钮
    MPVolumeView *volume = [[MPVolumeView alloc] initWithFrame:CGRectMake(0, 20, 20, 20)];
    volume.backgroundColor = [UIColor cyanColor];
    volume.showsVolumeSlider = NO;
    [volume sizeToFit];
//    [self.view addSubview:volume];
    
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(videoStarted:) name:UIWindowDidBecomeVisibleNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(videoFinished:) name:UIWindowDidBecomeHiddenNotification object:nil];
}

- (void) videoStarted:(NSNotification *)noti{
    NSLog(@"start");
}

- (void) videoFinished:(NSNotification *) noti{
    NSLog(@"exit");
}

// 类似 UIWebView的 -webView: shouldStartLoadWithRequest: navigationType:

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    
    NSString *strRequest = [navigationAction.request.URL.absoluteString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"%@",strRequest);
    
    if([strRequest isEqualToString:@"about:blank"]) {//主页面加载内容
//        decisionHandler(WKNavigationActionPolicyAllow);//允许跳转
    } else {//截获页面里面的链接点击
        //do something you want
//        decisionHandler(WKNavigationActionPolicyCancel);//不允许跳转
    }
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
