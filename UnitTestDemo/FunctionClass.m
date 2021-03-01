//
//  FunctionClass.m
//  UnitTestDemo
//
//  Created by 马一轩 on 2020/11/13.
//

#import "FunctionClass.h"

@implementation FunctionClass

+ (NSString *)descForCount:(NSInteger)count {
    NSString *desc = nil;
    if (count > 99999) {
        desc = [[NSString alloc] initWithFormat:@"%@万", @(count / 10000)];
    } else if (count > 9999) {
        float a = count / 10000.f;
        float b =floor(a * 10) / 10.f;
        desc = [[NSString alloc] initWithFormat:@"%.1f万", b];
    } else {
        desc = [[NSString alloc] initWithFormat:@"%@", @(count)];
    }
    return desc;
}
+ (NSString *)descForCount2:(NSInteger)count {
    NSString *desc = nil;
    if (count > 99999) {
        desc = [[NSString alloc] initWithFormat:@"%@万", @(count / 10000)];
    } else if (count > [self getNumber]) {
        desc = [[NSString alloc] initWithFormat:@"%.1f万", count / 10000.f];
    } else {
        desc = [[NSString alloc] initWithFormat:@"%@", @(count)];
    }
    return desc;
}

+ (int)getNumber{
    return 50000;
}

+ (void)timeFunction:(myBlock) completion{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        completion(4);
    });
}

+ (void)toInvokeOtherFunctions:(int) num {
    if (num > 5) {
        [self invokedMethod1:@"hello"];
    } else {
        [self invokedMethod2];
    }
}

+ (void)invokeMethodByOrder {
    [self invokedMethod1:@""];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self invokedMethod2];
    });
    [self invokedMethod3:true];
}

+ (void)invokedMethod1:(NSString *) str{
    NSLog(@"invokeMethod1,%@", str);
}

+ (void)invokedMethod2 {
    NSLog(@"invokedMethod2");
}

+ (void)invokedMethod3:(BOOL) flag {
    NSLog(@"invokedMethod3");
}

@end
