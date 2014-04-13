//
// Created by Chiwan Park on 4/14/14.
// Copyright (c) 2014 Chiwan Park. All rights reserved.
//

#import "ReceiveMessageTest.h"
#import "GAEChannel.h"
#import "XCTestCase+AsyncTesting.h"


@implementation ReceiveMessageTest {

}

- (void)start {
  [super start];

  manager = [AFHTTPRequestOperationManager manager];
  NSString *url = [NSString stringWithFormat:@"%@/open-channel", serverURL];

  [manager POST:url parameters:@{@"client_id" : clientId}
        success:^(AFHTTPRequestOperation *operation, id responseObject) {
          token = [((NSDictionary *) responseObject) objectForKey:@"token"];
          channel = [GAEChannel channelWithServerURL:serverURL Delegate:self];
        }
        failure:^(AFHTTPRequestOperation *operation, NSError *error) {
          NSLog(@"%s: Failed on acquiring token", __PRETTY_FUNCTION__);
          [testCase notify:XCTAsyncTestCaseStatusFailed];
        }
  ];
}

- (void)channelInitialized:(GAEChannel *)ignored {
  [super channelInitialized:ignored];
  [channel connectWithToken:token];
}

- (void)onOpen {
  [super onOpen];

  NSString *url = [NSString stringWithFormat:@"%@/test-stage", serverURL];

  [manager POST:url parameters:@{@"client_id" : clientId, @"stage": @"1"}
        success:^(AFHTTPRequestOperation *operation, id responseObject) {
          // Do not any action
          NSLog(@"%s: send request message successfully", __PRETTY_FUNCTION__);
        }
        failure:^(AFHTTPRequestOperation *operation, NSError *error) {
          NSLog(@"%s: cannot send request message to server!", __PRETTY_FUNCTION__);
          [testCase notify:XCTAsyncTestCaseStatusFailed];
        }
  ];
}

- (void)onMessage:(NSString *)message {
  [super onMessage:message];

  NSString *expected = @"success_stage1";

  if ([message isEqualToString:expected]) {
    [testCase notify:XCTAsyncTestCaseStatusSucceeded];
  } else {
    NSLog(@"%s: message arrived, but arrived message isn't equal to expected message. (expected: %@, actual: %@)",
        __PRETTY_FUNCTION__, expected, message);
    [testCase notify:XCTAsyncTestCaseStatusFailed];
  }
}

@end