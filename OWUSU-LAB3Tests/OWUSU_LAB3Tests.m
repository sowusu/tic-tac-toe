//
//  OWUSU_LAB3Tests.m
//  OWUSU-LAB3Tests
//
//  Created by Nana Kwame Owusu on 2/20/15.
//  Copyright (c) 2015 Nana Kwame Owusu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

@interface OWUSU_LAB3Tests : XCTestCase

@end

@implementation OWUSU_LAB3Tests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    XCTAssert(YES, @"Pass");
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end