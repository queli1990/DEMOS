//
//  ViewController.m
//  test
//
//  Created by Holy on 16/11/24.
//  Copyright © 2016年 Holy. All rights reserved.
//

#import "ViewController.h"
#import "IOS.h"

@interface ViewController () <UIWebViewDelegate,JSExport>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIWebView *webview = [[UIWebView alloc] initWithFrame:CGRectMake(0, 20, 375, 667-20)];
    webview.backgroundColor = [UIColor cyanColor];
    webview.delegate = self;
    
    
    NSString *resourcePath = [[NSBundle mainBundle] resourcePath];
    NSString *filePath = [resourcePath stringByAppendingPathComponent:@"test.html"];
    NSString *htmlstring=[[NSString alloc] initWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    [webview loadHTMLString:htmlstring baseURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]]];
    
    [self.view addSubview:webview];

}


- (void)webViewDidFinishLoad:(UIWebView *)webView{
    // 获取webView上的js
    JSContext *context = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    
    IOS *ios = [IOS new];
    context[@"IOS"] = ios;
    

//下面的做法据说太暴力，但是理解起来方便,步骤简洁
//    context[@"test"] = ^(){
//        NSLog(@"xxxxxx");
//    };
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
