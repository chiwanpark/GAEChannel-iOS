//
// Created by Chiwan Park on 4/11/14.
// Copyright (c) 2014 Chiwan Park. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol GAEChannelDelegate <NSObject>

- (void)onOpen;

- (void)onMessage:(NSString *)message;

- (void)onError:(NSInteger)code WithDescription:(NSString *)description;

- (void)onClose;

@end