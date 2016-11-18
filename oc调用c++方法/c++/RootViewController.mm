//
//  RootViewController.m
//  c++
//
//  Created by mobile_007 on 16/11/8.
//  Copyright © 2016年 QL. All rights reserved.
//

#import "RootViewController.h"
#include "test.hpp"

static Test *pTest=NULL;

@implementation RootViewController

- (id) init {
    if (self = [super init]) {
        if (!pTest) {
            pTest = new Test();
        }
    }
    return self;
}

- (void) testFunc {
    if (pTest) {
        pTest -> test(); // -> c++指针  调用公有变量和方法
                         // .  c++ 对象  调用公有变量和方法
    }
    Test::testStatic();
}

//- (void) dealloc{
//    if (pTest) {
//        delete pTest;
//    }
//    [super dealloc];
//}

@end
