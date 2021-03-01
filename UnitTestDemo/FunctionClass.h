//
//  FunctionClass.h
//  UnitTestDemo
//
//  Created by 马一轩 on 2020/11/13.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FunctionClass : NSObject

typedef void(^myBlock)(int);

+ (NSString *)descForCount:(NSInteger)count;

+ (NSString *)descForCount2:(NSInteger)count;

+ (void)timeFunction:(myBlock) completion;

+ (void)toInvokeOtherFunctions:(int) num;

+ (void)invokeMethodByOrder;

@end

NS_ASSUME_NONNULL_END
