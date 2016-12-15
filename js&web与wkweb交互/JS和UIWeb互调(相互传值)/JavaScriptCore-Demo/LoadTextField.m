//
//  LoadTextField.m
//  JavaScriptCore-Demo
//
//  Created by Holy on 16/12/7.
//  Copyright © 2016年 www.skyfox.org. All rights reserved.
//

#import "LoadTextField.h"

@implementation LoadTextField

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField setKeyboardType:UIKeyboardTypeWebSearch];
    [textField reloadInputViews];
    return YES;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
