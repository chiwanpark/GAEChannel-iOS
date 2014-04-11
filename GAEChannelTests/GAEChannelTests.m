//
//  GAEChannelTests.m
//  GAEChannelTests
//
//  Created by Chiwan Park on 4/11/14.
//  Copyright (c) 2014 Chiwan Park. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "GAEChannel.h"
#import "AFNetworking.h"
#import "XCTestCase+AsyncTesting.h"

@interface GAEChannelTests : XCTestCase <GAEChannelDelegate> {
  NSString *baseURL;
  GAEChannel *channel;
  AFHTTPRequestOperationManager *manager;
  NSDictionary *params;
}
@end

@implementation GAEChannelTests

- (void)setUp {
  [super setUp];

  baseURL = @"http://localhost:8080";
  manager = [AFHTTPRequestOperationManager manager];
  params = @{@"client_id": [[NSUUID UUID] UUIDString]};
}

- (void)tearDown {
  [self waitForStatus:XCTAsyncTestCaseStatusSucceeded timeout:20];
  [super tearDown];
}

- (void)testBasic {
  NSString *url = [NSString stringWithFormat:@"%@/open-channel", baseURL];

  [manager POST:url
     parameters:params
        success:^(AFHTTPRequestOperation *operation, id responseObject) {
          NSString *token = [((NSDictionary *) responseObject) objectForKey:@"token"];
          channel = [GAEChannel channelWithServerURL:baseURL Delegate:self];
          [channel connectWithToken:token];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    NSLog(@"%s: failed on token acquiring", __PRETTY_FUNCTION__);
    [self notify:XCTAsyncTestCaseStatusFailed];
  }];
}

- (void)channelInitialized:(GAEChannel *)ignored {
  NSLog(@"Google Channel API is initialized");
}

- (void)onOpen {
  NSLog(@"GAEChannel Opened");
}

- (void)onMessage:(NSString *)message {
  NSLog(@"Message Arrived: %@", message);
}

- (void)onError:(NSInteger)code WithDescription:(NSString *)description {
  NSLog(@"Error occured: %ld, %@", (long) code, description);
}

- (void)onClose {
  NSLog(@"GAEChannel Closed!");
}


@end
