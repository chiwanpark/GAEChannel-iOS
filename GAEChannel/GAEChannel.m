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

- (instancetype)initWithServerURL:(NSString *)url {
  self = [super init];

  if (self) {
    // initialize instance variables
    initialized = FALSE;
    serverURL = url;
    [self setDelegate:nil];

    // initialize hidden webview object
    webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    [webView setDelegate:self];

    // load view page
    [self loadViewPage];
  }

  return self;
}

+ (instancetype)channelWithServerURL:(NSString *)url {
  return [[self alloc] initWithServerURL:url];
}

+ (NSBundle *)frameworkBundle {
  static NSBundle *frameworkBundle = nil;
  static dispatch_once_t predicate;

  dispatch_once(&predicate, ^{
    NSString *mainBundlePath = [[NSBundle mainBundle] resourcePath];
    NSString *frameworkBundlePath = [mainBundlePath stringByAppendingPathComponent:@"GAEChannel.bundle"];

    NSLog(@"frameworkBundlePath: %@", frameworkBundlePath);

    frameworkBundle = [NSBundle bundleWithPath:frameworkBundlePath];
  });

  return frameworkBundle;
}

- (void)loadViewPage {
  NSURL *url = [[GAEChannel frameworkBundle] URLForResource:@"view" withExtension:@"html"];
  NSLog(@"loadViewPage: %@", [url absoluteURL]);
  NSURLRequest *request = [NSURLRequest requestWithURL:url];

  [webView loadRequest:request];
}

- (void)connectWithToken:(NSString *)token {
  if (!initialized) {
    return;
  }

  NSLog(@"connect: %@ WithKey: %@", serverURL, token);
}

- (void)webViewDidFinishLoad:(UIWebView *)ignored {
  NSString *function = [NSString stringWithFormat:@"loadJSAPI('%@');", serverURL];
  [webView stringByEvaluatingJavaScriptFromString:function];
  initialized = TRUE;
}

@end
