//
//  UserHelp.h
//  RuntimeMessageForwardingDemo
//
//  Created by JimBo on 16/7/11.
//  Copyright © 2016年 JimBo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"
@interface UserHelp:NSObject

@property (nonatomic,assign) NSInteger age;

- (void)printUserAge:(User *)user;

@end
