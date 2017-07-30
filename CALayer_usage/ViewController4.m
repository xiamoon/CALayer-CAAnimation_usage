
//
//  ViewController4.m
//  CALayer_usage
//
//  Created by 李乾 on 2017/7/30.
//  Copyright © 2017年 liqian. All rights reserved.
//

#import "ViewController4.h"

@interface ViewController4 ()<CAAnimationDelegate> {
    CALayer *_layer;
}

@end

@implementation ViewController4

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _layer = [CALayer new];
    _layer.bounds = CGRectMake(0, 0, 10, 20);
    _layer.position = CGPointMake(50, 150);
    _layer.backgroundColor = [UIColor greenColor].CGColor;
    _layer.anchorPoint = CGPointMake(0.5, 0.7);
    [self.view.layer addSublayer:_layer];
}

- (void)translationAnimation {
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    NSValue *key1 = [NSValue valueWithCGPoint:_layer.position];
    NSValue *key2 = [NSValue valueWithCGPoint:CGPointMake(80, 220)];
    NSValue *key3 = [NSValue valueWithCGPoint:CGPointMake(45, 300)];
    NSValue *key4 = [NSValue valueWithCGPoint:CGPointMake(55, 400)];
    NSArray *values = @[key1, key2, key3, key4];
    animation.values = values;
    animation.duration = 8.0;
    animation.beginTime = CACurrentMediaTime() + 1; // 延迟1秒
    animation.calculationMode = kCAAnimationCubicPaced; // 使得关键帧更平滑
    
    // 但是position不会改变
    animation.removedOnCompletion = NO; // 完成后不移除状态，需要同下面一句代码一起才会有效
    animation.fillMode = kCAFillModeForwards; // 保持完成后的状态
    
    animation.delegate = self;
    [_layer addAnimation:animation forKey:@"anim_position"];
}

- (void)translationAnimationWithPath {
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, _layer.position.x, _layer.position.y);
    CGPathAddCurveToPoint(path, NULL, 160, 280, -30, 300, 55, 400);
    
    animation.path = path;
    CGPathRelease(path);
    
    animation.duration = 8.0;
    animation.beginTime = CACurrentMediaTime() + 1;
    [_layer addAnimation:animation forKey:@"anim_position_path"];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    //[self translationAnimation];
    [self translationAnimationWithPath];
}

#pragma mark - CAAnimationDelegate
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    NSLog(@"flag : %@", @(flag));
    NSLog(@"_layer`s current position : %@", NSStringFromCGPoint(_layer.position));
}

@end
