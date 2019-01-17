//
//  CurveView.m
//  CurveDemo
//
//  Created by qzwh on 2018/11/11.
//  Copyright © 2018年 qianjinjia. All rights reserved.
//

#import "CurveView.h"
#import "UIView+ZSFrame.h"

@interface CurveView ()

@property (nonatomic, strong) NSArray *dataArr;
@property (nonatomic, strong) NSMutableArray *pointArr;

@end

@implementation CurveView

- (NSMutableArray *)pointArr {
    if (!_pointArr) {
        _pointArr = [NSMutableArray array];
    }
    return _pointArr;
}

- (instancetype)initWithFrame:(CGRect)frame dataArr:(NSArray *)dataArr {
    self = [super initWithFrame:frame];
    if (self) {
        self.dataArr = dataArr;
        [self createUI];
    }
    return self;
}

- (void)createUI {
    //找到最高值、最低值
    CGFloat max = 0;
    CGFloat min = CGFLOAT_MAX;
    for (int i = 0; i < self.dataArr.count; i++) {
        CGFloat value = [self.dataArr[i] floatValue];
        //获取最大值
        if (value > max) {
            max = value;
        }
        
        if (value < min) {
            min = value;
        }
    }
    
    max += 3;
    min -= 3;
    
    //求出每条数据分割宽度
    //每个增加一个数值需要的平均高度
    CGFloat superValueHight = (self.zs_height/2)/(max-[self.dataArr.firstObject floatValue]);
    
    CGFloat lowValueHight = (self.zs_height/2)/([self.dataArr.firstObject floatValue] - min);
    
    //每个数值对应的宽度
    CGFloat valueWidth = (self.zs_width-1)/(self.dataArr.count-1);
    
    CGFloat x = 0;
    CGFloat firstValue = [self.dataArr.firstObject floatValue];
    for (int i = 0; i < self.dataArr.count; i++) {
        CGFloat y = self.zs_height/2;
        CGFloat value = [self.dataArr[i] floatValue];
        if (i != 0 && value >= firstValue) {
            y = y - ((value - firstValue)*superValueHight);
        }
        
        if (i != 0 && value <= firstValue) {
            y = y + ((firstValue - value)*lowValueHight);
        }
        
        UILabel *view = [[UILabel alloc] initWithFrame:CGRectMake(x, y, 1, 1)];
//        view.backgroundColor = [UIColor redColor];
//        view.layer.cornerRadius = 5;
//        view.layer.masksToBounds = YES;
        view.text = [NSString stringWithFormat:@"%@", self.dataArr[i]];
        [self addSubview:view];
        
        //获得当前坐标点
        if (i == 0) {
            [self.pointArr addObject:NSStringFromCGPoint(CGPointZero)];
        }
        
        [self.pointArr addObject:NSStringFromCGPoint(CGPointMake(x, y))];
        
        if (i == self.dataArr.count - 1) {
            [self.pointArr addObject:NSStringFromCGPoint(CGPointZero)];
        }
        
        x += valueWidth;
    }
    
    //绘制曲线
    //曲线视图
    UIBezierPath *path = [UIBezierPath bezierPath];
    //曲线线条
    UIBezierPath *curvePath = [UIBezierPath bezierPath];
    for (NSInteger i = 0; i < self.pointArr.count-3; i++) {
        CGPoint p1 = CGPointFromString([self.pointArr objectAtIndex:i]);
        CGPoint p2 = CGPointFromString([self.pointArr objectAtIndex:i+1]);
        CGPoint p3 = CGPointFromString([self.pointArr objectAtIndex:i+2]);
        CGPoint p4 = CGPointFromString([self.pointArr objectAtIndex:i+3]);
        if (i == 0) {
            [path moveToPoint:p2];
            [curvePath moveToPoint:p2];
        }
        [self getControlPointx0:p1.x andy0:p1.y x1:p2.x andy1:p2.y x2:p3.x andy2:p3.y x3:p4.x andy3:p4.y path:path];
        [self getControlPointx0:p1.x andy0:p1.y x1:p2.x andy1:p2.y x2:p3.x andy2:p3.y x3:p4.x andy3:p4.y path:curvePath];
    }
    [path addLineToPoint:CGPointMake(self.zs_width, self.zs_height)];
    [path addLineToPoint:CGPointMake(0, self.zs_height)];
    [path addLineToPoint:CGPointMake(0, self.zs_height/2)];
    [path closePath];
    
    CAShapeLayer *layerA = [[CAShapeLayer alloc] init];
    // 设置线条宽度
    layerA.lineWidth = 1.f;
    // 线条填充色
    layerA.strokeColor = [UIColor whiteColor].CGColor;
    // 背景填充色
    layerA.fillColor = [UIColor clearColor].CGColor;
    // 设置路径
    layerA.path = path.CGPath;
    [self.layer addSublayer:layerA];
    
    //设置曲线线条颜色
    CAShapeLayer *layerB = [[CAShapeLayer alloc] init];
    // 设置线条宽度
    layerB.lineWidth = 1.f;
    // 线条填充色
    layerB.strokeColor = [UIColor blueColor].CGColor;
    // 背景填充色
    layerB.fillColor = [UIColor clearColor].CGColor;
    // 设置路径
    layerB.path = curvePath.CGPath;
    [self.layer addSublayer:layerB];
    
    //设置渐变色
    //创建CGContextRef
    UIGraphicsBeginImageContext(self.bounds.size);
    CGContextRef gc = UIGraphicsGetCurrentContext();
    [self drawLinearGradient:gc path:path.CGPath startColor:[UIColor redColor].CGColor endColor:[UIColor whiteColor].CGColor];
    //从Context中获取图像，并显示在界面上
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    UIImageView *imgView = [[UIImageView alloc] initWithImage:img];
    [self addSubview:imgView];
}

- (void)getControlPointx0:(CGFloat)x0 andy0:(CGFloat)y0
                       x1:(CGFloat)x1 andy1:(CGFloat)y1
                       x2:(CGFloat)x2 andy2:(CGFloat)y2
                       x3:(CGFloat)x3 andy3:(CGFloat)y3
                     path:(UIBezierPath*)path {
    CGFloat smooth_value =0.6;
    CGFloat ctrl1_x;
    CGFloat ctrl1_y;
    CGFloat ctrl2_x;
    CGFloat ctrl2_y;
    CGFloat xc1 = (x0 + x1) /2.0;
    CGFloat yc1 = (y0 + y1) /2.0;
    CGFloat xc2 = (x1 + x2) /2.0;
    CGFloat yc2 = (y1 + y2) /2.0;
    CGFloat xc3 = (x2 + x3) /2.0;
    CGFloat yc3 = (y2 + y3) /2.0;
    CGFloat len1 = sqrt((x1-x0) * (x1-x0) + (y1-y0) * (y1-y0));
    CGFloat len2 = sqrt((x2-x1) * (x2-x1) + (y2-y1) * (y2-y1));
    CGFloat len3 = sqrt((x3-x2) * (x3-x2) + (y3-y2) * (y3-y2));
    CGFloat k1 = len1 / (len1 + len2);
    CGFloat k2 = len2 / (len2 + len3);
    CGFloat xm1 = xc1 + (xc2 - xc1) * k1;
    CGFloat ym1 = yc1 + (yc2 - yc1) * k1;
    CGFloat xm2 = xc2 + (xc3 - xc2) * k2;
    CGFloat ym2 = yc2 + (yc3 - yc2) * k2;
    ctrl1_x = xm1 + (xc2 - xm1) * smooth_value + x1 - xm1;
    ctrl1_y = ym1 + (yc2 - ym1) * smooth_value + y1 - ym1;
    ctrl2_x = xm2 + (xc2 - xm2) * smooth_value + x2 - xm2;
    ctrl2_y = ym2 + (yc2 - ym2) * smooth_value + y2 - ym2;
    [path addCurveToPoint:CGPointMake(x2, y2) controlPoint1:CGPointMake(ctrl1_x, ctrl1_y) controlPoint2:CGPointMake(ctrl2_x, ctrl2_y)];
}

- (void)drawLinearGradient:(CGContextRef)context
                      path:(CGPathRef)path
                startColor:(CGColorRef)startColor
                  endColor:(CGColorRef)endColor {
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGFloat locations[] = {0.2, 1.0};
    
    NSArray *colors = @[(__bridge id) startColor, (__bridge id) endColor];
    
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef) colors, locations);
    
    
    CGRect pathRect = CGPathGetBoundingBox(path);
    
    //具体方向可根据需求修改
    CGPoint startPoint = CGPointMake(CGRectGetMidX(pathRect), CGRectGetMinY(pathRect));
    CGPoint endPoint = CGPointMake(CGRectGetMidX(pathRect), CGRectGetMaxY(pathRect));
    
    CGContextSaveGState(context);
    CGContextAddPath(context, path);
    CGContextClip(context);
    CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, 0);
    CGContextRestoreGState(context);
    
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorSpace);
}

@end
