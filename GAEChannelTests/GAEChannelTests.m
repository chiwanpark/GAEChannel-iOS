//
//  GAEChannelTests.m
//  GAEChannelTests
//
//  Created by Chiwan Park on 4/11/14.
//  Copyright (c) 2014 Chiwan Park. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "XCTestCase+AsyncTesting.h"
#import "OpenTestBase.h"

@interface GAEChannelTests : XCTestCase {
  NSString *serverURL;
}
@end

@implementation GAEChannelTests

- (void)setUp {
  [super setUp];
  serverURL = @"http://localhost:8080";
}

- (void)tearDown {
  [self waitForStatus:XCTAsyncTestCaseStatusSucceeded timeout:20];
  [super tearDown];
}

- (void)testChannelOpen {
  OpenTestBase *testBase = [[OpenTestBase alloc] initWithTestCase:self AndServerURL:serverURL];

  [testBase start];
}

@end
