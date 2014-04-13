//
//  GAEChannelTests.m
//  GAEChannelTests
//
//  Created by Chiwan Park on 4/11/14.
//  Copyright (c) 2014 Chiwan Park. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "XCTestCase+AsyncTesting.h"
#import "OpenTest.h"
#import "CloseTest.h"
#import "ReceiveMessageTest.h"

@interface GAEChannelTests : XCTestCase {
  NSString *serverURL;
}
@end

@implementation GAEChannelTests

- (void)setUp {
  [super setUp];
  serverURL = @"http://gaechannel-ios.appspot.com";
}

- (void)tearDown {
  [self waitForStatus:XCTAsyncTestCaseStatusSucceeded timeout:60];
  [super tearDown];
}

- (void)testChannelOpen {
  OpenTest *test = [[OpenTest alloc] initWithTestCase:self AndServerURL:serverURL];

  [test start];
}

- (void)testChannelClose {
  CloseTest *test = [[CloseTest alloc] initWithTestCase:self AndServerURL:serverURL];

  [test start];
}

- (void)testReceiveMessage {
  ReceiveMessageTest *test = [[ReceiveMessageTest alloc] initWithTestCase:self AndServerURL:serverURL];

  [test start];
}

@end
