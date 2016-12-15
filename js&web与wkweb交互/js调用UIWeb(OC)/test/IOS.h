//
//  IOS.h
//  test
//
//  Created by Holy on 16/11/24.
//  Copyright © 2016年 Holy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JavaScriptCore/JavaScriptCore.h>

//声明协议，遵守 JSExport
@protocol JSObjectProtocol <JSExport>

- (void) print:(NSString *)jsonString;

@end


//遵守自定义的协议 JSObjectProtocol
@interface IOS : NSObject <JSObjectProtocol>


//注：
//test.html文件中IOS.print   是方法的实现，所以本类的类名必须为IOS,方法名必须为print，这样才能对应上，否则方法不生效

@end




