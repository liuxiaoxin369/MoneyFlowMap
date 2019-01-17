//
//  UIView+ZSFrame.h
//  ZhishanFund
//
//  Created by qzwh on 2018/1/24.
//  Copyright © 2018年 qzwh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (ZSFrame)

///上(y)
@property (assign, nonatomic) CGFloat zs_top;
///下(y+height)
@property (assign, nonatomic) CGFloat zs_bottom;
///左(x)
@property (assign, nonatomic) CGFloat zs_left;
///右(x+width)
@property (assign, nonatomic) CGFloat zs_right;
///y(x)
@property (assign, nonatomic) CGFloat zs_x;
///y(y)
@property (assign, nonatomic) CGFloat zs_y;
///起点坐标
@property (assign, nonatomic) CGPoint zs_origin;
///中心点x(center.x)
@property (assign, nonatomic) CGFloat zs_centerX;
///中心点y(center.y)
@property (assign, nonatomic) CGFloat zs_centerY;
///宽度(width)
@property (assign, nonatomic) CGFloat zs_width;
///高度(height)
@property (assign, nonatomic) CGFloat zs_height;
///大小(size)
@property (assign, nonatomic) CGSize  zs_size;

@end
