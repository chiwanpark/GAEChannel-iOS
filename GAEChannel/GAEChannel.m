//
//  GAEChannel.m
//  GAEChannel
//
//  Created by Chiwan Park on 4/11/14.
//  Copyright (c) 2014 Chiwan Park. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GAEChannel.h"

@implementation GAEChannel

- (id)init {
  self = [super init];

  if (self) {
    webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    [self loadPageWithURL:@"http://localhost:8080"];
  }

  return self;
}

- (void)loadPageWithURL:(NSString *)url {
  NSURL *urlObject = [NSURL URLWithString:url];
  NSURLRequest *request = [NSURLRequest requestWithURL:urlObject];

  [webView loadRequest:request];
}

- (void)connect:(NSString *)serverURL WithKey:(NSString *)channelKey {
  NSLog(@"connect: %@ WithKey: %@", serverURL, channelKey);
}

@end
