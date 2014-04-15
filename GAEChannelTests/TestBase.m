//
// Created by Chiwan Park on 4/13/14.
// Copyright (c) 2014 Chiwan Park. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "TestBase.h"
#import "GAEChannel.h"


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

- (void)APIInitialized:(GAEChannel *)ignored {
  NSLog(@"Google Channel API initialized");
}

- (void)onOpen {
  NSLog(@"Channel opened");
}

- (void)onMessage:(NSString *)message {
  NSLog(@"Message arrived: %@", message);
}

- (void)onError:(NSInteger)code description:(NSString *)description {
  NSLog(@"Error occurred: %ld, %@", code, description);
}

- (void)onClose {
  NSLog(@"Channel closed");
}

@end