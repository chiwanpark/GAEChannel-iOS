//
// Created by Chiwan Park on 4/13/14.
// Copyright (c) 2014 Chiwan Park. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "TestBase.h"


@implementation TestBase {

}
- (id)initWithTestCase:(XCTestCase *)aTestCase AndServerURL:(NSString *)aURL {
  self = [super init];
  if (self) {
    testCase = aTestCase;
    serverURL = aURL;
    clientId = [[NSUUID UUID] UUIDString];
  }

  return self;
}

- (void)start {

}

@end