//
//  ViewController.m
//  CurveDemo
//
//  Created by qzwh on 2018/11/11.
//  Copyright © 2018年 qianjinjia. All rights reserved.
//

#import "ViewController.h"
#import "CurveView.h"
#import "NSObject+SXRuntime.h"
#import "MapRadialView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
//    CurveView *curveView = [[CurveView alloc] initWithFrame:CGRectMake(0, 200, self.view.frame.size.width, 400) dataArr:@[@(1), @(4), @(2), @(10), @(6), @(9), @(8), @(6), @(-5), @(4), @(2)]];
//    [self.view addSubview:curveView];
    
    MapRadialView *mapView = [[MapRadialView alloc] initWithFrame:CGRectMake(0, 200, self.view.frame.size.width, 300) endPoint:CGPointMake(self.view.frame.size.width/2, 150) startPoints:@[NSStringFromCGPoint(CGPointMake((self.view.frame.size.width/2)-40, 10)), NSStringFromCGPoint(CGPointMake(self.view.frame.size.width/2, 50)), NSStringFromCGPoint(CGPointMake(300, 150)), NSStringFromCGPoint(CGPointMake(self.view.frame.size.width/2, 280))]];
    [self.view addSubview:mapView];
    
    [[self class] swizzleInstanceMethodWithOriginSel:@selector(oriMethod) swizzledSel:@selector(myMethod)];
}

- (void)oriMethod {
    NSLog(@"========");
}

- (void)myMethod {
    [self myMethod];
    NSLog(@"------");
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self oriMethod];
}

@end
