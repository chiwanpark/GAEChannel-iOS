//
// Created by Chiwan Park on 4/14/14.
// Copyright (c) 2014 Chiwan Park. All rights reserved.
//

#import "CloseTestBase.h"
#import "GAEChannel.h"
#import "XCTestCase+AsyncTesting.h"
#import "AFNetworking.h"


@implementation CloseTestBase {

}

- (void)start {
  AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
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

- (void)onClose {
  [super onClose];
  [testCase notify:XCTAsyncTestCaseStatusSucceeded];
}

- (void)onOpen {
  [super onOpen];
  [channel close];
}


@end