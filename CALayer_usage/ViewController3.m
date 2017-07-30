
//
//  ViewController3.m
//  CALayer_usage
//
//  Created by 李乾 on 2017/7/29.
//  Copyright © 2017年 liqian. All rights reserved.
//

#import "ViewController3.h"

@interface ViewController3 ()<CAAnimationDelegate> {
    CALayer *_layer;
}

@end

@implementation ViewController3

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _layer = [CALayer new];
    _layer.bounds = CGRectMake(0, 0, 10, 20);
    _layer.position = CGPointMake(50, 150);
    _layer.backgroundColor = [UIColor greenColor].CGColor;
    _layer.anchorPoint = CGPointMake(0.5, 0.7);
    [self.view.layer addSublayer:_layer];
}

- (void)translationAnimation:(CGPoint)location {
    CABasicAnimation *basicAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
    basicAnimation.toValue = [NSValue valueWithCGPoint:location];
    basicAnimation.duration = 5.0;
    basicAnimation.removedOnCompletion = NO;
    basicAnimation.delegate = self;
    [basicAnimation setValue:[NSValue valueWithCGPoint:location] forKey:@"myCustomizeKey"];
    [_layer addAnimation:basicAnimation forKey:@"animation1"];
}

- (void)rotationAnimation {
    CABasicAnimation *baseAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    baseAnimation.toValue = [NSNumber numberWithFloat:M_PI*(2.0/3)];
    baseAnimation.duration = 6.0;
    baseAnimation.autoreverses = YES;
    baseAnimation.repeatCount = INFINITY;
    baseAnimation.removedOnCompletion = NO;
    [_layer addAnimation:baseAnimation forKey:@"animation2"];
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self.view];
    
    CAAnimation *animation = [_layer animationForKey:@"animation1"];
    if (animation) {
        if (_layer.speed == 0) {
            [self animationResume];
        }else {
            [self animationPause];
        }
    }else {
        [self translationAnimation:point];
        [self rotationAnimation];
    }
}

- (void)animationPause {
    CFTimeInterval interval = [_layer convertTime:CACurrentMediaTime() fromLayer:nil];
    [_layer setTimeOffset:interval]; // 停在当前时间
    _layer.speed = 0;
}

- (void)animationResume {
    CFTimeInterval beginTime = CACurrentMediaTime() - _layer.timeOffset;
    _layer.timeOffset = 0;
    _layer.beginTime = beginTime;
    _layer.speed = 1.0;
}

#pragma mark - CAAnimationDelegate
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    NSLog(@"flag : %@", @(flag));
//    NSLog(@"_layer`s current position : %@", NSStringFromCGPoint(_layer.position));
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    // 对这部分设置禁止隐式动画
    _layer.position = [[anim valueForKey:@"myCustomizeKey"] CGPointValue];
    [CATransaction commit];
}

@end
