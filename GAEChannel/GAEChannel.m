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

- (instancetype)initWithServerURL:(NSString *)url Delegate:(id <NSObject, GAEChannelDelegate>)delegate {
  self = [super init];

  if (self) {
    // initialize instance variables
    serverURL = url;
    scheme = @"ios-gaechannel://";
    channelDelegate = delegate;

    // initialize hidden webview object
    webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    [webView setDelegate:self];

    // load view page
    [self loadViewPage];
  }

  return self;
}

+ (instancetype)channelWithServerURL:(NSString *)url Delegate:(id <NSObject, GAEChannelDelegate>)delegate {
  return [[self alloc] initWithServerURL:url Delegate:delegate];
}

#pragma mark Google Channel API

- (void)connectWithToken:(NSString *)token {
  NSLog(@"connect: %@ WithKey: %@", serverURL, token);
  NSString *script = [NSString stringWithFormat:@"openChannel('%@');", token];
  [webView stringByEvaluatingJavaScriptFromString:script];
}

- (void)close {
  [webView stringByEvaluatingJavaScriptFromString:@"closeChannel();"];
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
  NSError *error = nil;
  NSString *html = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:&error];
  NSString *scriptURL = [NSString stringWithFormat:@"%@/_ah/channel/jsapi", serverURL];

  if (!error) {
    html = [html stringByReplacingOccurrencesOfString:@"{{ CHANNEL_API_SCRIPT_URL }}" withString:scriptURL];
    html = [html stringByReplacingOccurrencesOfString:@"{{ SCHEME }}" withString:scheme];
    [webView loadHTMLString:html baseURL:[NSURL URLWithString:serverURL]];
  }
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

- (BOOL)webView:(UIWebView *)ignored shouldStartLoadWithRequest:(NSURLRequest *)request
 navigationType:(UIWebViewNavigationType)navigationType {
  NSURL *url = [request URL];

  if (url && [scheme hasPrefix:[url scheme]]) {
    NSString *selector = [url host];
    NSDictionary *params = [self parseQuery:[url query]];

    if ([selector isEqualToString:@"onOpen"]) {
      [channelDelegate onOpen];
    } else if ([selector isEqualToString:@"onClose"]) {
      [channelDelegate onClose];
    } else if ([selector isEqualToString:@"onMessage"]) {
      [channelDelegate onMessage:[params objectForKey:@"message"]];
    } else if ([selector isEqualToString:@"onError"]) {
      [channelDelegate onError:[[params objectForKey:@"code"] intValue]
               WithDescription:[params objectForKey:@"description"]];
    } else if ([selector isEqualToString:@"channelInitialized"]) {
      [channelDelegate channelInitialized:self];
    }

    return NO;
  }

  return YES;
}

@end
