//
//  UnitTestDemoTests.m
//  UnitTestDemoTests
//
//  Created by 马一轩 on 2020/11/13.
//

#import <XCTest/XCTest.h>
#import "../UnitTestDemo/FunctionClass.h"
#import <OCMock/OCMock.h>

@interface FunctionClass ()

+ (int)getNumber;
+ (void)invokedMethod1:(NSString *) str;
+ (void)invokedMethod2;
+ (void)invokedMethod3:(BOOL) flag;
@end

@interface UnitTestDemoTests : XCTestCase
@property(nonatomic, strong) id mock;
@end

@implementation UnitTestDemoTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
    _mock = OCMClassMock([FunctionClass class]);
    OCMStub([_mock getNumber]).andReturn(9999);
    NSLog(@"set up 执行");
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    NSLog(@"tear down 执行");
    [_mock stopMocking];
}

//普通测试
- (void)testExample {
    NSString* result = [FunctionClass descForCount2:99000];
    XCTAssertEqualObjects(result, @"9.9万");
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

//异步执行测试
- (void)testPerformanceExample {
    XCTestExpectation *expect = [self expectationWithDescription:@"a"];
    [FunctionClass timeFunction:^(int num){
        XCTAssertEqual(num, 4);
        [expect fulfill];
    }];
    [self waitForExpectations:@[expect] timeout:2];
}

//按预期调用测试
- (void)testInvokeMethod {
    id mock = OCMClassMock([FunctionClass class]);
    //如果传参数此处写：[OCMAry any](不校验参数的情况)，这个只能忽略object参数，不能忽略布尔和基本类型
    //参数校验
    OCMExpect([mock invokedMethod1:[OCMArg checkWithBlock:^BOOL(id obj) {
        return [(NSString *)obj isEqualToString: @"hello"];
    }]]);
    OCMReject([mock invokedMethod2]);
    [FunctionClass toInvokeOtherFunctions:100];
    OCMVerifyAll(mock);
    [mock stopMocking];
}

//执行顺序测试
- (void)testinvokeMethodOrder {
    [_mock setExpectationOrderMatters:YES];
    OCMExpect([_mock invokedMethod1:[OCMArg any]]);
    OCMExpect([_mock invokedMethod3:YES]).ignoringNonObjectArgs;
//    OCMExpect([_mock invokedMethod3:[OCMArg any]]);明明也可以
    OCMExpect([_mock invokedMethod2]);
    
    [FunctionClass invokeMethodByOrder];

    OCMVerifyAllWithDelay(_mock, 2);  //只管方法调用顺序对不对，实际上不会真的执行方法，断点不会走，所以这里延时验证的是延时调用方法，而不是调用的方法里的延时执行
    [_mock stopMocking];
}

@end
