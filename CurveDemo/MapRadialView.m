//
//  MapRadialView.m
//  CurveDemo
//
//  Created by qzwh on 2018/12/6.
//  Copyright © 2018年 qianjinjia. All rights reserved.
//

#import "MapRadialView.h"

#define kRGBAColor(r,g,b,a)     [UIColor colorWithRed:((float)(r))/255.0f green:((float)(g))/255.0f blue:((float)(b))/255.0f alpha:((float)(a))]
#define kRGBColor(r,g,b)        kRGBAColor(r,g,b,1)
#define kRandomColor            kRGBColor(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))

@interface MapRadialView ()
@property (nonatomic, assign) CGPoint endPoint;
@property (nonatomic, strong) NSArray *startPoints;
@end

@implementation MapRadialView

- (instancetype)initWithFrame:(CGRect)frame endPoint:(CGPoint)point startPoints:(NSArray *)startPoints {
    self = [super initWithFrame:frame];
    if (self) {
        self.endPoint = point;
        self.startPoints = startPoints;
        [self createUI];
    }
    return self;
}

- (void)createUI {
    self.backgroundColor = [UIColor yellowColor];
    
    for (int i = 0; i < self.startPoints.count; i++) {
        CGPoint point = CGPointFromString(self.startPoints[i]);
        UIView *circleView = [[UIView alloc] initWithFrame:CGRectMake(point.x, point.y, 4, 4)];
        circleView.backgroundColor = kRandomColor;
        circleView.layer.cornerRadius = 2;
        circleView.layer.masksToBounds = YES;
        [self addSubview:circleView];
        
        //创建路径添加动画
        [self createPathWithView:circleView startPoint:point];
    }
    
    UIView *endView = [[UIView alloc] initWithFrame:CGRectMake(self.endPoint.x, self.endPoint.y, 8, 8)];
    endView.backgroundColor = [UIColor redColor];
    endView.layer.cornerRadius = 4;
    endView.layer.masksToBounds = YES;
    [self addSubview:endView];
}

- (void)createPathWithView:(UIView *)view startPoint:(CGPoint)startPoint {
    CAShapeLayer *lineLayer = [CAShapeLayer layer];
    lineLayer.strokeColor = view.backgroundColor.CGColor;
    lineLayer.fillColor = [UIColor clearColor].CGColor;
    lineLayer.lineWidth = 1;
    
    //创建一个路径
    
    CGPoint centerPoint = CGPointMake(startPoint.x + (self.endPoint.x - startPoint.x)/2, startPoint.y + (self.endPoint.y - startPoint.y)/2);
    
    CGPoint controlPoint = CGPointZero;
    
    CGFloat x = 30;
    CGFloat specificValue = fabs(self.endPoint.x - startPoint.x) / fabs(self.endPoint.y - startPoint.y);
    if (self.endPoint.x > startPoint.x) {
        
        CGFloat y = specificValue?(x / specificValue):0;
        if (specificValue < 1) { //接近竖直
            y = 0;
        }
        
        controlPoint = CGPointMake(centerPoint.x - x, centerPoint.y + y);
    } else {

        CGFloat y = specificValue?(x / specificValue):0;
        if (specificValue < 1) {
            y = 0;
        }
        
        controlPoint = CGPointMake(centerPoint.x + x, centerPoint.y - y);
    }
    
    UIBezierPath *path = [UIBezierPath new];
    [path moveToPoint:startPoint];
    [path addQuadCurveToPoint:self.endPoint controlPoint:controlPoint];
    lineLayer.path = path.CGPath;
    [self.layer addSublayer:lineLayer];

    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"position";
    animation.path = path.CGPath;
    animation.duration = 3;
    //1.2设置动画执行完毕后，不删除动画
    animation.removedOnCompletion = NO;
    animation.repeatCount = CGFLOAT_MAX;
    animation.autoreverses = NO;
    animation.calculationMode = kCAAnimationLinear;
    animation.fillMode = kCAFillModeForwards;
    [view.layer addAnimation:animation forKey:nil];
}

@end
