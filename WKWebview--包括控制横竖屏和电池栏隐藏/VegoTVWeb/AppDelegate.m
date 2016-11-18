//
//  AppDelegate.m
//  VegoTVWeb
//
//  Created by mobile_007 on 16/11/9.
//  Copyright © 2016年 QL. All rights reserved.
//

#import "AppDelegate.h"
#import "HomeViewController.h"

@interface AppDelegate ()
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    HomeViewController *vc = [[HomeViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
//    nav.navigationBarHidden = YES;
    self.window.rootViewController = nav;
    
    [self initializeTheNotificationCenter];
    
    return YES;
}

- (void)initializeTheNotificationCenter
{
    //在进入需要全屏的界面里面发送需要全屏的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(startFullScreen) name:@"startFullScreen" object:nil];//进入全屏
    
    //在退出需要全屏的界面里面发送退出全屏的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(endFullScreen) name:@"endFullScreen" object:nil];//退出全屏
    
}

#pragma mark 进入全屏
-(void)startFullScreen
{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    appDelegate.allowRotation = YES;
}

#pragma mark    退出横屏
-(void)endFullScreen
{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    appDelegate.allowRotation = NO;
    
    //强制归正：
    if ([[UIDevice currentDevice]   respondsToSelector:@selector(setOrientation:)]) {
        SEL selector =     NSSelectorFromString(@"setOrientation:");
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];
        [invocation setSelector:selector];
        [invocation setTarget:[UIDevice currentDevice]];
        int val =UIInterfaceOrientationPortrait;
        [invocation setArgument:&val atIndex:2];
        [invocation invoke];
    }
}

#pragma mark    禁止横屏
- (UIInterfaceOrientationMask )application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window
{
    if (self.allowRotation) {
        return UIInterfaceOrientationMaskLandscapeLeft | UIInterfaceOrientationMaskLandscapeRight | UIInterfaceOrientationMaskPortrait;
    }
    return UIInterfaceOrientationMaskPortrait;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
