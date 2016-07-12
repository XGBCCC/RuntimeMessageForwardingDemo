//
//  User.m
//  RuntimeMessageForwardingDemo
//
//  Created by JimBo on 16/7/11.
//  Copyright © 2016年 JimBo. All rights reserved.
//

#import "User.h"
#import "UserHelp.h"
#import <objc/runtime.h>

@implementation User

void printUserName(id self,SEL _cmd){
    User *user = self;
    NSLog(@"%@",user.userName);
}

//1.在此处动态添加方法，并返回YES。表明已经动态添加sel方法了，你可以正常调用了
+ (BOOL)resolveInstanceMethod:(SEL)sel{
    NSString *selString = [NSString stringWithUTF8String:sel_getName(sel)];
    if ([selString rangeOfString:@"printUserName"].location != NSNotFound) {
        class_addMethod(self, sel, (IMP)printUserName, "v@:");
    }
    
    return NO;
}

//2.如果方法resolveInstanceMethod没有实现，则来到forwardingTargetForSelector，由转发给其他对象实现
- (id)forwardingTargetForSelector:(SEL)aSelector{
    NSString *selString = [NSString stringWithUTF8String:sel_getName(aSelector)];
    if ([selString rangeOfString:@"printUserAge"].location != NSNotFound) {
        UserHelp *userHelp = [UserHelp new];
        return userHelp;
    }
    return nil;
}

//3.这个方法，会返回一个方法签名，如果这个签名为nil，则直接崩溃(unrecognized selector sent to instance)
//如果发现签名为nil,这里，我们可以自己注册方法签名，并返回【如果，这里有返回方法签名，则系统会调用forwardInvocation方法】
- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector{
    //发现自己实现这个方法
    NSMethodSignature *sig = [super methodSignatureForSelector:aSelector];
    if (!sig) {
        //OK，你没有实现这个方法，拿不到方法签名，那我手动给你个方法签名，并返回
        sig = [NSMethodSignature signatureWithObjCTypes:"v@:"];
    }
    return sig;
}

//4.这块是消息转发的最终目的地，如果methodSignatureForSelector有返回，则会走这个方法，在这个方法里，我们可以判断是否可以执行，并交由可以执行的对象去执行。如果没有对象可执行，这一步也不会报错【只要不invokeWithTarget】
- (void)forwardInvocation:(NSInvocation *)anInvocation{
    //获取到调用信息的selector
    SEL aSelector = [anInvocation selector];
    //如果可以调用，则进行调用
    if ([self respondsToSelector:aSelector]) {
        [anInvocation invokeWithTarget:self];
    }
    //如果不能调用，则把消息吞掉，不做任何处理
    
}

@end
