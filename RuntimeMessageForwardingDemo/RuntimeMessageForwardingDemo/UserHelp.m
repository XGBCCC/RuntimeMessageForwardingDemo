//
//  UserHelp.m
//  RuntimeMessageForwardingDemo
//
//  Created by JimBo on 16/7/11.
//  Copyright © 2016年 JimBo. All rights reserved.
//

#import "UserHelp.h"

@implementation UserHelp

//1.注意，此方法是通过User的方法forwardingTargetForSelector来的，所有参数，肯定是User，否则不会被识别
//2.但是这块，只是方法的forwardind，但是之前方法所包含的参数并没有传递过来，所以，user=nil
- (void)printUserAge:(User *)user{
    NSLog(@"%@",@(user.userAge));
}

@end
