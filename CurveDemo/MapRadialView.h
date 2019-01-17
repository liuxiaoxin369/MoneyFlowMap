//
//  MapRadialView.h
//  CurveDemo
//
//  Created by qzwh on 2018/12/6.
//  Copyright © 2018年 qianjinjia. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MapRadialView : UIView

- (instancetype)initWithFrame:(CGRect)frame endPoint:(CGPoint)point startPoints:(NSArray *)startPoints;

@end

NS_ASSUME_NONNULL_END
