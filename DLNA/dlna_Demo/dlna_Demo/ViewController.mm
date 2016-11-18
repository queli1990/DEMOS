//
//  ViewController.m
//  dlna_Demo
//
//  Created by mobile_007 on 16/11/9.
//  Copyright © 2016年 QL. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()

@end

class MyDiscoveryDelegate: public Discovery::Delegate {
public:
    virtual void discovery_change(Discovery* dis) {
        
    }
    virtual void discovery_error(Discovery* dis, const string& err) {
        
    }
};

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIButton *start = [UIButton buttonWithType:UIButtonTypeSystem];
    [start setTitle:@"start" forState:UIControlStateNormal];
    start.frame = CGRectMake(0, 50, 40, 40);
    start.backgroundColor = [UIColor grayColor];
    [self.view addSubview:start];
    
    UIButton *stop = [UIButton buttonWithType:UIButtonTypeSystem];
    [stop setTitle:@"stop" forState:UIControlStateNormal];
    stop.frame = CGRectMake(50, 50, 40, 40);
    stop.backgroundColor = [UIColor grayColor];
    [self.view addSubview:stop];
    
    UIButton *scan = [UIButton buttonWithType:UIButtonTypeSystem];
    [scan setTitle:@"scan" forState:UIControlStateNormal];
    scan.frame = CGRectMake(100, 50, 40, 40);
    scan.backgroundColor = [UIColor grayColor];
    [self.view addSubview:scan];

    self.m_dis = new Discovery();
    
    self.m_dis->scan( Discovery::MEDIA_RENDERER );
    
    self.m_dis->set_delegate(nil);
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
