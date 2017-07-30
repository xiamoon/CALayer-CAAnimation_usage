//
//  ViewController2.m
//  CALayer_usage
//
//  Created by 李乾 on 2017/7/29.
//  Copyright © 2017年 liqian. All rights reserved.
//

#import "ViewController2.h"

@interface ViewController2 ()

@end

@implementation ViewController2

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor orangeColor];
    view.frame = (CGRect){{100, 100}, {100, 100}};
    [self.view addSubview:view];
    
    [UIView animateWithDuration:3 delay:2 options:0 animations:^{
        view.frame = (CGRect){{100, 200}, {100, 100}};
    } completion:^(BOOL finished) {
        CGRect rect = view.frame;
        NSLog(@"view`s frame : %@", NSStringFromCGRect(rect));
    }];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
