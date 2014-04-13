//
// Created by Chiwan Park on 4/13/14.
// Copyright (c) 2014 Chiwan Park. All rights reserved.
//

#import <Foundation/Foundation.h>

@class XCTestCase;
@class GAEChannel;


@interface TestBase : NSObject {
  XCTestCase *testCase;
  NSString *serverURL;
  NSString *clientId;
  NSString *token;
  GAEChannel *channel;
}

- (id)initWithTestCase:(XCTestCase *)testCase AndServerURL: (NSString *)aURL;

- (void)start;
@end