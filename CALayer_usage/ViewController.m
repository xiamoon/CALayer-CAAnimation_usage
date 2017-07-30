//
//  ViewController.m
//  CALayer_usage
//
//  Created by 李乾 on 2017/7/29.
//  Copyright © 2017年 liqian. All rights reserved.
//

#import "ViewController.h"

#define WIDTH 80.0

@interface ViewController () <CALayerDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self drawMyLayer];
}

- (void) drawMyLayer {
    CGSize size = [UIScreen mainScreen].bounds.size;
    
    // 加阴影
    CALayer *shadowLayer = [CALayer new];
    shadowLayer.backgroundColor = [UIColor redColor].CGColor;
    shadowLayer.bounds = (CGRect){{0, 0}, {WIDTH, WIDTH}};
    shadowLayer.position = (CGPoint){size.width/2.0, size.height/2.0};
    shadowLayer.cornerRadius = WIDTH/2.0;
    shadowLayer.shadowOpacity = .9;
    shadowLayer.shadowColor = [UIColor grayColor].CGColor;
    shadowLayer.shadowOffset = CGSizeMake(5, 5);
    [self.view.layer addSublayer:shadowLayer];
    
    
    CALayer *layer = [CALayer new];
    layer.backgroundColor = [UIColor colorWithRed:0 green:146.0/255 blue:1.0 alpha:1.0].CGColor;
    layer.position = CGPointMake(size.width/2.0, size.height/2.0);
    layer.bounds = CGRectMake(0, 0, WIDTH, WIDTH);
    layer.cornerRadius = WIDTH/2;
    layer.masksToBounds = YES;
    layer.borderColor = [UIColor orangeColor].CGColor;
    layer.borderWidth = 1.0;
    
//    layer.transform = CATransform3DMakeRotation(M_PI, 0, 1, 0);
    [layer setValue:@M_PI forKeyPath:@"transform.rotation.x"];
    layer.delegate = self;
    [layer setNeedsDisplay];
//    UIImage *image = [UIImage imageNamed:@"1.jpg"];
//    layer.contents = (id)image.CGImage;
    
    [self.view.layer addSublayer:layer];

}

#pragma mark - CALayerDelegate
-(void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx {
    UIImage *image = [UIImage imageNamed:@"1.jpg"];
    CGContextDrawImage(ctx, (CGRect){{0, 0}, {WIDTH, WIDTH}}, image.CGImage);
}


@end
