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
    [webView setDelegate:self];
    [self loadViewPage];
  }

  return self;
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

- (void)connect:(NSString *)serverURL WithKey:(NSString *)channelKey {
  NSLog(@"connect: %@ WithKey: %@", serverURL, channelKey);
}

- (void)webViewDidFinishLoad:(UIWebView *)ignored {
  [webView stringByEvaluatingJavaScriptFromString:@"init('http://localhost:8080');"];
}


@end
