//
//  UIView+ZSFrame.m
//  ZhishanFund
//
//  Created by qzwh on 2018/1/24.
//  Copyright © 2018年 qzwh. All rights reserved.
//

#import "UIView+ZSFrame.h"

@implementation UIView (ZSFrame)

- (CGFloat)zs_top {
    return self.frame.origin.y;
}

- (void)setZs_top:(CGFloat)zs_top {
    CGRect frame = self.frame;
    frame.origin.y = zs_top;
    self.frame = frame;
}

- (CGFloat)zs_left {
    return self.frame.origin.x;
}

- (void)setZs_left:(CGFloat)zs_left {
    CGRect frame = self.frame;
    frame.origin.x = zs_left;
    self.frame = frame;
}

- (CGFloat)zs_bottom {
    return self.frame.size.height + self.frame.origin.y;
}

- (void)setZs_bottom:(CGFloat)zs_bottom {
    CGRect frame = self.frame;
    frame.origin.y = zs_bottom - frame.size.height;
    self.frame = frame;
}

- (CGFloat)zs_right {
    return self.frame.size.width + self.frame.origin.x;
}

- (void)setZs_right:(CGFloat)zs_right {
    CGRect frame = self.frame;
    frame.origin.x = zs_right - frame.size.width;
    self.frame = frame;
}

- (CGFloat)zs_x {
    return self.frame.origin.x;
}

- (void)setZs_x:(CGFloat)zs_x {
    CGRect frame = self.frame;
    frame.origin.x = zs_x;
    self.frame = frame;
}

- (CGFloat)zs_y {
    return self.frame.origin.y;
}

- (void)setZs_y:(CGFloat)zs_y {
    CGRect frame = self.frame;
    frame.origin.y = zs_y;
    self.frame = frame;
}

- (CGPoint)zs_origin {
    return self.frame.origin;
}

- (void)setZs_origin:(CGPoint)zs_origin {
    CGRect frame = self.frame;
    frame.origin = zs_origin;
    self.frame = frame;
}

- (CGFloat)zs_centerX {
    return self.center.x;
}

- (void)setZs_centerX:(CGFloat)zs_centerX {
    CGPoint center = self.center;
    center.x = zs_centerX;
    self.center = center;
}

- (CGFloat)zs_centerY {
    return self.center.y;
}

- (void)setZs_centerY:(CGFloat)zs_centerY {
    CGPoint center = self.center;
    center.y = zs_centerY;
    self.center = center;
}

- (CGFloat)zs_width {
    return self.frame.size.width;
}

- (void)setZs_width:(CGFloat)zs_width {
    CGRect frame = self.frame;
    frame.size.width = zs_width;
    self.frame = frame;
}

- (CGFloat)zs_height {
    return self.frame.size.height;
}

- (void)setZs_height:(CGFloat)zs_height {
    CGRect frame = self.frame;
    frame.size.height = zs_height;
    self.frame = frame;
}

- (CGSize)zs_size {
    return self.frame.size;
}

- (void)setZs_size:(CGSize)zs_size {
    CGRect frame = self.frame;
    frame.size = zs_size;
    self.frame = frame;
}

@end
