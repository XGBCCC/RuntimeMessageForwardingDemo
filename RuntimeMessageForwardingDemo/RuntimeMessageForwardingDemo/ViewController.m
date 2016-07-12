//
//  ViewController.m
//  RuntimeMessageForwardingDemo
//
//  Created by JimBo on 16/7/11.
//  Copyright © 2016年 JimBo. All rights reserved.
//

#import "ViewController.h"
#import "User.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    User *user = [User new];
    user.userName = @"jack";
    user.userAge = 18;
    //此处调用一个没有的User没有的printUserName的方法  走user的resolveInstanceMethod方法
    [user performSelector:@selector(printUserName:) withObject:nil afterDelay:0];
    //走user的forwardingTargetForSelector方法
    [user performSelector:@selector(printUserAge:) withObject:nil afterDelay:0];
    //走user的methodSignatureForSelector+forwardInvocation方法
    [user performSelector:@selector(printUserSex:) withObject:nil afterDelay:0];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
