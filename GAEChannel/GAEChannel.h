//
//  GAEChannel.h
//  GAEChannel
//
//  Created by Chiwan Park on 4/11/14.
//  Copyright (c) 2014 Chiwan Park. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIWebView.h>
#import "GAEChannelDelegate.h"

@interface GAEChannel : NSObject <UIWebViewDelegate> {
  NSString *scheme;
  NSString *serverURL;
  UIWebView *webView;
  id <NSObject, GAEChannelDelegate> channelDelegate;
}

- (instancetype)initWithServerURL:(NSString *)url Delegate:(id <NSObject, GAEChannelDelegate>)delegate;

+ (instancetype)channelWithServerURL:(NSString *)url Delegate:(id <NSObject, GAEChannelDelegate>)delegate;

- (void)connectWithToken:(NSString *)token;

- (void)close;
@end
