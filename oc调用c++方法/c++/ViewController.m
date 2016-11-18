//
//  ViewController.m
//  c++
//
//  Created by mobile_007 on 16/11/8.
//  Copyright © 2016年 QL. All rights reserved.
//

#import "ViewController.h"
#import "RootViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    RootViewController *tt = [[RootViewController alloc] init];
    [tt testFunc];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
