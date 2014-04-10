//
//  GAEChannel.h
//  GAEChannel
//
//  Created by Chiwan Park on 4/11/14.
//  Copyright (c) 2014 Chiwan Park. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIWebView.h>

@interface GAEChannel : NSObject <UIWebViewDelegate> {
  NSString *serverURL;
  UIWebView *webView;
  BOOL initialized;
}

- (instancetype)initWithServerURL:(NSString *)url;

+ (instancetype)channelWithServerURL:(NSString *)url;

- (void)connectWithToken:(NSString *)token;
@end
