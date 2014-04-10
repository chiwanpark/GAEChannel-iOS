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

#pragma mark Initializer method

- (instancetype)initWithServerURL:(NSString *)url {
  self = [super init];

  if (self) {
    // initialize instance variables
    initialized = FALSE;
    serverURL = url;
    scheme = @"ios-gaechannel://";
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

#pragma mark Google Channel API

- (void)connectWithToken:(NSString *)token {
  if (!initialized) {
    return;
  }

  NSLog(@"connect: %@ WithKey: %@", serverURL, token);
}

#pragma mark Helper method for GAEChannel Implementation

+ (NSBundle *)frameworkBundle {
  static NSBundle *frameworkBundle = nil;
  static dispatch_once_t predicate;

  dispatch_once(&predicate, ^{
    NSString *mainBundlePath = [[NSBundle mainBundle] resourcePath];
    NSString *frameworkBundlePath = [mainBundlePath stringByAppendingPathComponent:@"GAEChannel.bundle"];

    frameworkBundle = [NSBundle bundleWithPath:frameworkBundlePath];
  });

  return frameworkBundle;
}

- (void)loadViewPage {
  NSURL *url = [[GAEChannel frameworkBundle] URLForResource:@"view" withExtension:@"html"];
  NSURLRequest *request = [NSURLRequest requestWithURL:url];

  [webView loadRequest:request];
}

- (NSDictionary *)parseQuery:(NSString *)query {
  NSMutableDictionary *params = [[NSMutableDictionary alloc] init];

  for (NSString *param in [query componentsSeparatedByString:@"&"]) {
    NSArray *keyValue = [param componentsSeparatedByString:@"="];

    if ([keyValue count] == 2) {
      NSString *value = [keyValue[1] stringByReplacingOccurrencesOfString:@"+" withString:@" "];
      value = [value stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

      [params setValue:value forKey:keyValue[0]];
    }
  }

  return params;
}

#pragma mark UIWebViewDelegate method

- (void)webViewDidFinishLoad:(UIWebView *)ignored {
  NSString *cmds = [NSString stringWithFormat:@"setScheme('%@');loadJSAPI('%@');", scheme, serverURL];
  [webView stringByEvaluatingJavaScriptFromString:cmds];
  initialized = TRUE;
}

- (BOOL)webView:(UIWebView *)ignored shouldStartLoadWithRequest:(NSURLRequest *)request
 navigationType:(UIWebViewNavigationType)navigationType {
  NSURL *url = [request URL];

  if ([scheme hasPrefix:[url scheme]]) {
    NSString *selector = [url host];
    NSDictionary *params = [self parseQuery:[url query]];

    if ([selector isEqualToString:@"onOpen"]) {
      [[self delegate] onOpen];
    } else if ([selector isEqualToString:@"onClose"]) {
      [[self delegate] onClose];
    } else if ([selector isEqualToString:@"onMessage"]) {
      [[self delegate] onMessage:[params objectForKey:@"message"]];
    } else if ([selector isEqualToString:@"onError"]) {
      [[self delegate] onError:[[params objectForKey:@"code"] intValue]
               WithDescription:[params objectForKey:@"description"]];
    }

    return NO;
  }

  return YES;
}

@end
